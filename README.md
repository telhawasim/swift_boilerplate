# swift_boilerplate
A clean, opinionated SwiftUI starter template for building production-grade iOS apps. Get up and running quickly with essential features already configured.

# Why this exists
* Reduce boilerplate: Start from a sensible foundation instead of a blank canvas
* Encourage clarity: Separated responsibilities (UI, routing, DI, networking, localization)
* Scale with confidence: Patterns that adapt as features grow
* Production-ready: Essential features like localization, network monitoring, and caching included

# Key capabilities
* 🎨 Dark Mode - System/Light/Dark with AppStorage persistence
* 🌍 Localization - Runtime language switching (English & Spanish)
* 🧭 Type-safe Navigation - Router with separate NavigationPath per tab
* 💉 Dependency Injection - DIContainer for clean architecture
* 🌐 Async Networking - Modern async/await with error handling
* 📡 Network Monitoring - Real-time connectivity detection
* 🖼️ Image Caching - Memory and disk caching for performance
* ⚙️ Environment Config - Info.plist-based configuration

# Requirements
* Xcode 26.0.0+
* Swift 6.0+
* iOS 18+

# Getting started
* git clone https://github.com/telhawasim/swift_boilerplate.git
* cd swift_boilerplate

# Configure Info.plist
Make sure these keys exist and match your build configs:
* ENVIRONMENT (e.g., Staging, Production)
* BASE_URL (e.g., https://dummyjson.com)
* Configuration (e.g., Debug-Staging, Debug-Production, Release-Staging, Release-Production)

# Add Localizations
* Select project → Info → Localizations
* Verify English and Spanish are added
* Run with Cmd+R

# How to use
* Networking: Define endpoints with your Endpoint type and call NetworkService.request<T>(_:) to decode into models. It supports both direct T and wrapped BaseResponse<T>.
* Routing: Define routes in Route and map them in RouteBuilder. Each tab keeps its own NavigationPath in Router, ensuring independent navigation stacks.

# Enhancement ideas
* Add more languages (French, German, Arabic)
* Implement authentication module
* Add offline mode with local storage
* Push notifications
* Analytics integration
* Unit/UI tests with Swift Testing
* CI/CD pipeline

# Contributing
Contributions welcome! Please:
* Fork the project
* Create feature branch (git checkout -b feature/AmazingFeature)
* Commit changes (git commit -m 'Add AmazingFeature')
* Push to branch (git push origin feature/AmazingFeature)
* Open Pull Request

Made with ❤️ for the Swift community
