# Bätsi

[Español](README.md) · **English**

**A markerless Augmented Reality iPad app that makes the Hñähñu (Otomí) language visible in the classroom, on equal footing with Spanish and English.**

Bätsi lets children aged 6 to 9 place trilingual AR labels (Hñähñu – Spanish – English) on real classroom objects and hear how they are pronounced.

> *Not to teach a language. To recognize it.*

<!-- Suggestion: add 2–3 screenshots or a GIF of the app here.
     Upload the images to a docs/ folder and link them like this:
     ![AR Explorer](docs/ar-explorer.png) -->

## Contents

1. [General information](#1-general-information)
2. [Description](#2-description)
3. [Users](#3-users)
4. [Tools and technologies](#4-tools-and-technologies)
5. [How to run it](#5-how-to-run-it)
6. [Screens and features](#6-screens-and-features)
7. [Data flow](#7-data-flow)
8. [Repository structure](#8-repository-structure)
9. [Project status](#9-project-status)
10. [Next steps](#10-next-steps)
11. [Author](#11-author)

---

## 1. General information

| | |
|---|---|
| Name | Bätsi |
| Type | Augmented Reality app for iPad |
| Start date | January 13, 2026 |
| Estimated delivery date | February 28, 2026 |
| Progress | ≈ 70 % |
| Institution | Universidad de las Américas Puebla (UDLAP) |

---

## 2. Description

Bätsi is a *markerless* Augmented Reality app built with SwiftUI for iPad. Its goal is to make the Hñähñu (Otomí) language visible in school spaces, at the same level as Spanish and English. Children place trilingual AR labels (Hñähñu–Spanish–English) on real classroom objects and hear their pronunciation.

### Problems it addresses

- The linguistic and cultural invisibility of Hñähñu-speaking children in schools dominated by Spanish and English.
- The lack of representation of the Indigenous language in everyday school objects.
- The disconnect between Otomí children's cultural identity and their learning environment.

### Approach

The app **does not aim to teach the language or to assess**, but to **recognize, dignify and connect**, building a symbolic and functional bridge between the three languages. Its impact is symbolic and pedagogical, not systemic.

---

## 3. Users

| Type | Description |
|---|---|
| Primary | Children aged 6 to 9 who do not speak Otomí but attend schools near Hñähñu-speaking communities. |
| Secondary | Otomí-speaking children, who benefit from seeing their language represented and valued in the classroom. |

### Main needs

- Recognize and respect Hñähñu as equal to Spanish and English.
- Learn basic vocabulary in an interactive, exploratory way through AR.
- Connect language learning with real objects in the physical environment.
- Feel culturally represented (secondary users).
- An accessible experience, with no printed materials or extra infrastructure.

---

## 4. Tools and technologies

| | |
|---|---|
| Language | Swift 6 |
| Project | Swift Playgrounds app (`Batsi.swiftpm`) |
| Interface | SwiftUI |
| Augmented Reality | ARKit (plane tracking) + RealityKit (3D rendering) |
| Audio | AVFoundation (`AVSpeechSynthesizer`) |
| Utilities | UIKit and Foundation |
| Persistence | `@AppStorage` (UserDefaults) |
| Cube textures | Generative AI (Grok) for each object's images: door, book, table, ball, spinning top, toy, chocolate, tortilla and orange |

---

## 5. How to run it

**Requirements**
- An iPad with a camera (the app uses ARKit, so it does not work in the simulator).
- iPadOS 16.0 or later.
- Swift Playgrounds on iPad, or Xcode on a Mac.

**Steps**
1. Clone or download this repository.
2. Open the `Batsi.swiftpm` folder with Swift Playgrounds or Xcode.
3. Run the app on a physical iPad and allow camera access.
4. Point the camera at a horizontal surface, choose a category and an object, and tap **Place / Colocar**.

---

## 6. Screens and features

### 6.1 Onboarding (`OnboardingView`)
Three swipeable pages that introduce the problem and the solution:
- **Page 1:** *"Languages exist. But not all are seen."* — UNESCO statistic about Indigenous children.
- **Page 2:** *"When a language is invisible, children feel invisible."* — Context of the problem in Otomí schools.
- **Page 3:** *"Meet Bätsi."* — Introduction of the solution with the **Start Exploring** button.

### 6.2 Welcome (`WelcomeView`)
Bätsi logo (an orange bird), title and a main button that shows *Start / Comenzar* or *Continue Session / Continuar Sesión [N]* depending on saved progress.

### 6.3 Category selection (`CategorySelectionView`)
Three color-coded categories, each with its Hñähñu translation:

| Category | Color |
|---|---|
| School / *skuela, ngunsadi* | Teal |
| Games / *nt'eni* | Green |
| Food / *hñuni, ntsi* | Coral |

### 6.4 AR Explorer (`ARExplorerView`)
- Full-screen camera with horizontal plane tracking.
- Header with a back button and the current category label.
- Horizontal list of selectable objects (SF Symbols icons).
- Main button *Place / Colocar [WORD IN HÑÄHÑU]* in the category color.

### 6.5 Placed AR label
When **Place** is tapped, the following appears in real space:
- A 3D cube with 6 unique textures of the object (AI-generated).
- Three floating 3D words stacked with a visual hierarchy:
  - **Hñähñu** — largest, in white
  - **Spanish** — medium, in yellow
  - **English** — smallest, in cyan
- Automatic playback of the name in Spanish and English using speech synthesis.

### 6.6 Vocabulary (9 objects)

| Category | Spanish | Hñähñu | English |
|---|---|---|---|
| School | Libro | Mfixụnt'ot'i | Book |
| | Puerta | Gosthi | Door |
| | Mesa | Mexa | Table |
| Games | Trompo | Trompo | Trompo (spinning top) |
| | Pelota | Nuni | Ball |
| | Juguete | nt'eni | Toy |
| Food | Chocolate | dẹjụ | Chocolate |
| | Tortilla | Hme | Tortilla |
| | Naranja | nanxa | Orange |

> ⚠️ The Hñähñu vocabulary and spelling have not yet been validated by a linguist or native speaker (see [Next steps](#10-next-steps)).

---

## 7. Data flow

### 7.1 Data model (`LearnObject`)
Each learning object is an `Identifiable` struct with:

| Field | Description |
|---|---|
| `id` | `UUID` |
| `category` | `enum Category`: `school`, `games`, `food` |
| `spanish`, `hnahnu`, `english` | The word in each language |
| `audioFileName` | Audio file name |
| `model3DName` | Reference to the textures in `Media.xcassets` |
| `imageName` | SF Symbol used as the icon |

### 7.2 Persistent user data
- `currentSession: Int` — stored with `@AppStorage` in UserDefaults; persists between app sessions.

### 7.3 Runtime flow
1. **Launch:** `MyApp` loads `ContentView`, which shows `OnboardingView` or `WelcomeView` depending on `hasFinishedIntro`.
2. **Onboarding:** the user goes through the 3 pages in a `TabView`. When finished, `hasFinishedOnboarding = true` is set through a binding and the app moves to `WelcomeView`.
3. **Welcome:** `WelcomeView` reads `currentSession` from `@AppStorage`. If it is 0, it sets it to 1 when the button is tapped and navigates to `CategorySelectionView` with a `NavigationStack`.
4. **Selection:** `CategorySelectionView` iterates over `Category.allCases` and, when one is chosen, opens `ARExplorerView` through a `NavigationLink`, passing the category.
5. **AR exploration:** `ARExplorerView` filters `allObjects` by category and keeps two `@State` values: `selectedObject` (active object) and `placeTrigger` (placement signal).
6. **AR placement:** these states are passed as `@Binding` to `ARViewContainer` (a `UIViewRepresentable` wrapping RealityKit's `ARView`). When `shouldPlace` becomes `true`, the previous scene is cleared and `ARLabelManager.createObject(for:color:)` is called.
7. **3D model:** `ARLabelManager` builds the cube entity by entity: 6 textured planes (one per face) positioned in 3D. On top it stacks 3 3D text entities (Hñähñu, Spanish, English).
8. **Audio:** after placing the object, `reproducirSecuenciaDeAudio` uses `AVSpeechSynthesizer` to say the name in Spanish and then English, with a 1.8 s delay.
9. **Anchoring:** the group is anchored with `AnchorEntity(world: [0, 0, -0.5])`, 50 cm in front of the camera.

---

## 8. Repository structure

```
Batsi.swiftpm/
├── MyApp.swift                 # Entry point
├── ContentView.swift           # Chooses between Onboarding and Welcome
├── OnboardingView.swift        # 3 intro pages
├── WelcomeView.swift           # Welcome screen and current session
├── CategorySelectionView.swift # Category selection
├── ARExplorerView.swift        # Main AR view
├── ARViewContainer.swift       # SwiftUI ↔ ARView (RealityKit) bridge
├── ARLabelManager.swift        # Builds the 3D cube, text and audio
├── LearnObject.swift           # Data model and vocabulary
├── FolkScreenWrapper.swift     # Background with Otomí folk patterns
├── Theme.swift                 # Color palette
├── Media.xcassets/             # Cube textures (6 per object) and colors
└── Package.swift
```

---

## 9. Project status

**Approximate progress: 70 %.** The app works end to end (onboarding → welcome → selection → AR → placement with audio). There is significant room for improvement in gamification, linguistic authenticity and AR anchoring accuracy.

### Implemented features
- [x] 3-page onboarding with animated transitions
- [x] Welcome screen that detects first session vs. continuation
- [x] Progress persistence with `@AppStorage`
- [x] 3 categories with a color-coded system
- [x] ARKit + RealityKit with horizontal plane detection
- [x] 3D cubes with 6 unique textured faces per object (AI-generated textures)
- [x] 3D text in 3 languages with visual hierarchy (sizes and colors)
- [x] Automatic pronunciation in Spanish and English with speech synthesis
- [x] 9 objects with trilingual vocabulary (3 per category)
- [x] Visual design with Otomí folk patterns (`FolkScreenWrapper`)
- [x] Thematic color system (`Theme.swift`)

### Blockers or issues
There are no critical blockers. The main flow works correctly; what remains are improvements that will scale the experience, not obstacles to its current operation.

---

## 10. Next steps

- [ ] **Session-based unlocking:** filter objects by `currentSession` (1 object per category in session 1, 2 in session 2, full access in session 3), as in the original design.
- [ ] **Reward system:** +10 points per placed object, success animations, stars and collectible Otomí cultural stickers.
- [ ] **"Mission Complete!" screen:** end-of-session screen that automatically increments `currentSession` and awards a star, a sticker and a positive message.
- [ ] **Hñähñu audio by native speakers:** replace speech synthesis with real recordings from Otomí community members to ensure authenticity and correct pronunciation.
- [ ] **Better AR anchoring:** replace the fixed position `[0, 0, -0.5]` with a raycast on detected planes, so children can place objects on real classroom surfaces.
- [ ] **Custom Bätsi app icon** (currently the generic pencil placeholder).
- [ ] **Linguistic validation:** review Hñähñu vocabulary and spelling with a linguist or native speaker.
- [ ] **Testing with real users:** sessions with children aged 6 to 9 at a school near an Otomí community, to gather feedback and adjust the experience.

---

## 11. Author

| Name | Role |
|---|---|
| [Myrahis](https://github.com/MyrahisYSanluis) | Lead developer |

Universidad de las Américas Puebla (UDLAP)
