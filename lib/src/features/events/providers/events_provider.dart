import 'package:flutter/foundation.dart';
import 'package:panda/src/features/events/models/models.dart';
import 'package:panda/src/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum EventsFetchingState { failed, finished, loading, initial }

class EventsProvider with ChangeNotifier {
  final CloudFunctionsService cloudFunctionsService;

  List<EventModel> _events = [];
  List<EventModel> get events => _events;

  List<EventModel> _filteredEvents = [];
  List<EventModel> get filteredEvents => _filteredEvents;

  List<String> _allEventTypes = [];
  List<String> get allEventTypes => _allEventTypes;

  String? _selectedEventType;
  String? get selectedEventType => _selectedEventType;

  EventModel? _selectedEvent;
  EventModel? get selectedEvent => _selectedEvent;

  EventsFetchingState _eventsFetchingState = EventsFetchingState.initial;
  EventsFetchingState get eventsFetchingState => _eventsFetchingState;

  EventsProvider(this.cloudFunctionsService) {
    fetchAllEvents();
    listenToEvents();
  }

  Future<void> fetchAllEvents() async {
    _setFetchingState(EventsFetchingState.loading);
    notifyListeners();
    try {
      final response = await cloudFunctionsService.getAllEventsAPI();
      final List<dynamic> eventList = response;
      _events = eventList.map((json) => EventModel.fromJson(json)).toList();
      _filteredEvents = _events;
      _setFetchingState(EventsFetchingState.finished);
      _populateEventTypes();
      notifyListeners();
    } catch (error) {
      _setFetchingState(EventsFetchingState.failed);
      _logError('Error fetching events', error);
    }
  }

  void _populateEventTypes() {
    if (_events.isNotEmpty) {
      _allEventTypes = _events.map((event) => event.eventType).toSet().toList();
    }
  }

  Future<void> createEvent(EventModel event) async {
    _setFetchingState(EventsFetchingState.loading);
    try {
      final eventData = event.toJson();
      final newEvent = await cloudFunctionsService.createEvent(eventData);
      _events.add(EventModel.fromJson(newEvent));
      _filterEvents();
      _setFetchingState(EventsFetchingState.finished);
    } catch (error) {
      _logError('Error creating event', error);
      _setFetchingState(EventsFetchingState.failed);
    }
  }

  void getAllTypes() {
    if (_events.isNotEmpty) {
      _allEventTypes = _events.map((event) => event.eventType).toSet().toList();
    }
  }

  void selectFilterType(String? type) {
    _selectedEventType = type;
    _filterEvents();
  }

  void _filterEvents() {
    _filteredEvents = _selectedEventType == null || _selectedEventType == 'All'
        ? _events
        : _events
            .where((event) => event.eventType == _selectedEventType)
            .toList();
    notifyListeners();
  }

  void setSelectedEvent(EventModel event) {
    _selectedEvent = event;
    notifyListeners();
  }

  Future<void> updateEvent(EventModel event) async {
    if (selectedEvent?.id != null) {
      try {
        await cloudFunctionsService.updateEvent(
            selectedEvent!.id, event.toJson());
        _selectedEvent = event;
      } catch (error) {
        _logError('Error updating event', error);
      }
    }
    _filterEvents();
    notifyListeners();
  }

  Future<void> deleteEvent() async {
    if (selectedEvent?.id != null) {
      try {
        await cloudFunctionsService.deleteEvent(selectedEvent!.id);
        _events.removeWhere((event) => event.id == selectedEvent!.id);
        _selectedEvent = null;
        _filterEvents();
      } catch (e) {
        _logError('Error deleting event', e);
      }
    }
    notifyListeners();
  }

  void clearSelectedEvent() {
    _selectedEvent = null;
  }

  void listenToEvents() {
    FirebaseFirestore.instance.collection('events').snapshots().listen(
      (snapshot) {
        _events = snapshot.docs.map(
          (doc) {
            return EventModel.fromJson(
              {
                "id": doc.id,
                ...doc.data(),
              },
            );
          },
        ).toList();
        _populateEventTypes();
        notifyListeners();
      },
      onError: (error) {
        _logError('Error listening to events', error);
      },
    );
  }

  void _setFetchingState(EventsFetchingState state) {
    _eventsFetchingState = state;
    notifyListeners();
  }

  void _logError(String message, dynamic error) {
    print('$message: $error'); // Consider replacing with proper logging
  }
}
