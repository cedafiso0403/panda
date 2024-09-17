import 'package:flutter/material.dart';
import 'package:panda/src/features/events/providers/events_provider.dart';
import 'package:panda/src/features/events/views/view.dart';
import 'package:provider/provider.dart';

class AddEditButton extends StatelessWidget {
  const AddEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EventForm(),
        ),
      ),
      icon: context.read<EventsProvider>().selectedEvent != null
          ? const Icon(
              Icons.edit,
            )
          : const Icon(
              Icons.add,
            ),
    );
  }
}
