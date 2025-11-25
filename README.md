# swift_boilerplate
SwiftBoilerpoint is a clean, opinionated SwiftUI starter template designed to help you bootstrap production-grade apps faster. It demonstrates a practical architecture with theming, typed navigation, dependency injection, and an async/await networking layer — all structured to be easy to extend and maintain.

# Why this exists
* Reduce boilerplate: Start from a sensible foundation instead of a blank canvas.
* Encourage clarity: Keep responsibilities separated (UI, routing, DI, networking, configuration).
* Scale with confidence: Patterns used here adapt well as features grow.
* Be pragmatic: Uses modern SwiftUI and Swift Concurrency with minimal magic.

# Key capabilities
• SwiftUI-first UI with TabView + NavigationStack per tab
• Global appearance control (System / Light / Dark) via EnvironmentObject and AppStorage
• Settings screen for toggling Dark Mode
• Router with typed routes and separate NavigationPath per tab
• Dependency Injection container for view models (DIContainer)
• Async/await networking service with:
   • Endpoint-driven requests
   • Robust JSON decoding (direct or wrapped BaseResponse)
   • Unified error modeling (server/decoding/unknown)
   • Request/response logging
   • Query parameter support for GET
• Environment-based configuration via Info.plist (ENVIRONMENT, BASE_URL, Configuration)

# What's inside (high level)
• SwiftBoilerpointApp.swift: App entry, injects Router and AppearanceManager, applies preferredColorScheme.
• TabbarView.swift: Tabbed navigation with per-tab NavigationStack and typed routes.
• SettingView.swift: Dark Mode toggle persisted with AppStorage.
• AppearanceManager.swift: Centralized theme manager (system/light/dark).
• NetworkService.swift: Async network client with decoding strategy and error handling.
• Config.swift (EnvironmentManager): Reads environment/configuration from Info.plist.

# Requirements
• Xcode 26.0.0+
• Swift 6.0+
• iOS 26
