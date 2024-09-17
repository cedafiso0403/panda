import 'package:flutter/material.dart';
import 'package:panda/src/features/events/models/event_model.dart';
import 'package:panda/src/features/events/providers/events_provider.dart';
import 'package:provider/provider.dart';

class EventForm extends StatefulWidget {
  const EventForm({Key? key}) : super(key: key);

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _organizerController = TextEditingController();
  final TextEditingController _eventTypeController = TextEditingController();

  EventModel? _event;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _event = super.context.read<EventsProvider>().selectedEvent;
    // If editing an event, populate the form with the event data
    if (_event != null) {
      _titleController.text = _event!.title;
      _descriptionController.text = _event!.description;
      _locationController.text = _event!.location;
      _organizerController.text = _event!.organizer;
      _eventTypeController.text = _event!.eventType;
      _selectedDate = _event!.date;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _organizerController.dispose();
    _eventTypeController.dispose();
    super.dispose();
  }

  // Method to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newEvent = EventModel(
        id: _event?.id ??
            '', // Use existing id if editing, otherwise generate a new id on the backend
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        date: _selectedDate,
        location: _locationController.text.trim(),
        organizer: _organizerController.text.trim(),
        eventType: _eventTypeController.text.trim(),
      );

      if (_event == null) {
        // Create a new event
        context.read<EventsProvider>().createEvent(newEvent);
      } else {
        // Edit an existing event
        context.read<EventsProvider>().updateEvent(newEvent);
      }

      Navigator.pop(context); // Go back to the previous screen after submission
    }
  }

  // Date picker method
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(
        () {
          _selectedDate = picked;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _event == null ? 'Create Event' : 'Edit Event',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title Input
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    if (value.length < 3) {
                      return 'Title must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
              ),

              // Description Input
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    if (value.length < 10) {
                      return 'Description must be at least 10 characters long';
                    }
                    return null;
                  },
                ),
              ),

              // Location Input
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
              ),

              // Organizer Input
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _organizerController,
                  decoration: const InputDecoration(
                    labelText: 'Organizer',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an organizer';
                    }
                    return null;
                  },
                ),
              ),

              // Event Type Input
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _eventTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Event Type',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an event type';
                    }
                    return null;
                  },
                ),
              ),

              // Date Picker for Event Date
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                      'Event Date: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
                  trailing: const Icon(
                    Icons.calendar_today,
                  ),
                  onTap: () => _selectDate(context),
                ),
              ),

              // Submit Button
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(_event == null ? 'Create Event' : 'Update Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
