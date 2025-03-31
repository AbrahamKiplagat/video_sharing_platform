import 'package:flutter/material.dart';

class VideoGrid extends StatelessWidget {
  final List<Map<String, dynamic>> videos;

  const VideoGrid({Key? key, required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveVideoGrid(videos: videos);
  }
}

class ResponsiveVideoGrid extends StatelessWidget {
  final List<Map<String, dynamic>> videos;

  const ResponsiveVideoGrid({Key? key, required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the number of columns based on screen width
        double width = constraints.maxWidth;
        int crossAxisCount;
        
        if (width > 1200) {
          crossAxisCount = 4; // Desktop
        } else if (width > 800) {
          crossAxisCount = 3; // Tablet
        } else if (width > 500) {
          crossAxisCount = 2; // Phone
        } else {
          crossAxisCount = 1; // Small phone
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.8, // Adjust for video thumbnail aspect
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return VideoCard(video: videos[index]);
          },
        );
      },
    );
  }
}

class VideoCard extends StatelessWidget {
  final Map<String, dynamic> video;

  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          // Add navigation to video detail page
          // Navigator.push(context, MaterialPageRoute(builder: (context) => VideoDetailPage(video: video)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Image.network(
                  video['thumbnail'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / 
                              loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title'] ?? 'Untitled Video',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    video['creator'] ?? 'Unknown Creator',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    video['views'] ?? '0 views',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function to generate sample videos (optional)
List<Map<String, dynamic>> generateSampleVideos() {
  return List.generate(
    20,
    (index) => {
      'title': 'Video ${index + 1}',
      'thumbnail': 'https://picsum.photos/300/200?random=$index',
      'views': '${(index + 1) * 1000} views',
      'creator': 'Creator ${index % 5 + 1}',
      'duration': '${index % 10}:${(index % 60).toString().padLeft(2, '0')}',
    },
  );
}