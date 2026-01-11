# Micro-Habits Tracker: Publishing Guide

This guide walks you through the process of building the production version of the Micro-Habits Tracker and publishing it to the Google Play Store.

## Prerequisites
- A Google Play Developer Account ($25 one-time fee).
- Flutter environment set up and working.
- [App Icon](Micro Habits Tracker/assets/icon.png) and [Mockups](Micro Habits Tracker/mockups/) ready.

---

## Phase 0: Getting the Code & Environment Setup
1. **Open the Project:** Launch Android Studio and select **Open**. Navigate to the project folder.
2. **Install Plugins:** Go to **Settings > Plugins** and ensure the **Flutter** and **Dart** plugins are installed.
3. **Get Dependencies:** Once the project is open, a bar should appear at the top saying "Pub get". Click it, or run `flutter pub get` in the terminal.
4. **Setup Java:** In **Settings > Build, Execution, Deployment > Build Tools > Gradle**, ensure the Gradle JDK is set to **Java 17** or **21**.

---

## Phase 1: Android Release Signing

Google Play requires all apps to be signed with a digital certificate.

### 1. Generate a Keystore
Run the following command in your terminal to create a production keystore file:

```powershell
keytool -genkey -v -keystore "C:\Users\home\Desktop\upload-keystore.jks" `
        -storetype PKCS12 -keyalg RSA -keysize 2048 -validity 10000 `
        -alias upload
```
> [!IMPORTANT]
> Keep this file safe! If you lose it, you won't be able to update your app on the Play Store.

### 2. Configure `key.properties`
Create a file at `android/key.properties` (this file is git-ignored) and add the following:

```properties
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=upload
storeFile=C:\Users\home\Desktop\upload-keystore.jks
```

### 3. Verify `build.gradle`
You need to modify [android/app/build.gradle](Micro Habits Tracker/android/app/build.gradle) to load the `key.properties` file and use it for signing.

**Add this to the top of the file (before the `android` block):**
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

**Update the `signingConfigs` and `buildTypes` blocks inside `android { ... }`:**
```gradle
android {
    ...
    signingConfigs {
        release {
            keyAlias = keystoreProperties['keyAlias']
            keyPassword = keystoreProperties['keyPassword']
            storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword = keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            // Use the release signing config instead of debug
            signingConfig = signingConfigs.release
            
            minifyEnabled false
            shrinkResources false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

---

## Phase 2: Building the App Bundle (AAB)

The Android App Bundle (.aab) is the recommended format for Google Play.

1. Open your terminal in the project root.
2. Run the build command:
   ```powershell
   flutter build appbundle --release
   ```
3. The output file will be located at:
   `build\app\outputs\bundle\release\app-release.aab`

---

## Phase 3: Google Play Console Workflow

### 1. Create New App
- Go to [Google Play Console](https://play.google.com/console).
- Click **Create app**.
- App Name: **Micro-Habits Tracker**
- Default Language: **English (United States)**
- App or Game: **App**
- Free or Paid: **Free**

### 2. Set Up Your App
Complete the "Set up your app" section:
- **Privacy Policy:** Link to your hosted privacy policy (e.g., on GitHub Pages or your NEXO Dev site).
- **Data Safety:** Refer to [data_safety.md](Micro Habits Tracker/compliance/data_safety.md) for the exact answers.
- **Category:** Health & Fitness or Tools.

### 3. Store Presence
- **Main Store Listing:** Use the ASO-optimized descriptions we prepared.
- **Graphics:** Upload the screenshots from the `mockups/` folder.
  - Phone screenshots (at least 2).
  - 7-inch and 10-inch tablet screenshots (use the same ones if needed, or generate scaled versions).
  - Feature Graphic (1024x500).

### 4. Release Management
- Go to **Production** > **Create new release**.
- Upload the `app-release.aab` file.
- Add release notes (e.g., "Initial release of the privacy-first Micro-Habits Tracker").
- Click **Next** and **Save**.
- **Start rollout to Production** (Requires 14-day testing period for new personal accounts).

---

## Phase 4: Compliance Checklist (2025 Policies)
- [x] **Zero Permissions:** Verified in Manifest.
- [x] **Data Deletion:** "Delete All Data" button implemented.
- [x] **Offline first:** No internet permission required.
