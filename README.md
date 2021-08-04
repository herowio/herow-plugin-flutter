<p align="center">
  <a href="https://www.herow.io/" target="blank"><img src="https://uploads-ssl.webflow.com/5ef0d4414918620b0477c25e/5ef21969897eb53ed7491072_logo_tech-herow-300x150.png" width="320" alt="Hero Logo" /></a>
</p>

# Flutter Herow SDK Plugin

This plugin provides a cross-platform (iOS, Android) API to access the open-source Herow SDK
location features and the [Herow platform](https://herow.io).

* [Herow SDK IOS](https://github.com/herowio/herow-sdk-ios)
* [Herow SDK Android](https://github.com/herowio/herow-sdk-android)

The Herow-Plugin-Flutter is based on herow-sdk version : **7.1.0**.

# Features 

| Feature                        | Android  | iOS    | 
| -------                        |:-------: | :-----:|
| configuration app              |✅        |        |
| get custom id                  |✅        |        |
| set custom id                  |✅        |        |
| remove custom id               |✅        |        |
| Launch click&collect           |✅        |        |
| stop click&collect             |✅        |        |
| is on click&collect            |✅        |        |
| get GDPR optin                 |✅        |        |
| accept GDPR optin              |✅        |        |
| refuse GDPR optin              |✅        |        |
| reset                          |✅        |        |


# Getting started

You must **ask location permission** to your user before using HEROW.

<details>
<summary>Android</summary>

Add location permission in your `AndroidManifests.xml` : 

```xml
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
```

</details>

<details>
<summary>IOS</summary>

**Not Implemented yet**

</details>


## Usage

This section show you how to use herow-sdk workflow : 

 - [Initializing the plugin](#initializing-the-plugin)
 - [GDPR Opt-ins](#gdpr-opt-ins)
 - [Customer id](#customer-id)
 - [Click & Collect](#click--collect)

### Initializing the plugin

The synchronize method allows the SDK set up with a configuration file downloaded from the Herow platform. The SDK will start the place detection process only when the file download is complete.

This configuration file is saved in cache, and the SDK will check for updates at regular intervals.

The `initialize` allows you to configure your access to the HEROW platform. HEROW gives you access to the following environments:

- PRE_PROD: pre-production environment used for tests
- PROD: production environment used for release


Warning :warning:

- You will get one Access Key: This Access Key is composed of an SDK ID & an SDK Key and is used to configure your SDK.

- Please make sure you use the right platform depending on your objective (test or release). Otherwise your SDK won't load/be synced with the right content.
  

The following initialization code is required in order to communicate with herow platform : 

```dart
class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initHerow();
  }

//Import 'package:herow_plugin_flutter/herow_plugin_flutter.dart'
// to be able to access 'HerowPluginFlutter' class
  Future<void> initHerow() async {
    await HerowPluginFlutter.initialize("Environment", "sdkId", "apikey");
  }
```

### GDPR Opt-ins

The HEROW SDK has an in-built mandatory GDPR method.

Note: The HEROW SDK will only work if the GDPR opt-ins are given by the end-users.

```dart
//Import 'package:herow_plugin_flutter/herow_plugin_flutter.dart'
// to be able to access 'HerowPluginFlutter' class
  Future<void> optinWorkflow() async {
    await HerowPluginFlutter.acceptOptin();
    await HerowPluginFlutter.getOptin();
    await HerowPluginFlutter.refuseOptin();
  }
```

### Customer id

**Setting a customID is crucial if you want to reconcile your HEROW user data in your backend or with third-party partners**. The customID is used as cross-solution identification system.


To set a customID, make the following call **as soon as the user logs in**. You can set the customID before the synchronize() method, in your class extending Application.

```dart
//Import 'package:herow_plugin_flutter/herow_plugin_flutter.dart'
// to be able to access 'HerowPluginFlutter' class
  Future<void> setCustomId() async {
    await HerowPluginFlutter.setCustomId("YOUR_CUSTOM_ID")
  }
```

If the user logs out, you can use the removeCustomID() method. 
 
```dart
//Import 'package:herow_plugin_flutter/herow_plugin_flutter.dart'
// to be able to access 'HerowPluginFlutter' class
  Future<void> removeCustomId() async {
    await HerowPluginFlutter.removeCustomId()
  }
```

### Click & Collect

To enable the HEROW SDK to temporarly continue tracking end-users location events (geofence detection or standard location events) happening in a Click & Collect context when the app is in the background (but not closed).

This **method is to be called during an active session (app opened)** which will enable the SDK to continue tracking the end-user when the app is put in background.

This method **only works if the end-user's runtime location permission is at least set to While in use**.

From Android 11+ (API 30 and above), Google prevents apps from requesting the Background Location Permission upfront and collecting background location data before the user manually grants the background location permission is his/her app settings.

A Click & Collect context is defined by **specific app scenarios which legitimates a temporary use of the background location to perform a specific task** (ex: pickup scenarios for F&B where location is used to estimate order preparation lead time).

By default, the Click & Collect background service will timeout after 2 hours. This is meant to preserve the initial objective of this feature to locate end-users in the background for Click & Collect scenarios and not provide continuous background tracking.

```dart
//Import 'package:herow_plugin_flutter/herow_plugin_flutter.dart'
// to be able to access 'HerowPluginFlutter' class
  Future<void> clickAndCollectWorkflow() async {
    await HerowPluginFlutter.launchClickAndCollect();
    await HerowPluginFlutter.isClickAndCollect();
    await HerowPluginFlutter.stopClickAndCollect();
  }
```