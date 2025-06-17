# FitnessTracker - Architecture Documentation

> A modular iOS fitness tracking application built with Swift Package Manager and feature-based architecture.

## 📋 Table of Contents

- [Overview](#overview)
- [Package Structure](#package-structure)
- [Access Control Strategy](#access-control-strategy)
- [Architecture Trade-offs](#architecture-trade-offs)
- [Scaling Strategy](#scaling-strategy)
- [Development Guidelines](#development-guidelines)
- [Getting Started](#getting-started)

## Overview

FitnessTracker is designed as a modular iOS application using Swift Package Manager for dependency management. The architecture follows feature-based package separation with a shared utilities foundation, enabling parallel development and clear separation of concerns.

### Key Principles

- 🏗️ **Feature-based modularity** for clear ownership boundaries
- 🔄 **Protocol-oriented design** for testability and flexibility
- ⬇️ **Unidirectional dependencies** preventing circular references
- 🧪 **Testing-first approach** with comprehensive mock support
- 📱 **SwiftUI-native** with modern iOS development patterns

## Package Structure

```
FitnessTracker/
├── 📦 Utilities/
│   ├── Sources/Utilities/
│   │   ├── DataStorage/         # UserDefaults, Keychain, CoreData helpers
│   │   ├── Extensions/          # Foundation, UIKit, SwiftUI extensions
│   │   ├── Logger/              # Centralized logging infrastructure
│   │   ├── Mocks/               # Shared test doubles and mock implementations
│   │   ├── Models/              # Core domain models (Goal, WorkoutSession, etc.)
│   │   └── Service/             # Base service protocols and implementations
│   └── Tests/UtilitiesTests/
├── 📦 WorkoutTracker/
│   ├── Sources/WorkoutTracker/
│   │   ├── Services/            # Workout business logic and data management
│   │   ├── WorkoutView/         # SwiftUI views for workout tracking UI
│   │   └── WorkoutTracker       # Main module interface and coordinator
│   └── Tests/WorkoutTrackerTests/
├── 📦 GoalManager/
│   ├── Sources/GoalManager/
│   │   ├── Services/            # Goal CRUD operations and progress tracking
│   │   ├── Views/               # Goal management and visualization UI
│   │   └── GoalManager          # Main module interface and state management
│   └── Tests/GoalManagerTests/
├── 📦 Weather/
│   ├── Sources/Weather/
│   │   ├── LocationManager/     # Location services abstraction layer
│   │   ├── Models/              # Weather-specific data models
│   │   ├── Views/               # Weather display and forecast components
│   │   ├── WeatherRepository/   # External weather API integration
│   │   └── WeatherViewModel/    # Weather presentation logic
│   └── Tests/WeatherTests/
└── 🎯 FitnessTracker (Main Target)/
    ├── Views/                   # App-level navigation and screen composition
    └── FitnessTrackerApp        # App entry point and dependency injection
```

### Access Control Matrix

| Component | Access Level | Rationale | Examples |
|-----------|-------------|-----------|----------|
| **Domain Models** | `public` | Cross-package sharing | `Goal`, `WorkoutSession` |
| **Service Protocols** | `public` | Dependency injection | `GoalService`, `WorkoutService` |
| **Manager Classes** | `public` | Package entry points | `GoalManager`, `WorkoutTracker` |
| **Implementations** | `internal` | Hide complexity | `WorkoutServiceImplementation`, `GoalServiceImplementation` |
| **Views** | `internal` | UI components | `GoalDetailView`, `WorkoutSessionView` |
| **Utilities** | `public` | Cross-package reuse | `Logger`, `DataStorage` , `ServiceImplementation` |
| **Test Mocks** | `public` | Testing support | `MockLogger` |


## Architecture Trade-offs

### ✅ Feature-Based Packages vs ❌ Monolithic Structure

**Current Choice: Feature-Based Packages**

**Benefits:**
- 🔄 **Parallel Development**: Teams can work on different features simultaneously
- 🧪 **Isolated Testing**: Each package can be tested independently
- 👥 **Clear Ownership**: Features have dedicated maintainers
- 📦 **Modular Deployment**: Features can be updated independently

**Costs:**
- 📋 **Additional Complexity**: More Package.swift files to maintain
- 🔄 **Dependency Management**: Careful coordination of package versions
- 📚 **Learning Curve**: Team needs to understand package boundaries

### ✅ Shared Models in Utilities vs ❌ Duplicated Models

**Current Choice: Centralized Models**

**Benefits:**
- 🎯 **Single Source of Truth**: Consistent model definitions
- 🔄 **Version Control**: Centralized model evolution
- 🧹 **No Duplication**: Eliminates inconsistent model copies

**Costs:**
- 📈 **Package Growth**: Utilities package may become large
- 🔗 **Coupling**: All features depend on Utilities
- 🔄 **Change Impact**: Model changes affect all consumers

## Scaling Strategy

### Growing Team 

**Planned Enhancements:**

```
📦 Core/                    # Extract domain models from Utilities
├── Models/
├── Protocols/
└── SharedTypes/

📦 Utilities/               # Pure utilities only
├── Extensions/
├── Logger/
└── DataStorage/

📦 TestUtilities/           # Extract test infrastructure
├── Mocks/
├── TestHelpers/
└── Fixtures/

📦 WorkoutTracker/          # Add layered architecture
├── Domain/
│   ├── UseCases/
│   └── Entities/
├── Data/
│   └── Repositories/
└── Presentation/
    ├── Views/
    └── ViewModels/
```

**New Capabilities:**
- 🔄 **Event Bus**: Cross-feature communication without direct dependencies
- 📱 **Use Cases**: Complex business logic encapsulation
- 🧪 **Contract Testing**: Ensure package interface compatibility

### Enterprise Scale 

**Advanced Architecture:**

```
📦 Foundation/              # Platform abstractions
📦 Core/                   # Domain layer
📦 FeatureA/               # Full Clean Architecture
├── Domain/
├── Data/
└── Presentation/
📦 FeatureB/               # Independent feature teams
📦 Shared/                 # Cross-cutting concerns
└── 🎯 Apps/
    ├── iOS/
    ├── watchOS/
    └── macOS/
```

**Enterprise Features:**
- 🏗️ **Micro-frontends**: Dynamically loaded feature modules
- 🌐 **Multi-platform**: iOS, watchOS, macOS shared business logic
- 🔄 **Event Sourcing**: Comprehensive state management
- 📈 **Feature Flags**: Runtime feature configuration
- 🔧 **Developer Tools**: Package scaffolding and automation

### Code Style and Conventions

#### Package Naming
- Use **PascalCase** for package names
- Choose **descriptive, feature-focused** names
- Avoid technical prefixes (~~iOSWorkoutTracker~~, use **WorkoutTracker**)

#### Access Control
- **Public**: Only what other packages need to see
- **Internal**: Default for implementation details
- **Private**: Helpers and internal state


## Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 15.0+
- Swift 5.9+

### Development Setup

#### 1. **Clone and Build**
```bash
git clone https://github.com/yourorg/FitnessTracker.git
cd FitnessTracker
xcodebuild -scheme FitnessTracker build
```
