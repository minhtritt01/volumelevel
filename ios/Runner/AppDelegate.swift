import Flutter
import UIKit
import AVFoundation
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let batteryChannel = FlutterMethodChannel(
        name: "com.example.dev/volume",
        binaryMessenger: controller.binaryMessenger
      )
            batteryChannel.setMethodCallHandler({
              [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
              // This method is invoked on the UI thread.
              guard call.method == "getVolumeLevel" else {
                result(FlutterMethodNotImplemented)
                return
              }
              self?.receiveVolumeLevel(result: result)
            })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    private func receiveVolumeLevel(result: FlutterResult) {
            let audioSession = AVAudioSession.sharedInstance()
            let vol=audioSession.outputVolume
            do {
                try audioSession.setActive(true)
            } catch {
                print("Error Setting Up Audio Session")
            }
            print("volume \(vol)")
          
            result(Double(vol))
          
        }
}
