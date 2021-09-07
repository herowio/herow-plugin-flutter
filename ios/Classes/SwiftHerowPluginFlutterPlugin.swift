import Flutter
import UIKit
import herow_sdk_ios

public class SwiftHerowPluginFlutterPlugin: NSObject, FlutterPlugin {

 let herowInitializer: HerowInitializer

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "herow_plugin_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftHerowPluginFlutterPlugin()


    registrar.addMethodCallDelegate(instance, channel: channel)
  }


   public override init() {
        self.herowInitializer = HerowInitializer.shared
    }

    func proceedArguments(call: FlutterMethodCall, result: @escaping FlutterResult, keys: [String]) -> Bool {
        if let arguments = call.arguments,
            let arg = arguments as? [String: Any] {
            for key in keys {
                if arg[key] == nil {
                    result(FlutterError(code: "ARGUMENT_ERRROR", message: "Key \(key) is empty", details: nil))
                    return false
                }
            }
        } else if (call.arguments == nil) {
            result(FlutterError(code: "ARGUMENT_ERRROR", message: "Arguements is empty", details: nil))
            return false
        }
        return true
    }


  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     switch call.method {
     	case "configApp":
     		var herowPlatForm: String ?
     		var apiKey: String? 
     		var secret: String? 
     		 if (proceedArguments(call: call, result: result, keys: [ "herowPlatForm"])) {
             if let arguments = call.arguments, let arg = arguments as? [String: Any] {
                if let value: String = arg["herowPlatForm"] as? String {
                  herowPlatForm = value
                  }
             }
            }
             if (proceedArguments(call: call, result: result, keys: [ "apiKey"])) {
             if let arguments = call.arguments, let arg = arguments as? [String: Any] {
                if let value: String = arg["apiKey"] as? String {
                  apiKey = value
                  }
             }
            }
             if (proceedArguments(call: call, result: result, keys: [ "secret"])) {
             if let arguments = call.arguments, let arg = arguments as? [String: Any] {
                if let value: String = arg["secret"] as? String {
                  secret = value
                  }
             }
            }

            guard let herowPlatForm = herowPlatForm, let apiKey = apiKey, let secret = secret else {
             result(FlutterError(code: "ARGUMENT_ERRROR", message: "Arguements is empty", details: nil))
            }

            var platorm: HerowPlatform = .prod
            if herowPlatForm == "preprod" || herowPlatForm == "PRE_PROD" {
            	platorm = .preprod
            }
            self.herowInitializer.configPlatform(platorm).configApp(identifier: apiKey, sdkKey: secret).synchronize()




        case "launchClickAndCollect":
            self.herowInitializer.launchClickAndCollect()
            break
        case "stopClickAndCollect":
            self.herowInitializer.stopClickAndCollect()
            break

         case "isOnClickAndCollect":
            result(self.herowInitializer.isOnClickAndCollect()
            break

        case "setCustomId":
            if (proceedArguments(call: call, result: result, keys: [ "customId"])) {
             if let arguments = call.arguments, let arg = arguments as? [String: Any] {
                if let value: String = arg["customId"] as? String {
                  self.herowInitializer.setCustomId(value)
                  }
             }
            }
            break

        case "removeCustomId":
            self.herowInitializer.removeCustomId()
            break

        case "acceptOptin":
            self.herowInitializer.acceptOptin()
            break

         case "refuseOptin":
            self.herowInitializer.refuseOptin()
            break
       
        case "getOptin":
            result(self.herowInitializer.getOptinValue())
            break
        default:
            result(FlutterMethodNotImplemented)
        }
  }
}
