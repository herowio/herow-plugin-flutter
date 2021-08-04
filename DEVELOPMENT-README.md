Herow Plugin flutter
------------
This plugin provides a cross-platform (iOS, Android) API to access the open-source Herow SDK location
features and the [Herow platform](https://herow.io).

* [Herow SDK IOS](https://github.com/herowio/herow-sdk-ios)
* [Herow SDK Android](https://github.com/herowio/herow-sdk-android)

The current Herow-SDK IOS/Android supported version for Herow-Plugin-Flutter is **7.1.0**.

Setup for plugin development
------------

<details>
<summary>Android</summary>

## herowio/herow-sdk-android packages 

First, in the `android/build.gradle` add herowio/herow-sdk-android maven github repository in the respositories section :

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

Then, put in the [local.properties](android/local.properties) (or create one if you don't have one) :

```
github.user=myusername
github.token=mypassword
```

## io.herow.sdk:detection Dependency 
In the `android/build.gradle` add the following snippet in the dependencies section : 

    implementation 'io.herow.sdk:detection:7.1.0'


Now you are ready to develop the android part :superhero: :tada:

Tips :bulb: : 

In order to have import and autocompletion in your kotlin file when you develop :

On your android studio project, right click on Herow-plugin-flutter, select `flutter` in the menu and then `Open Android module in Android studio`

</details>

<details>
<summary>IOS</summary>

  **Not implemented yet**

</details>


# Plugin Development

You will find in the lib directory the [herow_plugin_flutter](lib/herow_plugin_flutter.dart) file. 

 All features are map to the `herow.io/sdk` MethodChannel.

## How to add a new mapping function ? 

### Dart

* Add a method in the `HerowPluginFlutter` class : 

```dart
    static Future<void> MyNewMethod() async {
        _channel.invokeMethod("MyNewMethod");
    }
```

* If your method have an argument, pass it to the invokeMethod : 

```dart
     _channel.invokeMethod("MyNewMethod",{"argumentName1": args1,"argumentName2": args2 ....});
```

* If your method must return something then return it as a `Future` : 

```dart
    static Future MyNewMethodReturnSomething() async {
        return _channel.invokeMethod("MyNewMethodReturnSomething");
    }
```

### Android

In the [MethodCallHandlerImpl.tk](android/src/main/kotlin/io/herow/herow_plugin_flutter/MethodCallHandlerImpl.kt) add a case that we will be call with the string that you `_channel.invokeMethod` : 

```kotlin
    "MyNewMethod" -> {
        val myArgs = call.argument<String>("argument").toString()
        herowInitializer.MyNewMethod(myArgs)
    }
```

* If your method have an argument, call it with `call.argument<Type>(String)` : 

```kotlin
    "MyNewMethod" -> {
        val myArgs = call.argument<String>("argumentName1").toString()
        herowInitializer.MyNewMethod(myArgs)
    }
```

* If your method must return something then invoke `result.success` or `result.fail` with some logic  : 

```kotlin
    "MyNewMethodReturnSomething" -> {
        val returned = herowInitializer.MyNewMethod()
         result.success(returned)
    }
```

### IOS 

**Not Implemented yet**

## Last word

Feel free to complete the [Example](example/lib/main.dart) `main.dart` and don't forget to test it :sunny: