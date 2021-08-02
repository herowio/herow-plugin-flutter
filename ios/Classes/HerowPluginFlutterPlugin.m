#import "HerowPluginFlutterPlugin.h"
#if __has_include(<herow_plugin_flutter/herow_plugin_flutter-Swift.h>)
#import <herow_plugin_flutter/herow_plugin_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "herow_plugin_flutter-Swift.h"
#endif

@implementation HerowPluginFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHerowPluginFlutterPlugin registerWithRegistrar:registrar];
}
@end
