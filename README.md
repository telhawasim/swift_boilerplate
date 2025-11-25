# swift_boilerplate
SwiftBoilerpoint is a clean, opinionated SwiftUI starter template designed to help you bootstrap production-grade apps faster. It demonstrates a practical architecture with theming, typed navigation, dependency injection, and an async/await networking layer — all structured to be easy to extend and maintain.

# Why this exists
* Reduce boilerplate: Start from a sensible foundation instead of a blank canvas.
* Encourage clarity: Keep responsibilities separated (UI, routing, DI, networking, configuration).
* Scale with confidence: Patterns used here adapt well as features grow.
* Be pragmatic: Uses modern SwiftUI and Swift Concurrency with minimal magic.

# Key capabilities
* SwiftUI-first UI with TabView + NavigationStack per tab
* Global appearance control (System / Light / Dark) via EnvironmentObject and AppStorage
* Settings screen for toggling Dark Mode
* Router with typed routes and separate NavigationPath per tab
* Dependency Injection container for view models (DIContainer)
* Async/await networking service with:
   * Endpoint-driven requests
   * Robust JSON decoding (direct or wrapped BaseResponse)
   * Unified error modeling (server/decoding/unknown)
   * Request/response logging
   * Query parameter support for GET
* Environment-based configuration via Info.plist (ENVIRONMENT, BASE_URL, Configuration)

# What's inside (high level)
* SwiftBoilerpointApp.swift: App entry, injects Router and AppearanceManager, applies preferredColorScheme.
* TabbarView.swift: Tabbed navigation with per-tab NavigationStack and typed routes.
* SettingView.swift: Dark Mode toggle persisted with AppStorage.
* AppearanceManager.swift: Centralized theme manager (system/light/dark).
* NetworkService.swift: Async network client with decoding strategy and error handling.
* Config.swift (EnvironmentManager): Reads environment/configuration from Info.plist.

# Requirements
* Xcode 26.0.0+
* Swift 6.0+
* iOS 26

# Getting started

1. Clone
git clone https://github.com/telhawasim/swift_boilerplate.git
cd swift_boilerplate

2. Open
Open the project in Xcode (xcodeproj or workspace if applicable).

3. Configure Info.plist
Make sure these keys exist and match your build configs:
* ENVIRONMENT (e.g., Staging, Production)
* BASE_URL (e.g., https://dummyjson.com)
* Configuration (e.g., Debug-Staging, Debug-Production, Release-Staging, Release-Production)

4. Run
Select a simulator or device and press Cmd+R.

# How to use
* Theme: The app applies the theme from AppearanceManager. Settings lets you switch between Light and Dark. “System” mode is supported at the app level; you can add a UI toggle for it as an enhancement.
* Networking: Define endpoints with your Endpoint type and call NetworkService.request<T>(_:) to decode into models. It supports both direct T and wrapped BaseResponse<T>.
* Routing: Define routes in Route and map them in RouteBuilder. Each tab keeps its own NavigationPath in Router, ensuring independent navigation stacks.

# Customization ideas
* Add a “Follow System” appearance option to Settings
* Persist selected tab and navigation paths across launches
* Add unit/UI tests with the new Swift Testing framework
* Introduce mock services for offline development
* Add CI (GitHub Actions), code coverage, and linting

# Contributing
Issues and pull requests are welcome. Please include a clear description and, if UI-related, before/after notes.
