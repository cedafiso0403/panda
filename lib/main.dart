import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panda/src/app.dart';
import 'package:panda/src/services/cloud_functions_service.dart';
import 'package:provider/provider.dart';
import 'package:panda/src/features/events/providers/events_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('----------- Error initializing Firebase: $e');
  }

  final cloudFunctionsService = CloudFunctionsService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EventsProvider(cloudFunctionsService),
          lazy: false,
        )
      ],
      child: const PandaApp(),
    ),
  );
}
