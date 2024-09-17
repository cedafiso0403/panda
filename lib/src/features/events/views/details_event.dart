import 'package:flutter/material.dart';
import 'package:panda/src/features/events/models/event_model.dart';
import 'package:panda/src/features/events/providers/events_provider.dart';
import 'package:panda/src/features/events/views/view.dart';
import 'package:panda/src/features/events/views/widgets/add_edit_button.dart'; // Assuming this widget exists
import 'package:provider/provider.dart';

class DetailsEvent extends StatelessWidget {
  const DetailsEvent({super.key});

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context2) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this event?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Delete an event will remove it permanently.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                await context.read<EventsProvider>().deleteEvent();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context2) => const ListEvents(),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context2).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    EventModel? selectedEvent = context.watch<EventsProvider>().selectedEvent;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Details',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: selectedEvent != null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      selectedEvent.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Description:",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.end,
                            selectedEvent.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                            softWrap: true,
                            overflow: TextOverflow
                                .visible, // Wrap text to prevent overflow
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Event Type:",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          selectedEvent.eventType,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location:",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          selectedEvent.location,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Organizer:",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          selectedEvent.organizer,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date:",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          selectedEvent.date.toLocal().toString().split(" ")[0],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Text(
                "No event selected",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => _showMyDialog(context),
            icon: const Icon(
              Icons.delete,
            ),
          ),
          const AddEditButton(),
        ],
      ), // Assuming this opens add/edit event form
    );
  }
}
