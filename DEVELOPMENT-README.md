Herow Plugin flutter
------------
This plugin provides a cross-platform (iOS, Android) API to access the open-sourced HEROW geofencing & location SDK and the [Herow platform](https://herow.io).

* [Herow SDK IOS](https://github.com/herowio/herow-sdk-ios)
* [Herow SDK Android](https://github.com/herowio/herow-sdk-android)

The current Herow-SDK IOS/Android supported version for this Herow-Plugin-Flutter is **7.1.0**.

Plugin development set up
------------
<br>
<details>
<summary>Android</summary>


## herowio/herow-sdk-android packages 

First, in the `android/build.gradle`, add herowio/herow-sdk-android maven github repository in the respositories section :

    rootProject.allprojects {
        repositories {
            maven {
                name = "GitHubPackages"
                url = uri("https://maven.pkg.github.com/herowio/herow-sdk-android")
                credentials {
                    username = properties.getProperty('github.user')
                    password = properties.getProperty('github.token')
                }
            }
        }
    }

Then, add in the [local.properties](android/local.properties) (or create one if you do not have any) :

```
github.user=myusername
github.token=mypassword
```

## io.herow.sdk:detection Dependency 
In the `android/build.gradle` add the following snippet in the dependencies section : 

    implementation 'io.herow.sdk:detection:7.1.0'


Now you are ready to develop the android section :superhero: :tada:

Tips :bulb: : 

To enable import and autocompletion features in your kotlin file for develepment, you must, in your android studio project, right-click on Herow-plugin-flutter, select `flutter` in the menu, and then `Open Android module in Android studio`.

</details>
<br>
<details>
<summary>IOS</summary>



## io.herow.sdk:detection Dependency 
In the `ios/herow_plugin_flutter.podspec` you will find the native sdk dependencies:
 

```
Pod::Spec.new do |s|
  s.name             = 'herow_plugin_flutter'
  s.version          = '7.1.0'
  s.summary          = 'Herow plugin flutter for herow-sdk'
  s.description      = <<-DESC
Herow plugin flutter for herow-sdk
                       DESC
  s.homepage         = 'http://herow.io'
  s.license          = 'MIT'
  s.author           = { 'Herow' => 'contact@herow.io' }
  s.source       = {
    :http => "https://github.com/herowio/herow-sdk-ios/releases/download/v7.1.0/herow_sdk_ios.framework.zip",
    :type => "zip"
  }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency "Herow"
  s.platforms    = { :ios => "11.0" }

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
```


Now you are ready to develop the iOS section :superhero: :tada:


</details>
<br>

# Plugin Development

You will find the [herow_plugin_flutter](lib/herow_plugin_flutter.dart) file in the lib directory. 

 All features are mapped in the `herow.io/sdk` MethodChannel.

## How to add a new mapping function ? 

### Dart

* Add a method in the `HerowPluginFlutter` class : 

```dart
    static Future<void> MyNewMethod() async {
        _channel.invokeMethod("MyNewMethod");
    }
```

* If your method have arguments, add them within the invokeMethod : 

```dart
     _channel.invokeMethod("MyNewMethod",{"argumentName1": args1,"argumentName2": args2 ....});
```

* If your method returns something then return it as a `Future` : 

```dart
    static Future MyNewMethodReturnSomething() async {
        return _channel.invokeMethod("MyNewMethodReturnSomething");
    }
```

### Android

In the [MethodCallHandlerImpl.tk](android/src/main/kotlin/io/herow/herow_plugin_flutter/MethodCallHandlerImpl.kt) add a case that we will be called within the string that you `_channel.invokeMethod` : 

```kotlin
    "MyNewMethod" -> {
        val myArgs = call.argument<String>("argument").toString()
        herowInitializer.MyNewMethod(myArgs)
    }
```

* If your method have arguments, add them within `call.argument<Type>(String)` : 

```kotlin
    "MyNewMethod" -> {
        val myArgs = call.argument<String>("argumentName1").toString()
        herowInitializer.MyNewMethod(myArgs)
    }
```

* If your method returns something then invoke `result.success` or `result.fail` with a logic output : 

```kotlin
    "MyNewMethodReturnSomething" -> {
        val returned = herowInitializer.MyNewMethod()
         result.success(returned)
    }
```

### IOS 
In the [SwiftHerowPluginFlutterPlugin.swift](ios/Classes/SwiftHerowPluginFlutterPlugin.swift) add a case that we will be called within the string that you `_channel.invokeMethod` : 

```swift
    case "MyNewMethod":
            self.herowInitializer.MyNewMethod()
            break

```

* If your method have arguments, add them within `proceedArguments` : 

```swift
    case "MyNewMethod":
            if (proceedArguments(call: call, result: result, keys: [ "argumentName1"])) {
                if let arguments = call.arguments, let arg = arguments as? [String: Any] {
                    if let value: String = arg["argumentName1"] as? String {
                        self.herowInitializer.MyNewMethod(arg:Value)
                    }
                }
            }
            break

```

* If your method returns something then invoke `result.success` or `result.fail` with a logic output : 

```kotlin
    case "MyNewMethod":
            result(self.herowInitializer.MyNewMethod())
            break

```
## Last word

Feel free to complete the [Example](example/lib/main.dart) `main.dart` and do not forget to test it :sunny: