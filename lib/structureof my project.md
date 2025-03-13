📦 Video Sharing Platform
│
├── 👤 User (▭ Account Created)
│   ├── 🎥 Videos (▭ Upload Progress)
│   │   ├── 📂 Uploaded Videos 
│   │   ├── 🏷️ Category (▭ Can Be Changed)
│   │   ├── 👀 Views, 👍 Likes, 💬 Comments (▭ Engagement Progress)
│   ├── 💳 Subscription & Payments
│   │   ├── 🏷️ Subscription (▭ Active/Expired)
│   │   ├── 💰 Payment History (▭ Tracked Earnings)
│   │   ├── 💼 Wallet (▭ Available Balance)
│   │   ▲ Choose a Category  
│   │   ▲ Confirm Subscription  
│   │   ▲ Complete Payment  
│   ├── 📂 Playlists & Watch History
│   │   ├── 🎵 Playlist (▭ Creation Progress)
│   │   ├── ⏳ Watch History (▭ Last Watched)
│   ├── 💰 Monetization
│   │   ├── 💖 Thanks Button (▭ Creator Earnings)
│   │   ├── 📢 Ad Revenue (▭ Watch Progress)
│   │   ▲ Reach Monetization Threshold  
│   │   ▲ Set Up Payment Info  
│   │   ▲ Request Payout  
│   ├── 🔎 Search
│   │   ├── 🔍 By Video  
│   │   ├── 🏷️ By Category  
│   ├── 🎬 Video Controls
│   │   ├── 🔁 Loop Video  
│   │   ├── ⏩ Playback Speed  
│   │   ├── 🎥 Video Quality  
│   │   ├── 🎭 Captions (CC)  
│   │   ├── 🔒 Lock Screen Mode  
│
└── 🛠️ Admin (▭ Dashboard Progress)
    ├── 👤 Manage Users
    │   ├── 🚫 Ban / ❌ Delete Users  
    │   ├── 👀 View Subscription Status (▭ User Insights)  
    │   ├── 💳 Payout Earnings (▭ Payout History)  
    │   ▲ Review User Reports  
    │   ▲ Take Action (Ban/Delete)  
    ├── 🎥 Manage Videos
    │   ├── 🗑️ Delete Videos (▭ Moderation Progress)  
    │   ├── ⚠️ Flag Copyright Content  
    │   ├── 🔞 Remove Adult Content  
    │   ▲ Review Reports  
    │   ▲ Verify Violations  
    │   ▲ Take Action  
    ├── 💳 Handle Payments
    │   ├── ✅ Approve Payouts (▭ Pending Transactions)  
    │   ├── 🏦 View Transactions  
    │   ▲ Verify Payment Request  
    │   ▲ Approve or Reject  
    ├── 📢 Platform Moderation
    │   ├── 🛑 Review Complaints (▭ Case Progress)  
    │   ├── 📂 Approve Categories  
    │   ├── 💰 Monitor Ad Revenue  
    │   ▲ Receive Complaint  
    │   ▲ Investigate Case  
    │   ▲ Take Action  
    ├── 📊 Dashboard
        ├── 👥 Total Users  
        ├── 🎥 Total Videos  
        ├── 💵 Revenue Reports  
        ├── 🏷️ Active Subscriptions  
# Video Sharing Platform Models

## User Model
- **UserID** (Primary Key)
- **Username**
- **Email**
- **Password**
- **Subscription Status**
- **Wallet Balance**
- **Profile Picture**
- **Created At**
- **Updated At**

## Video Model
- **VideoID** (Primary Key)
- **Title**
- **Description**
- **File URL**
- **Uploader (UserID - Foreign Key)**
- **Category**
- **Views**
- **Likes**
- **Dislikes**
- **Comments Enabled**
- **Monetization Enabled**
- **Upload Date**

## Subscription Model
- **SubscriptionID** (Primary Key)
- **UserID** (Foreign Key)
- **Subscription Type (Category-based / Full Subscription)**
- **Start Date**
- **End Date**
- **Price Paid**

## Payment Model
- **PaymentID** (Primary Key)
- **UserID** (Foreign Key)
- **Amount Paid**
- **Payment Method (Zerotize.in, etc.)**
- **Transaction ID**
- **Payment Date**

## Ad Model
- **AdID** (Primary Key)
- **Advertiser Name**
- **Ad Type (Banner, Skippable, Non-Skippable, Overlay, etc.)**
- **Target Audience**
- **Start Date**
- **End Date**
- **Price Paid**

## Payout Model
- **PayoutID** (Primary Key)
- **UserID** (Foreign Key - Content Creator)
- **Amount Earned**
- **Withdrawal Method**
- **Payout Status**
- **Date Processed**

## Playlist Model
- **PlaylistID** (Primary Key)
- **UserID** (Foreign Key)
- **Playlist Name**
- **Videos (Array of VideoIDs)**
- **Created Date**

## Live Streaming Model
- **LiveStreamID** (Primary Key)
- **UserID** (Foreign Key - Content Creator)
- **Stream Title**
- **Start Time**
- **End Time**
- **Viewers Count**

## Comment Model
- **CommentID** (Primary Key)
- **UserID** (Foreign Key)
- **VideoID** (Foreign Key)
- **Comment Text**
- **Timestamp**
- **Likes**
- **Replies (Nested Comments)**

## Admin Model
- **AdminID** (Primary Key)
- **Username**
- **Email**
- **Password**
- **Permissions (User Management, Video Removal, etc.)**
- **Created Date**

## Reporting Model (For Inappropriate Content)
- **ReportID** (Primary Key)
- **UserID (Reporter)**
- **Reported VideoID**
- **Report Reason**
- **Status (Pending, Resolved, Rejected)**
- **Reviewed By (AdminID - Foreign Key)**

## Features Implemented
✅ Subscription-based model (pay-per-category & full access)
✅ Ad-supported access
✅ Payment & Payout System
✅ Shuffle Button (Random Video Selection)
✅ Admin Dashboard for User & Video Management
✅ Copyright & Content Moderation
✅ Trial Period (Category Recommendations)
✅ Offline Downloads & Background Play
✅ Playlist Management
✅ Live Streaming
✅ Video Search & Category Filters
✅ Channel Subscriptions & "Thanks" Button for Donations
✅ Video Loop, Playback Speed Control & Quality Settings
✅ Caption Support (CC)
✅ Lock Screen Protection
✅ Content Creators Can Change Categories Post-Upload
# Video Sharing Platform - Data Models

## User Model
```json
{
  "id": "unique_user_id",
  "name": "User Name",
  "email": "user@example.com",
  "password": "hashed_password",
  "subscription": {
    "status": "active/inactive",
    "plan": "per-category/full-access",
    "categories_subscribed": ["category_id1", "category_id2"],
    "expiry_date": "YYYY-MM-DD"
  },
  "wallet_balance": 100.0,
  "watch_history": ["video_id1", "video_id2"],
  "favorites": ["video_id3", "video_id4"],
  "playlists": [
    {
      "id": "playlist_id1",
      "name": "My Playlist",
      "videos": ["video_id5", "video_id6"]
    }
  ]
}
```

## Video Model
```json
{
  "id": "unique_video_id",
  "title": "Video Title",
  "description": "Video description here...",
  "category": "category_id",
  "uploader": "user_id",
  "upload_date": "YYYY-MM-DD",
  "views": 1000,
  "likes": 500,
  "dislikes": 20,
  "comments": [
    {
      "user_id": "user_id1",
      "comment": "Great video!",
      "timestamp": "YYYY-MM-DD HH:MM"
    }
  ],
  "price": 0.1,  
  "status": "approved/pending/rejected",
  "live_stream": false
}
```

## Subscription Model
```json
{
  "id": "subscription_id",
  "user_id": "unique_user_id",
  "plan": "per-category/full-access",
  "categories": ["category_id1", "category_id2"],
  "price": 4.0,
  "start_date": "YYYY-MM-DD",
  "expiry_date": "YYYY-MM-DD"
}
```

## Payment Model
```json
{
  "id": "payment_id",
  "user_id": "unique_user_id",
  "amount": 120.0,
  "method": "Zerotize.in",
  "status": "completed/pending/failed",
  "timestamp": "YYYY-MM-DD HH:MM"
}
```

## Admin Model
```json
{
  "id": "admin_id",
  "name": "Admin Name",
  "email": "admin@example.com",
  "password": "hashed_password",
  "permissions": ["delete_video", "ban_user", "manage_payments"]
}
```

## Features Included
- **Shuffle Button**: Randomly plays videos.
- **Ad-Supported Access**: Free users watch ads.
- **Offline Downloads**: Premium users can download videos.
- **Background Play**: Audio plays while using other apps.
- **Go Live**: Users can stream live videos.
- **Search**: Videos and categories are searchable.
- **Thanks Button**: Users can tip creators.
- **Loop Video**: Repeat the same video.
- **Playback Speed**: Adjust video speed.
- **Video Quality**: Change video resolution.
- **Lock Screen**: Locks controls while playing.

This structure ensures efficient management of users, payments, videos, and admin functionalities. Let me know if you need modifications! 🚀
1. Razopay payement method for the project
2. Implement the youtube api for the project.

