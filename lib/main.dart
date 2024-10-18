// Import necessary Flutter packages
import 'package:flutter/material.dart'; // Material design components for Flutter apps
import 'package:flutter/services.dart'; // System services, like controlling the status bar
import 'package:to_do/screens/home.dart'; // Import the Home screen of the app

// The entry point of the application
void main() {
  // Run the app
  runApp(const MyApp());
}

// MyApp class represents the main application
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    // Return a MaterialApp widget that serves as the root of the application
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner in the top right corner
      title: 'To-Do App', // Title of the app, displayed in the task manager
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set the primary color theme to blue
      ),
      home: const Home(), // Set the home screen of the app to the Home widget
    );
  }
}
