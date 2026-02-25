# ChefMate Recipe App

**ChefMate** is an iOS recipe discovery app that lets users browse, search, and save their favourite recipes. Built with SwiftUI and powered by the Spoonacular API and Firebase, ChefMate delivers a smooth and personalized cooking experience.

---

## Features

- **Authentication** – Secure sign-up and login via Firebase Authentication.
- **Home Feed** – Browse curated sections: *Featured Recipes*, *Trending Recipes*, and *New Recipes*.
- **Explore & Search** – Search for any recipe by keyword and refine results with collapsible filters:
  - Cuisine (African, Asian, Italian, Mexican, …)
  - Diet (Gluten Free, Vegan, Ketogenic, …)
  - Meal Type (breakfast, dessert, main course, …)
  - Intolerances (dairy, peanut, shellfish, …)
- **Recipe Details** – View full recipe information including ingredients and step-by-step instructions.
- **My Cookbook** – Save favourite recipes and revisit them any time from a personal cookbook.
- **Profile** – View your name, favourite recipe count, edit your profile, and sign out.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift 5.0 |
| UI Framework | SwiftUI |
| Minimum iOS | iOS 16.2 |
| Recipe Data | [Spoonacular API](https://spoonacular.com/food-api) |
| Authentication | Firebase Authentication |
| Database | Cloud Firestore |
| Dependency Manager | Swift Package Manager |

---

## Architecture

The project follows an MVC-inspired structure:

```
ChefMate Recipe App/
├── Views/               # SwiftUI screens and reusable components
│   ├── SplashScreen     # Launch / entry point
│   ├── LoginScreen      # User login
│   ├── RegisterScreen   # New account registration
│   ├── HomeScreen       # Tab bar container
│   ├── HomeView         # Featured / Trending / New recipe feeds
│   ├── ExploreScreen    # Search and filter recipes
│   ├── RecipeInfoView   # Full recipe details
│   ├── PortfolioScreen  # Saved (favourite) recipes
│   ├── ProfileScreen    # User profile
│   └── EditProfileScreen# Edit name / password
├── Models/              # Codable data models (Recipe, User, Ingredient, …)
└── Controller/
    ├── ApiManager       # Spoonacular API calls
    └── FirebaseManager  # Firebase Auth & Firestore operations
```

---

## Getting Started

### Prerequisites

- Xcode 15 or later
- An iOS 16.2+ device or simulator
- A [Spoonacular API key](https://spoonacular.com/food-api/console#Dashboard)
- A Firebase project with **Authentication** (Email/Password) and **Firestore** enabled

### Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/arielbendahan/ChefMate-Recipe-App.git
   cd ChefMate-Recipe-App
   ```

2. **Add your Firebase configuration**

   Download `GoogleService-Info.plist` from your Firebase project and replace the existing placeholder file at:

   ```
   ChefMate Recipe App/GoogleService-Info.plist
   ```

3. **Add your Spoonacular API key**

   Open `ChefMate Recipe App/Controller/ApiManager.swift` and replace the `apiKey` value with your own key:

   ```swift
   private let apiKey = "YOUR_API_KEY_HERE"
   ```

4. **Open and run the project**

   ```bash
   open "ChefMate Recipe App.xcodeproj"
   ```

   Select a simulator or connected device and press **Run** (⌘R).

---

## Authors

- **Ariel Bendahan**
- **Leonardo**
