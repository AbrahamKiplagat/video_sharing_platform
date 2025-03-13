import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  Navbar(this.context); // Constructor to accept context

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check screen width to determine layout
        bool isSmallScreen = constraints.maxWidth < 600; // Adjust breakpoint as needed

        return AppBar(
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu), // Menu bar icon
                onPressed: () {
                  // Add functionality for menu button
                },
              ),
              SizedBox(width: 8), // Spacing between menu icon and app name
              Text(
                'Nivir', // App name
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: isSmallScreen
              ? [
                  // Icons only on small screens
                  IconButton(
                    icon: Icon(Icons.upload), // Upload icon
                    onPressed: () {
                      // Add functionality for upload button
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications), // Notification icon
                    onPressed: () {
                      // Add functionality for notification button
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.settings), // Settings icon
                    onPressed: () {
                      // Add functionality for settings button
                    },
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/user_profile.png'), // User profile image
                    radius: 16,
                  ),
                  SizedBox(width: 8), // Spacing for the end
                ]
              : [
                  // Search bar and icons on larger screens
                  Container(
                    width: constraints.maxWidth * 0.4, // Responsive width (40% of screen width)
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search), // Search icon
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.upload), // Upload icon
                    onPressed: () {
                      // Add functionality for upload button
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications), // Notification icon
                    onPressed: () {
                      // Add functionality for notification button
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.settings), // Settings icon
                    onPressed: () {
                      // Add functionality for settings button
                    },
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/user_profile.png'), // User profile image
                    radius: 16,
                  ),
                  SizedBox(width: 8), // Spacing for the end
                ],
          bottom: isSmallScreen
              ? PreferredSize(
                  preferredSize: Size.fromHeight(60), // Height for the search bar
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search), // Search icon
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                    ),
                  ),
                )
              : null, // No bottom bar on larger screens
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 60); // Adjust height for search bar
}