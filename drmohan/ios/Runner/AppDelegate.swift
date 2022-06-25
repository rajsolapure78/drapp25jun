import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // TODO: Add your Google Maps API key
        GMSServices.provideAPIKey("AIzaSyBW9oWaWn2q4Gj5LeQ7T1H6zGyo8ivTqwU")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
