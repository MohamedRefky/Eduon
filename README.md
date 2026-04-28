<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=30&duration=3000&pause=1000&color=4285F4&center=true&vCenter=true&width=500&lines=Eduon+%F0%9F%93%9A;Your+Smart+Learning+Platform" alt="Typing SVG" />

<br/>

**A modern, cross-platform educational app built with Flutter — empowering learners to grow.**

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-%23039BE5.svg?style=for-the-badge&logo=firebase&logoColor=white)](https://firebase.google.com/)
[![YouTube API](https://img.shields.io/badge/YouTube_API-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://developers.google.com/youtube)

[![License](https://img.shields.io/badge/License-All%20Rights%20Reserved-red?style=flat-square)](https://github.com/MohamedRefky/Eduon)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green?style=flat-square&logo=android)](https://flutter.dev/)
[![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=flat-square)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square)](https://github.com/MohamedRefky/Eduon/pulls)

</div>

---

## 📖 About Eduon

**Eduon** is a comprehensive, cross-platform mobile learning application built with **Flutter & Dart**. It delivers a seamless educational experience by bringing together curated YouTube courses, structured learning paths, AI-powered assistance, and community activities — all in one elegant app.

> 💡 *"Learning is not a destination, it's a continuous journey."*

---

## ✨ Features Overview

<table>
  <tr>
    <td align="center"><b>🎓 Courses</b></td>
    <td align="center"><b>🗺️ Learning Paths</b></td>
    <td align="center"><b>🎯 Activities</b></td>
    <td align="center"><b>⚙️ General</b></td>
  </tr>
  <tr>
    <td>
      🔍 Smart Course Search<br/>
      🗂️ Category Browsing<br/>
      🎬 Playlist Viewer<br/>
      📊 Progress Tracking
    </td>
    <td>
      🛣️ Structured Roadmaps<br/>
      🧩 Multi-Course Tracks<br/>
      🏆 Career-Focused Paths
    </td>
    <td>
      🌐 IEEE Student Branch<br/>
      🎓 Fares Toson Academy<br/>
      💻 Microsoft Student Club<br/>
      🔵 Google Dev Groups<br/>
      🤖 Robotics & ICPC
    </td>
    <td>
      🔐 Firebase Auth<br/>
      👤 Profile Management<br/>
      🤖 AI Integration<br/>
      🌙 Dark & Light Mode<br/>
      🔔 Local Notifications
    </td>
  </tr>
</table>

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| **UI Framework** | Flutter (Dart) |
| **State Management** | BLoC / Cubit |
| **Backend & Auth** | Firebase (Auth, Firestore) |
| **Notifications** | flutter_local_notifications (Local Scheduling) |
| **Video Content** | YouTube Data API v3 |
| **AI Features** | OpenRouter API (Ready-to-use LLM models) |

---

## 📂 Project Structure

```
eduon/
├── lib/
│   ├── core/                        # App-wide shared code
│   │   ├── constants/               # App-wide constants (colors, strings, etc.)
│   │   ├── firebase/                # Firebase initialization & helpers
│   │   ├── service/                 # API service layer (HTTP, YouTube API)
│   │   ├── theme/                   # Light & Dark theme configuration
│   │   ├── utils/                   # Utility functions & extensions
│   │   └── widgets/                 # Reusable global widgets
│   │
│   ├── features/
│   │   ├── splash/                  # Splash screen (app entry point)
│   │   │   └── splash_screen.dart
│   │   │
│   │   ├── onboarding/              # Onboarding flow for new users
│   │   │   └── onboarding_screen.dart
│   │   │
│   │   ├── year_selection/          # Academic year selection screen
│   │   │   ├── widgets/
│   │   │   └── year_selection_screen.dart
│   │   │
│   │   ├── auth/                    # Authentication (Login & Registration)
│   │   │   ├── cubit/               # Auth state management (Cubit)
│   │   │   ├── data/                # Auth models & repository
│   │   │   ├── screens/             # Login & Register screens
│   │   │   └── widgets/             # Auth-specific UI components
│   │   │
│   │   ├── main/                    # Main screen with bottom navigation
│   │   │   └── main_screen.dart
│   │   │
│   │   ├── home/                    # Home screen & popular courses
│   │   │   ├── widgets/
│   │   │   └── home_screen.dart
│   │   │
│   │   ├── courses/                 # Course listing, search & categories
│   │   │   ├── bloc/                # Courses state management (BLoC)
│   │   │   ├── data/                # Course models & data sources
│   │   │   ├── widgets/             # Course card, filter, search UI
│   │   │   └── courses_screen.dart
│   │   │
│   │   ├── courses_details/         # Course details & playlist info
│   │   │   ├── cubit/               # Course details state management
│   │   │   ├── widgets/
│   │   │   └── courses_details_screen.dart
│   │   │
│   │   ├── video/                   # YouTube video player & progress
│   │   │   ├── cubit/               # Video playback state management
│   │   │   ├── widgets/
│   │   │   └── video_screen.dart
│   │   │
│   │   ├── learning_path/           # Structured learning roadmaps
│   │   │   ├── data/                # Learning path models & data
│   │   │   ├── widgets/
│   │   │   └── learning_path_screen.dart
│   │   │
│   │   ├── activities/              # Educational communities & orgs
│   │   │   ├── constants/           # Activities links & data
│   │   │   ├── cubit/               # Activities state management
│   │   │   ├── widget/
│   │   │   └── activities_screen.dart
│   │   │
│   │   ├── eduon_ai/                # Built-in AI assistant feature
│   │   │   ├── cubit/               # AI state management
│   │   │   ├── data/                # AI models & API integration
│   │   │   ├── screen/
│   │   │   └── widgets/
│   │   │
│   │   ├── reminders/               # Study reminders & local notifications
│   │   │   ├── cubit/               # Reminders state management
│   │   │   ├── data/                # Reminder models & scheduling
│   │   │   ├── screens/
│   │   │   └── widgets/
│   │   │
│   │   ├── student_guide/           # Student tips & guidance content
│   │   │   └── student_guide_screen.dart
│   │   │
│   │   └── profile/                 # User profile & settings
│   │       ├── cubit/               # Profile state management
│   │       ├── widgets/
│   │       └── profile_screen.dart
│   │
│   └── main.dart                    # App entry point & Firebase init
│
├── assets/                          # Images, fonts & static resources
├── android/                         # Android-specific config
├── ios/                             # iOS-specific config
└── pubspec.yaml                     # Dependencies & project metadata
```

---

## 🚀 Getting Started

### ✅ Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>= 3.0.0)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- A Firebase project with **Authentication** and **Firestore** enabled
- A valid **YouTube Data API v3** key

### 📦 Installation

**1. Clone the repository:**
```bash
git clone https://github.com/MohamedRefky/Eduon.git
cd Eduon
```

**2. Install Flutter dependencies:**
```bash
flutter pub get
```

**3. Configure Firebase:**
- Add your `google-services.json` to `android/app/`
- Add your `GoogleService-Info.plist` to `ios/Runner/`

**4. Add your API keys** in the appropriate config files (`.env` or constants file).

**5. Run the app:**
```bash
flutter run
```

---

## 📱 Supported Platforms

| Platform | Status |
|----------|--------|
| 🤖 Android | ✅ Supported |
| 🍎 iOS | ✅ Supported |
| 🌐 Web | 🔄 Planned |

---

## 🤝 Contributing

Contributions are always welcome! Here's how to get started:

1. 🍴 Fork the repository
2. 🌿 Create a feature branch: `git checkout -b feature/AmazingFeature`
3. 💾 Commit your changes: `git commit -m 'Add some AmazingFeature'`
4. 📤 Push to the branch: `git push origin feature/AmazingFeature`
5. 🔃 Open a Pull Request

Please follow the existing code style and write clear commit messages.

---

## 👤 Author

<div align="center">

**Mohamed Refky**

*Software Engineering Student @ iSchool*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mohamedrefky/)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/MohamedRefky)

</div>

---

## 📄 License

```
© 2026 Mohamed Refky — All Rights Reserved.
Unauthorized copying, redistribution, or modification of this project
or any portion of it is strictly prohibited without prior written permission.
```

---

<div align="center">

Made with ❤️ using **Flutter**

⭐ **If you like this project, consider giving it a star!** ⭐

</div>
