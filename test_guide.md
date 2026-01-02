# Running and Testing Guide

Follow these steps to run the Micro-Habits Tracker and verify its privacy-first features.

## 1. Prerequisites
Ensure you have the Flutter SDK installed and an Android emulator or physical device connected.

## 2. Launch the App
Run the following commands in your terminal:
```powershell
cd "Micro Habits Tracker"
flutter pub get
flutter run
```

---

## 3. Core Feature Testing

### A. Adding a Habit
1. Tap the **+** button on the Home screen.
2. Enter a habit name (e.g., "Read for 10 mins").
3. Select a frequency (Daily/Weekly).
4. Tap **Save Habit**.
5. **Verify:** The habit should appear on the Home screen list.

### B. Completing a Habit
1. Tap the circle icon next to your new habit.
2. **Verify:** The circle turns into a green checkmark, and the "Streaks" count increments.
3. *Note:* You can only complete a habit once per day.

### C. Data Persistence
1. Close the app completely (kill the process).
2. Relaunch the app using `flutter run`.
3. **Verify:** Your habits and their completion status are still there. (This confirms SQLite is working correctly).

---

## 4. Compliance & Privacy Testing

### A. Data Deletion (User Control)
1. Go to **Settings** (gear icon in the top right).
2. Tap **Delete All My Data**.
3. Confirm the deletion in the dialog.
4. Go back to the Home screen.
5. **Verify:** The list is empty. (This satisfies Google's requirement for user data control).

### B. Permission Verification
To ensure no accidental permissions were added by dependencies:
1. Build the APK:
   ```powershell
   flutter build apk --release
   ```
2. Check permissions (requires `aapt2` from Android SDK):
   ```powershell
   aapt2 dump badging build/app/outputs/flutter-apk/app-release.apk | findstr permission
   ```
3. **Verify:** The output should be empty or contain only standard Flutter permissions (like standard windowing), but **zero** dangerous permissions like INTERNET, LOCATION, or CONTACTS.

### C. Offline Verification
1. Put your testing device in **Airplane Mode**.
2. Open the app and interact with it.
3. **Verify:** The app works perfectly with no "No Internet" errors or hung screens.
