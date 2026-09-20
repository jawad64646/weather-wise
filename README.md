\# WeatherWise 🌤️

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Riverpod-00A67E?logo=riverpod&logoColor=white" />
  <img src="https://img.shields.io/badge/Dio-0175C2?logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Hive-FFC107?logo=hive&logoColor=black" />
</p>

A modern, high-performance weather application built with Flutter. \*\*WeatherWise\*\* delivers real-time weather metrics, hourly trends, daily forecasts, and search capabilities using an offline-first Clean Architecture pattern.



\---

\## 🏛️ Technical Architecture

WeatherWise strictly adheres to \*\*Clean Architecture\*\* principles and \*\*Functional Programming paradigms\*\*. The app separates concerns into three isolated layers—\*\*Domain\*\*, \*\*Data\*\*, and \*\*Presentation\*\*—ensuring high testability, scalability, and maintainability.

\`\`\`mermaid
graph TD
    subgraph Presentation Layer
        UI[UI Widgets / Screens]
        Notifier[Riverpod AsyncNotifier / Providers]
    end

    subgraph Domain Layer
        UC[Use Cases]
        RepoInt[Repository Interfaces]
        Entity[Domain Entities]
    end

    subgraph Data Layer
        RepoImpl[Repository Implementation]
        RemoteDS[Remote Data Source - Open-Meteo API]
        LocalDS[Local Data Source - Hive / SharedPrefs]
        Model[Data Models & Mappers]
    end

    UI -->|Listens & Dispatches| Notifier
    Notifier -->|Executes| UC
    UC -->|Calls| RepoInt
    RepoImpl ..|> RepoInt
    RepoImpl -->|Fetches / Caches| RemoteDS
    RepoImpl -->|Persists / Reads| LocalDS
    RemoteDS -->|Returns| Model
    Model -->|Maps to| Entity
    RepoImpl -->|Returns Either Failure, Entity| UC

\`\`\`

\### Architectural Highlights

\* \*\*Functional Error Handling:\*\* Uses \`fpdart\`'s \`Either\<Failure, Success>\` to enforce explicit error handling at compile time without relying on runtime exceptions.
\* \*\*Reactive State Management:\*\* \*\*Riverpod\*\* manages asynchronous states (\`AsyncNotifier\`), seamlessly projecting loading, data, and error states directly to UI layers.
\* \*\*Dependency Injection:\*\* Centralized via providers to decouple service instantiations from business logic.

\---

\## 📂 Project Structure

The project follows a feature-first organizational layout alongside dedicated \`core\` and \`common\` infrastructure directories:

\`\`\`text
lib/
├── main.dart
├── core/
│   ├── configs/          # API endpoints, assets, color schemes
│   ├── network/            # Dio configuration and interceptors
│   └── utils/              # Extensions, formatters, and helpers
├── common/
│   ├── theme/              # Light and Dark theme configurations
│   └── widgets/            # Generic reusable UI components
└── features/
    ├── weather/            # Current, hourly, and daily weather feature
    │   ├── data/
    │   │   ├── datasources/ # Weather remote & local data sources
    │   │   ├── models/      # Weather models & JSON serialization
    │   │   └── repositories/# Weather repository implementations
    │   ├── domain/
    │   │   ├── entities/    # Weather entities (Pure Dart)
    │   │   ├── repositories/# Abstract weather repositories
    │   │   └── usecases/    # FetchCurrentWeather, FetchForecast, etc.
    │   └── presentation/
    │       ├── providers/   # Riverpod AsyncNotifiers
    │       ├── screens/     # Weather dashboard
    │       └── widgets/     # Weather cards, charts, metric tiles
    ├── search/             # Global location search & reverse geocoding
    └── favorites/          # Saved locations & search history management

\`\`\`

\---

\## 💾 Local Storage Strategy

WeatherWise implements a hybrid caching and persistence strategy using \*\*Hive\*\* and \*\*SharedPreferences\*\*:

\| Technology | Purpose | Usage Details |
\| --- | --- | --- |
\| \*\*Hive (NoSQL)\*\* | High-Speed Object Caching | Stores complex objects like \*\*Saved Favorite Locations\*\*, \*\*Recent Search History\*\*, and offline weather snapshots. Hive is fast, light, and operates natively without native binaries. |
\| \*\*SharedPreferences\*\* | Lightweight Key-Value Storage | Stores primitive settings such as user preferences (Light/Dark mode) and temperature unit preferences (°C / °F). |

\---

\## ⚡ Core Features

\* \*\*GPS Weather Fetching:\*\* Reads user coordinates using \`geolocator\` and reverse geocodes them into city names.
\* \*\*Global Search:\*\* Search for any city worldwide with recent query tracking.
\* \*\*Detailed Metrics:\*\* Tracks temperature, apparent ("feels like") temperature, humidity, UV index, wind speed/direction, surface pressure, and dew point.
\* \*\*24-Hour & 7-Day Outlooks:\*\* Displays hourly temperature trends and long-term daily forecasts.
\* \*\*Favorite Bookmarks:\*\* Quick-access list for saved cities powered by Hive local storage.
\* \*\*Dynamic Theme:\*\* Support for Light and Dark modes using standard Material 3 design tokens and custom typography (\`Inter_24pt\`).

\---

\## 🛠️ Tech Stack & Dependencies

\`\`\`yaml
environment:
  sdk: ^3.13.0

dependencies:
  \# UI & Icons
  flutter_lucide: ^1.47.0
  cupertino_icons: ^1.0.8
  intl: ^0.20.3

  \# State Management & DI
  flutter_riverpod: ^3.4.3

  \# Network & APIs
  dio: ^5.11.1
  pretty_dio_logger: ^1.4.0
  flutter_dotenv: ^6.0.1

  \# Location Services
  geolocator: ^14.0.2
  geocoding: ^5.0.0

  \# Storage & Functional Logic
  shared_preferences: ^2.5.5
  hive_flutter: ^1.1.0
  fpdart: ^1.1.0

\`\`\`

\---

\## 🚀 Installation & Setup

\### Prerequisites

\* [Flutter SDK]\([https://docs.flutter.dev/get-started/install?utm_source=gemini](https://docs.flutter.dev/get-started/install?utm_source=gemini)) (\`^3.13.0\` or higher)
\* Android Studio / Xcode / VS Code

\### Steps

1\. \*\*Clone the repository:\*\*
\`\`\`bash
git clone [https://github.com/your-username/weatherwise.git](https://github.com/your-username/weatherwise.git)
cd weatherwise

\`\`\`


2\. \*\*Setup environment variables:\*\*
Create a \`.env\` file in the root directory:
\`\`\`env
BASE_URL=[https://api.open-meteo.com/v1/](https://api.open-meteo.com/v1/)
GEOCODING_URL=[https://geocoding-api.open-meteo.com/v1/](https://geocoding-api.open-meteo.com/v1/)

\`\`\`


3\. \*\*Install dependencies:\*\*
\`\`\`bash
flutter pub get

\`\`\`


4\. \*\*Generate app launcher icons:\*\*
\`\`\`bash
flutter pub run flutter_launcher_icons

\`\`\`


5\. \*\*Run the app:\*\*
\`\`\`bash
flutter run

\`\`\` make read me more better and professional adds some icons and logos
