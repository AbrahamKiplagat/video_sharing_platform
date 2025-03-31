import 'package:flutter/material.dart';

class VideoViewScreen extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  final String creator;
  final int views;
  final String uploadDate;

  const VideoViewScreen({
    Key? key,
    required this.videoUrl,
    required this.videoTitle,
    required this.creator,
    required this.views,
    required this.uploadDate,
  }) : super(key: key);

  @override
  _VideoViewScreenState createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showComments = false;
  double _commentsPanelWidth = 0;
  bool _showFullscreen = false;
  String? _currentPlayingVideo;

  @override
  void initState() {
    super.initState();
    _currentPlayingVideo = widget.videoUrl;
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    // You can add scroll-based logic here if needed
  }

  void _playSuggestedVideo(String videoUrl) {
    setState(() {
      _currentPlayingVideo = videoUrl;
      // In a real app, you would update the video player with the new URL
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _showFullscreen
        ? _buildFullscreenView()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Video Player'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => _shareVideo(context),
                ),
                if (MediaQuery.of(context).size.width > 800)
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      setState(() {
                        _showComments = !_showComments;
                        _commentsPanelWidth = _showComments ? 350 : 0;
                      });
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.fullscreen),
                  onPressed: () {
                    setState(() {
                      _showFullscreen = true;
                    });
                  },
                ),
              ],
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1200) {
                  return _buildLargeScreenLayout();
                } else if (constraints.maxWidth > 800) {
                  return _buildMediumScreenLayout();
                } else {
                  return _buildSmallScreenLayout();
                }
              },
            ),
          );
  }

  Widget _buildFullscreenView() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: 16/9,
              child: _buildVideoPlayer(fullscreen: true),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.fullscreen_exit, color: Colors.white),
              onPressed: () {
                setState(() {
                  _showFullscreen = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeScreenLayout() {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16/9,
                child: _buildVideoPlayer(),
              ),
              _buildVideoInfo(),
              _buildSuggestedVideos(),
            ],
          ),
        ),
        // Comments overlay
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          right: 0,
          top: 0,
          bottom: 0,
          width: _commentsPanelWidth,
          child: _buildCommentsOverlay(),
        ),
      ],
    );
  }

  Widget _buildMediumScreenLayout() {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16/9,
                child: _buildVideoPlayer(),
              ),
              _buildVideoInfo(),
              _buildSuggestedVideos(),
            ],
          ),
        ),
        // Comments overlay
        if (_showComments)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 300,
            child: _buildCommentsOverlay(initialVisibleComments: 3),
          ),
      ],
    );
  }

  Widget _buildSmallScreenLayout() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: _buildVideoPlayer(),
          ),
          _buildVideoInfo(),
          _buildCommentsSection(),
          _buildSuggestedVideos(),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer({bool fullscreen = false}) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.play_circle_filled,
              size: 50,
              color: Colors.white,
            ),
          ),
          if (!fullscreen)
            Positioned(
              bottom: 10,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.fullscreen, color: Colors.white.withOpacity(0.7)),
                onPressed: () {
                  setState(() {
                    _showFullscreen = true;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.videoTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${widget.views} views',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(width: 8),
              Text(
                widget.uploadDate,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/user_profile.png'),
              ),
              const SizedBox(width: 8),
              Text(
                widget.creator,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.thumb_up),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.thumb_down),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedVideos() {
    final List<Map<String, dynamic>> suggestedVideos = List.generate(6, (index) => {
      'title': 'Suggested Video ${index + 1}',
      'creator': 'Creator ${index + 1}',
      'views': '${(index + 1) * 1000} views',
      'url': 'video_url_$index',
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suggested Videos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 : 2,
              childAspectRatio: 16/9,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: suggestedVideos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _playSuggestedVideo(suggestedVideos[index]['url']),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      const Center(child: Icon(Icons.play_arrow, size: 50)),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              suggestedVideos[index]['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 6,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              suggestedVideos[index]['creator'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                shadows: [
                                  Shadow(
                                    blurRadius: 6,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsOverlay({int initialVisibleComments = 10}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.85),
        border: Border(left: BorderSide(color: Colors.grey[800]!)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Comments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _showComments = false;
                    _commentsPanelWidth = 0;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: MediaQuery.of(context).size.width > 800 && initialVisibleComments == 3
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: initialVisibleComments,
                          itemBuilder: (context, index) {
                            return _buildCommentItem(index);
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            initialVisibleComments = 10;
                          });
                        },
                        child: const Text(
                          'View more comments',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return _buildCommentItem(index);
                    },
                  ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Add a comment...',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[800],
              suffixIcon: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {},
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[800]!.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage('assets/user_profile.png'),
              ),
              const SizedBox(width: 8),
              Text(
                'User ${index + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'This is a sample comment ${index + 1}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Comments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundImage: AssetImage('assets/user_profile.png'),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'User ${index + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('This is comment number ${index + 1}'),
                  ],
                ),
              );
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Add a comment...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shareVideo(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing video...')),
    );
  }
}