import 'package:flutter/material.dart';
import 'package:panda/src/features/events/events.dart';

class PandaApp extends StatelessWidget {
  const PandaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'Panda',
      home: const ListEvents(),
      theme: MinimalistTheme.lightTheme,
    );
  }
}

class MinimalistTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Scaffold background color
      scaffoldBackgroundColor: Colors.white,

      // Primary color palette
      primaryColor: Colors.black, // Minimalist black for primary elements
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.black,
        secondary: Colors.grey[800], // Subtle grey as the secondary color
        onPrimary: Colors.white,
        onSecondary: Colors.black,
      ),

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),

      // Text themes
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
      ),

      // Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Button color
          foregroundColor: Colors.white, // Text color on the button
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Minimalist rounded corners
          ),
        ),
      ),

      // Input decoration theme for forms
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black),
        ),
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: const TextStyle(color: Colors.black38),
      ),

      // Icon themes
      iconTheme: const IconThemeData(color: Colors.black),

      // Card theme
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2, // Minimal shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      // Floating Action Button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 2, // Minimal shadow
      ),
    );
  }
}
