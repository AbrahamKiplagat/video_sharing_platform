import 'package:flutter/material.dart';
import 'package:video_sharing_platform/User/homescreen.dart';
import 'package:video_sharing_platform/User/videos/uploaded_videos.dart';
import 'package:video_sharing_platform/User/videos/category.dart';
import 'package:video_sharing_platform/User/subscriptions&payements/subscription.dart';
import 'package:video_sharing_platform/User/Playlists & Watch History/playlist.dart';
import 'package:video_sharing_platform/User/Monetization/monetization.dart';
import 'package:video_sharing_platform/User/Search/search.dart';
import 'package:video_sharing_platform/User/video_controls/video_controls.dart';
import 'package:video_sharing_platform/User/Side Bar/sidebar.dart';
import 'package:video_sharing_platform/User/Nav bar/navbar.dart';
import 'package:video_sharing_platform/Admin/Manage Users/manage_users.dart';
import 'package:video_sharing_platform/Admin/Manage Videos/manage_videos.dart';
import 'package:video_sharing_platform/Admin/Handle Payments/handle_payments.dart';
import 'package:video_sharing_platform/Admin/Platform Moderation/platform_moderation.dart';
import 'package:video_sharing_platform/Admin/Dashboard/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Sharing Platform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      debugShowCheckedModeBanner: false, // Remove debug banner globally
      routes: {
        // User Routes
        '/': (context) => HomeScreen(), // Home Screen
        '/uploadedVideos': (context) => UploadedVideosScreen(), // Uploaded Videos
        '/category': (context) => CategoryScreen(), // Video Categories
        '/subscription': (context) => SubscriptionScreen(), // Subscription & Payments
        '/playlist': (context) => PlaylistScreen(), // Playlists & Watch History
        '/monetization': (context) => MonetizationScreen(), // Monetization Settings
        '/search': (context) => SearchScreen(), // Search Videos
        '/videoControls': (context) => VideoControlsScreen(), // Video Controls
        '/navbar': (context) => Navbar(), // Video Controls
        '/sidebar': (context) => Sidebar(), // Video Controls

        // Admin Routes
        '/manageUsers': (context) => ManageUsersScreen(), // Manage Users
        '/manageVideos': (context) => ManageVideosScreen(), // Manage Videos
        '/handlePayments': (context) => HandlePaymentsScreen(), // Handle Payments
        '/platformModeration': (context) => PlatformModerationScreen(), // Platform Moderation
        '/dashboard': (context) => DashboardScreen(), // Admin Dashboard
      },
    );
  }
}