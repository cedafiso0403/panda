import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:panda/src/utils/constants.dart';

class CloudFunctionsService {
  // Function to fetch all events from Cloud Function
  Future<List<Map<String, dynamic>>> getAllEventsAPI() async {
    final url = Uri.parse('$baseUrl/getAllEvents');
    try {
      final response = await http.get(url);

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> events = responseData['data']['events'];
        return events.map((event) => event as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (error) {
      throw Exception('Error fetching events: $error');
    }
  }

  // Function to get a single event by ID
  Future<Map<String, dynamic>> getEventById(String id) async {
    final url = Uri.parse('$baseUrl/getEventById?id=$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> eventData = json.decode(response.body);
        return eventData['data'];
      } else {
        throw Exception('Failed to load event');
      }
    } catch (error) {
      throw Exception('Error fetching event: $error');
    }
  }

  // Function to create a new event via POST request
  Future<Map<String, dynamic>> createEvent(
      Map<String, dynamic> eventData) async {
    final url = Uri.parse('$baseUrl/createEvent');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(eventData),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create event');
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['data'] as Map<String, dynamic>;
    } catch (error) {
      throw Exception('Error creating event: $error');
    }
  }

  // Function to update an existing event by ID
  Future<void> updateEvent(String id, Map<String, dynamic> eventData) async {
    final url = Uri.parse('$baseUrl/updateEvent?id=$id');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(eventData),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update event');
      }
    } catch (error) {
      throw Exception('Error updating event: $error');
    }
  }

  // Function to delete an event by ID
  Future<void> deleteEvent(String id) async {
    final url = Uri.parse('$baseUrl/deleteEvent?id=$id');
    try {
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception('Failed to delete event');
      }
    } catch (error) {
      throw Exception('Error deleting event: $error');
    }
  }

  // Function to filter events by type or date
  Future<List<Map<String, dynamic>>> filterEvents(
      {String? eventType, String? date}) async {
    final queryParams = [];
    if (eventType != null) queryParams.add('eventType=$eventType');
    if (date != null) queryParams.add('date=$date');
    final queryString =
        queryParams.isNotEmpty ? '?' + queryParams.join('&') : '';

    final url = Uri.parse('$baseUrl/filterEvents$queryString');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> events = json.decode(response.body);
        return events.map((event) => event as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to filter events');
      }
    } catch (error) {
      throw Exception('Error filtering events: $error');
    }
  }
}
