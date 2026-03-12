# Task Project

A Flutter mobile app built with **GetX** and **Clean Architecture** for the Taghyeer Technologies technical assignment. Consumes the [DummyJSON API](https://dummyjson.com).

## Features

- User authentication (login, cached session, auto-login, logout)
- Products listing with pagination
- Posts listing with pagination
- Product & Post detail screens
- Light/Dark theme toggle (persisted)
- Shimmer loading skeletons, error & empty states

## Architecture

```
lib/
  core/         # Theme, network, storage, constants, errors
  data/         # Models, data sources (remote/local), repository implementations
  domain/       # Entities, repository contracts, use cases
  presentation/ # Controllers, bindings, pages, widgets
  di/           # Dependency injection
  app/          # App entry, routes
```

## Tech Stack

- **State Management:** GetX
- **HTTP Client:** Dio
- **Error Handling:** dartz (Either<Failure, T>)
- **Local Storage:** SharedPreferences
- **Responsive:** flutter_screenutil
- **UI:** Google Fonts (Poppins), animate_do, shimmer, cached_network_image

## Setup

```bash
flutter pub get
flutter run
```

## Test Credentials


- **Username:** emilys
- **Password:** emilyspass
