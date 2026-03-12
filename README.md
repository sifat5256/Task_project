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

## UI

![2548abeb-d456-4920-98cf-a2bd6122b2bd](https://github.com/user-attachments/assets/d8763197-6b58-4295-be35-e5e10fdb5740)
![77ad9e6a-eb7f-4328-94d8-66821603fcdd](https://github.com/user-attachments/assets/162039e9-2a67-4065-a61a-d3fd6fbbcb50)![85397f80-f12f-4882-a912-ed391ad87bc0](https://github.com/user-attachments/assets/5bb717ab-7484-4565-8712-5694e6a0442e)
![4ee288ff-06b5-488c-82b8-b3b17652489e](https://github.com/user-attachments/assets/bdc85776-8027-4532-84bd-54ec68b65b94)![e1809b92-cb42-42f9-9619-cd47c2812d50](https://github.com/user-attachments/assets/c05efd52-67a4-4481-913b-8ea0c905a482)
![2f787dfe-65bf-46a1-82fc-a8f0658b9919](https://github.com/user-attachments/assets/d04417e2-3924-4f03-bdb4-d757059bffa9)
![c6ea975c-f78e-46b2-befc-f8aa2067bc83](https://github.com/user-attachments/assets/f6a324d6-3532-4522-8887-af3fb06b3907)

![55cfcf0b-a73a-4ec4-8d0f-2e851a368cb6](https://github.com/user-attachments/assets/8ace4739-07ce-4f57-bed2-1ddf8c2c5687)
![f1a84084-ac9d-4982-92cb-a16618d2dacb](https://github.com/user-attachments/assets/6e9a765e-22c3-4e4d-ab17-afe3910e2d93)
![1ffa6c01-0200-48ce-869c-35ff619b06f7](https://github.com/user-attachments/assets/1d0cd827-c646-4053-b010-2c0999eaad9d)
![3058ef85-6928-4247-ac03-818702a9e7af](https://github.com/user-attachments/assets/7d96498b-fae9-4043-8865-3a3635cd3145)


