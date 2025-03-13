import 'package:flutter/material.dart';
import 'package:video_sharing_platform/User/Nav bar/navbar.dart'; // Import the Navbar

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(context), // Use Navbar as the AppBar
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 60), // Add padding for AppBar and search bar
        child: Center(
          child: Text('Home Screen - Welcome to the Video Sharing Platform!'), // Body content
        ),
      ),
    );
  }
}