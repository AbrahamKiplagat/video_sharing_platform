import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  Navbar(this.context);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth < 600;

        return AppBar(
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              const Text(
                'Nivir',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: isSmallScreen
              ? [
                  IconButton(
                    icon: const Icon(Icons.upload),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/user_profile.png'),
                    radius: 16,
                  ),
                  const SizedBox(width: 8),
                ]
              : [
                  Container(
                    width: constraints.maxWidth * 0.4,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.upload),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/user_profile.png'),
                    radius: 16,
                  ),
                  const SizedBox(width: 8),
                ],
          bottom: isSmallScreen
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                      ),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  @override
  Size get preferredSize {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 600;
    
    return Size.fromHeight(
      kToolbarHeight + (isSmallScreen ? 60 : 0) + mediaQuery.padding.top
    );
  }
}