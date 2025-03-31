import 'package:flutter/material.dart';
import 'package:video_sharing_platform/User/Nav bar/navbar.dart';
import 'video_grid.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> videos = List.generate(
    20,
    (index) => {
      'title': 'Video ${index + 1}',
      'thumbnail': 'https://picsum.photos/300/200?random=$index',
      'views': '${(index + 1) * 1000} views',
      'creator': 'Creator ${index % 5 + 1}',
      'duration': '${index % 10}:${(index % 60).toString().padLeft(2, '0')}',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isSmallScreen = constraints.maxWidth < 600;
          
          return Column(
            children: [
              // Spacer that accounts for different navbar heights
              SizedBox(
                height: isSmallScreen 
                  ? 8.0 // On small screens we already have search bar padding
                  : 8.0 + MediaQuery.of(context).padding.top, // On larger screens add status bar height
              ),
              
              // Categories row (only on larger screens)
              if (!isSmallScreen) 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryChip('All', true),
                        _buildCategoryChip('Trending', false),
                        _buildCategoryChip('Music', false),
                        _buildCategoryChip('Gaming', false),
                        _buildCategoryChip('News', false),
                        _buildCategoryChip('Education', false),
                      ],
                    ),
                  ),
                ),
              
              if (!isSmallScreen) const SizedBox(height: 8),
              
              // Main video grid content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: VideoGrid(videos: videos),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {},
        selectedColor: Colors.blue[100],
        checkmarkColor: Colors.blue,
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }
}