# Implementation Plan - Micro-Habits Tracker

Technical and compliance plan for a privacy-first, offline-only habit tracker.

## User Review Required

> [!IMPORTANT]
> This app is designed for **Zero-Permission** compliance. Adding any package that requires internet or background location will break this compliance.

## Proposed Changes

### Configuration & Setup
#### [MODIFY] [pubspec.yaml](file:///c:/Users/home/Desktop/Micro%20Habits%20Tracker/pubspec.yaml)
- Add dependencies: `sqflite`, `path`, `provider`, `shared_preferences`.
- Ensure no tracking or analytics SDKs are included.

#### [MODIFY] [AndroidManifest.xml](file:///c:/Users/home/Desktop/Micro%20Habits%20Tracker/android/app/src/main/AndroidManifest.xml)
- Completely remove `<uses-permission>` tags.
- Ensure `queries` or `service` tags that might imply external communication are absent.

### Data Layer
#### [NEW] [database_helper.dart](file:///c:/Users/home/Desktop/Micro%20Habits%20Tracker/lib/data/database_helper.dart)
- Singleton class for SQLite management.
- Schema for habits (id, name, frequency, completed_today).
- `deleteAllData()` method for user control.

### UI Layers
#### [NEW] [main.dart](file:///c:/Users/home/Desktop/Micro%20Habits%20Tracker/lib/main.dart)
- Entry point with Theme and Provider setup.

#### [NEW] [home_screen.dart](file:///c:/Users/home/Desktop/Micro%20Habits%20Tracker/lib/ui/home_screen.dart)
- List of active habits.

#### [NEW] [settings_screen.dart](file:///c:/Users/home/Desktop/Micro%20Habits%20Tracker/lib/ui/settings_screen.dart)
- "Delete All My Data" button with confirmation.
- "About" section explaining offline-first nature.

## Compliance Assets

### Data Safety Answers
- **Data Collection:** No.
- **Data Sharing:** No.
- **Data Security:** Data is stored locally and not encrypted by the app (standard SQLite).
- **Data Deletion:** Yes, via the Settings screen.

### Privacy Policy
A 3-paragraph policy emphasizing "No Data Collection" and "Local Only Storage".

### Phase 9: Play Store Assets
#### [NEW] [play_store_aso.md](file:///c:/Users/home/Desktop/Micro%20Habits%20Tracker/compliance/play_store_aso.md)
- ASO-optimized descriptions.
- [NEW] High-fidelity mockups for Play Store.

## Verification Plan

### Automated Tests
- Integration tests for `sqflite` storage.
- Check generated `apk` for permissions using `aapt2`.

### Manual Verification
- Verify data persistence after app restart.
- Verify data deletion clears the database entirely.
