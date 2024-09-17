import 'package:flutter/material.dart';
import 'package:panda/src/features/events/models/event_model.dart';
import 'package:panda/src/features/events/providers/events_provider.dart';
import 'package:panda/src/features/events/views/details_event.dart';
import 'package:provider/provider.dart';

class EventTile extends StatelessWidget {
  final EventModel event;

  const EventTile(
    this.event, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(event.title),
        trailing: const Icon(
          Icons.keyboard_arrow_right_sharp,
        ),
        onTap: () {
          context.read<EventsProvider>().setSelectedEvent(event);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailsEvent(),
            ),
          ).then(
            (_) {
              // Clear selectedEvent when returning from the details page
              if (context.mounted) {
                context.read<EventsProvider>().clearSelectedEvent();
              }
            },
          );
        },
      ),
    );
  }
}
