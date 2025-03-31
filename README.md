# 📹 Video Sharing Platform (Flutter)

A **feature-rich video sharing application** built with Flutter, supporting both **regular video uploads** and **live streaming** with real-time chat.

## 🌟 Features

### 🎥 Video Features
- **Upload, view, and manage videos**
- Responsive video grid layout (1-4 columns based on screen size)
- Video player with fullscreen mode
- Categories & trending sections
- Search functionality

### 🔴 Live Streaming
- **RTMP & HLS live stream support**
- Real-time chat during streams
- Stream health monitoring
- Adaptive bitrate streaming

### 👤 User Features
- User profiles
- Subscriptions & monetization
- Playlists & watch history
- Like/comment/share videos

### 🛠 Admin Panel
- Manage users & videos
- Handle payments & reports
- Platform moderation tools
- Analytics dashboard

## 🗄️ Database ERD Diagram

```mermaid
erDiagram
    USER ||--o{ VIDEO : uploads
    USER ||--o{ COMMENT : writes
    USER ||--o{ SUBSCRIPTION : has
    USER ||--o{ PLAYLIST : creates
    VIDEO ||--o{ COMMENT : has
    VIDEO ||--o{ CATEGORY : belongs_to
    VIDEO ||--o{ LIKE : receives
    PLAYLIST ||--o{ VIDEO_ITEM : contains
    LIVE_STREAM ||--o{ CHAT_MESSAGE : has

    USER {
        string id PK
        string username
        string email
        string avatar_url
        datetime created_at
    }
    
    VIDEO {
        string id PK
        string user_id FK
        string title
        string description
        string video_url
        string thumbnail_url
        integer views
        datetime created_at
    }
    
    COMMENT {
        string id PK
        string user_id FK
        string video_id FK
        string content
        datetime created_at
    }
    
    PLAYLIST {
        string id PK
        string user_id FK
        string name
        string description
    }
    
    LIVE_STREAM {
        string id PK
        string user_id FK
        string stream_url
        string title
        integer viewer_count
        boolean is_live
    }
