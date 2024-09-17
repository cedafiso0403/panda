import 'package:flutter/material.dart';

import 'package:panda/src/features/events/providers/events_provider.dart';
import 'package:panda/src/features/events/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ListEvents extends StatelessWidget {
  const ListEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Events',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<EventsProvider>().fetchAllEvents();
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: switch (context.watch<EventsProvider>().eventsFetchingState) {
        EventsFetchingState.finished => context
                .watch<EventsProvider>()
                .events
                .isNotEmpty
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          'Filter by Event Type:',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 10),
                        Consumer<EventsProvider>(
                          builder: (context, eventProvider, child) {
                            final eventTypes = eventProvider.allEventTypes;

                            final items = eventTypes.map(
                              (String eventType) {
                                return DropdownMenuItem<String>(
                                  value: eventType,
                                  child: Text(
                                    eventType,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                );
                              },
                            ).toList();

                            items.add(
                              DropdownMenuItem<String>(
                                value: 'All',
                                child: Text(
                                  'All',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            );

                            return DropdownButton<String>(
                              value: eventProvider.selectedEventType,
                              hint: Text(
                                'Select Type',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              items: items,
                              onChanged: (String? newType) {
                                context
                                    .read<EventsProvider>()
                                    .selectFilterType(newType);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Consumer<EventsProvider>(
                      builder: (context, eventProvider, child) {
                        return ListView(
                          children: eventProvider.filteredEvents.map(
                            (event) {
                              return EventTile(event);
                            },
                          ).toList(),
                        );
                      },
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text(
                  "No events",
                ),
              ),
        EventsFetchingState.failed => const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Network error"),
            ),
          ),
        EventsFetchingState.loading => const Center(
            child: CircularProgressIndicator(),
          ),
        _ => const Center(
            child: Text(
              "No events",
            ),
          )
      },
      floatingActionButton: const AddEditButton(),
    );
  }
}
