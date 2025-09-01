
# Breach App

## Overview

Breach is a Flutter application designed with a modular architecture and clean state management using **BLoC** and **dependency injection** via `injectable`.

The app integrates multiple features, including blogs, authentication, and home modules, while maintaining a scalable folder structure for future growth.

## Key Features

* **Authentication**: Secure login with token-based persistence.
* **Blog Module**: Fetches, displays, and streams real-time blog updates.
* **State Management**: Consistent UI logic handled through **BLoC / Cubit**.
* **Local Data Layer**: Token storage and minor caching.
* **Error Handling & Logging**: Centralized `AppLogger` utility for debugging.

## WebSocket Integration

The app includes a **real-time stream** of blog posts via a WebSocket connection.

* Establishes connection with a user token.
* Listens for new messages and updates the UI live.
* Handles connection lifecycle (`connecting → connected → disconnected`).
* **Auto-reconnects** when the connection drops.

## Tech Stack

* **Flutter** (cross-platform)
* **BLoC / Cubit** for state management
* **Injectable + GetIt** for DI
* **WebSocketChannel** for real-time updates
* **Secure storage** for managing token and user data

## Project Structure

```
lib/
 ├── core/              # Common utilities, error handling, local data
 ├── features/
 │    ├── auth/         # Authentication
 │    ├── blog/         # Blog (presentation, sockets, UI)
 │    └── home/         # Home module
 └── main.dart          # App entry point
```

## Getting Started

1. Clone the repository

   ```bash
   git clone https://github.com/edkluivert/breach.git
   cd breach
   ```
2. Install dependencies

   ```bash
   flutter pub get
   ```
3. Run the app

   ```bash
   flutter run
   ```

---

