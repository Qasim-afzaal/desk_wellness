#  choose best name
# Complete Engineering Specification
## Cursor Implementation Guide

> **Purpose**
>
> This document defines the complete architecture, folder structure, implementation details, navigation flow, design system, coding standards, state management, local database, animations, and development rules for building the application.
>
> **Goal:** Production-quality Flutter application that is scalable, maintainable, and easy to extend.

---

# Tech Stack

## Framework

- Flutter (Latest Stable)
- Dart 3+

## Architecture

- Clean Architecture
- MVVM
- Feature-first organization
- Repository Pattern

## State Management

- Provider

## Navigation

- GoRouter

## Local Storage

- SQLite (Drift preferred)
- SharedPreferences

## Notifications

- flutter_local_notifications
- timezone

## UI Packages

- google_fonts
- flutter_svg
- flutter_animate
- lottie
- animations
- share_plus

## Premium

- in_app_purchase

---

# Project Structure

```
lib/

├── app/
│   ├── app.dart
│   ├── router.dart
│   ├── theme.dart
│   └── constants.dart
│
├── core/
│   ├── database/
│   ├── services/
│   ├── storage/
│   ├── notification/
│   ├── utils/
│   ├── extensions/
│   ├── widgets/
│   ├── animations/
│   ├── enums/
│   ├── models/
│   └── helpers/
│
├── features/
│
│   ├── home/
│   │      ├── model/
│   │      ├── repository/
│   │      ├── provider/
│   │      ├── view/
│   │      └── widgets/
│   │
│   ├── explore/
│   ├── favorites/
│   ├── settings/
│   ├── premium/
│   └── onboarding/
│
├── shared/
│   ├── widgets/
│   ├── theme/
│   ├── icons/
│   ├── typography/
│   └── components/
│
├── assets/
│   ├── images/
│   ├── icons/
│   ├── lottie/
│   ├── fonts/
│   └── data/
│
└── main.dart
```

---

# Architecture

```
UI

↓

Provider

↓

Repository

↓

SQLite

↓

Model
```

Views never directly access SQLite.

Everything goes through repositories.

---

# Feature Structure

Every feature should contain

```
feature/

model/

provider/

repository/

view/

widgets/
```

Example

```
home/

home_screen.dart

home_provider.dart

home_repository.dart

affirmation_model.dart

widgets/
```

---

# Design System

## Theme

Create

```
AppTheme
```

Contains

- Colors
- Typography
- Gradients
- Shadows
- Radius
- Button styles
- Card styles
- Input decoration

No hardcoded colors.

---

# Color File

```
AppColors

primary

secondary

background

surface

error

success

warning

textPrimary

textSecondary

divider
```

---

# Gradients

```
AppGradients

primary

secondary

premium
```

---

# Typography

```
AppTypography

display

headline

title

body

caption

button
```

---

# Radius

```
AppRadius

small

medium

large

extraLarge
```

---

# Spacing

```
AppSpacing

4

8

12

16

20

24

32

40

48
```

Never use random padding.

---

# Shared Widgets

Build reusable widgets only.

Examples

```
GradientCard

AffirmationCard

PrimaryButton

SecondaryButton

SettingTile

SearchBar

GradientFAB

CategoryChip

PremiumCard

ReminderCard

SectionHeader

LoadingWidget

ErrorWidget

EmptyStateWidget

BottomNavigation

AnimatedHeartButton
```

---

# App Flow

```
Launch

↓

Initialize Database

↓

Load Settings

↓

Load Notification Settings

↓

Load Today's Affirmation

↓

Home Screen
```

Bottom Navigation

```
Home

↓

Explore

↓

Favorites

↓

Settings
```

Premium

```
Settings

↓

Premium Screen

↓

Purchase
```

---

# Navigation

```
/

Home

/explore

/favorites

/settings

/premium
```

Use GoRouter.

No Navigator.push.

---

# Database

SQLite

## Table

Affirmations

```
id

text

category

isFavorite

isPremium

createdAt
```

---

Settings

```
theme

language

notificationEnabled

notificationTime
```

---

Daily Affirmation

```
date

affirmationId
```

Purpose

Ensure same affirmation stays the entire day.

---

# Repository Layer

Repositories should contain

```
loadAffirmations()

getTodayAffirmation()

favorite()

unfavorite()

search()

filterCategory()

shuffle()

saveSettings()

loadSettings()
```

---

# Providers

## HomeProvider

Responsible for

- today's affirmation
- loading
- shuffle
- favorite

---

ExploreProvider

Responsible for

- searching
- filtering
- categories

---

FavoriteProvider

Responsible for

- saved affirmations

---

SettingsProvider

Responsible for

- theme
- reminder
- language

---

PremiumProvider

Responsible for

- purchase state
- restore purchase

---

# Home Screen

Components

```
App Bar

↓

Greeting

↓

Today's Card

↓

Actions

↓

Bottom Navigation
```

---

Today's Card

Contains

Affirmation

Date

Gradient

Animation

---

Action Buttons

Favorite

Share

Bookmark

---

Behavior

App opens

↓

Checks today's date

↓

Already saved?

YES

↓

Load affirmation

NO

↓

Random affirmation

↓

Save ID

↓

Display

---

# Explore

Top

Search

↓

Categories

↓

Scrollable Cards

↓

FAB Shuffle

---

Search

Realtime filtering.

No button.

---

Categories

Scrollable chips.

Animated selection.

---

Cards

Heart

Category

Preview

---

Shuffle FAB

Returns random affirmation.

---

# Favorites

Grid

2 columns

Cards

Pastel colors

Heart filled

Tap

↓

Open Detail

Long Press

↓

Remove

---

# Settings

Contains

Reminder Card

↓

Appearance

↓

Language

↓

Premium

↓

Privacy

↓

About

↓

Rate App

↓

Restore Purchase

---

Reminder

Toggle

↓

Time Picker

↓

Schedule Notification

---

Theme

```
System

Light

Dark
```

Save locally.

---

# Notifications

Use

flutter_local_notifications

Schedule

Daily

Repeat

Offline

Works after reboot.

---

# Premium

Screen

Hero Illustration

↓

Title

↓

Benefits

↓

Plans

↓

Footer

---

Plans

Monthly

Yearly

Lifetime

---

Restore Purchase

Always visible.

---

# Search Logic

Search

↓

Text

↓

Category

↓

Return matching affirmations

Ignore uppercase/lowercase.

---

# Favorite Logic

Tap Heart

↓

Update SQLite

↓

Notify Provider

↓

Refresh UI

---

# Share Logic

Format

```
✨ Daily Affirmation

"I believe in myself."

Shared from I Am
```

---

# Animations

Home Card

Fade

Slide

Scale

---

Heart

Bounce

---

Category

AnimatedContainer

---

Navigation

Fade transition

---

Premium

Floating hero illustration

---

Buttons

Scale on press

---

# Loading States

Every screen should support

Loading

Error

Empty

Success

Never leave blank screens.

---

# Empty States

Favorites

No favorites

Explore

No search results

Premium

No internet purchase error (future)

---

# Assets

```
assets/

images/

illustrations/

icons/

lottie/

fonts/

json/
```

---

# Constants

Create

```
AppStrings

AppAssets

AppImages

AppIcons

AppDurations

AppSizes
```

---

# Utilities

```
Date Formatter

Random Generator

Notification Helper

Theme Helper

Share Helper

Validation
```

---

# Coding Rules

- No duplicated widgets
- No duplicated colors
- No magic numbers
- Use const constructors
- Keep widgets under ~250 lines where practical
- Separate UI and business logic
- Proper naming conventions
- Strong typing everywhere
- Null safety
- Reusable components
- Follow SOLID principles

---

# Performance

- Lazy loading
- Minimize rebuilds
- Use Selector/Consumer appropriately
- Cache today's affirmation
- Const widgets wherever possible
- Optimize animations for 60 FPS

---

# Accessibility

- Dynamic text support
- Screen reader labels
- Large touch targets
- High contrast in dark mode
- Semantic widgets

---

# Future Features (Design for Extension)

- Firebase Sync
- User Authentication
- AI-generated affirmations
- Home Screen Widgets
- Apple Health
- Google Fit
- Streak tracking
- Mood tracking
- Journal
- Meditation audio
- Cloud backup
- Wear OS
- Apple Watch
- Multiple languages
- Themes marketplace

---

# Development Checklist

## Phase 1
- Project setup
- Theme system
- Folder structure
- Routing
- SQLite setup
- Providers

## Phase 2
- Home screen
- Explore screen
- Favorites screen
- Settings screen
- Bottom navigation

## Phase 3
- Notifications
- Search
- Favorites persistence
- Daily affirmation logic
- Share functionality

## Phase 4
- Premium UI
- Purchase flow
- Animations
- Dark mode
- Empty states
- Loading states

## Phase 5
- Testing
- Performance optimization
- Accessibility review
- Code cleanup
- Production-ready polish

---

# Definition of Done

The app is complete when:

- ✅ Pixel-perfect implementation of the Stitch design
- ✅ Offline-first architecture
- ✅ Clean Architecture + MVVM
- ✅ Provider state management
- ✅ SQLite persistence
- ✅ Daily reminder notifications
- ✅ Search and category filtering
- ✅ Favorites persistence
- ✅ Smooth animations throughout
- ✅ Dark/Light/System theme support
- ✅ Premium paywall UI
- ✅ Responsive layouts for all devices
- ✅ Reusable widgets and design system
- ✅ Maintainable, scalable, production-quality codebase