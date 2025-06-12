//
//  UnsolvedApp.swift
//  Unsolved
//
//  Created by Margot Pasquali on 06/05/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

      // Customize back button with a white arrow
      let backButtonImage = UIImage(systemName: "arrow.left")?
          .withTintColor(.pinkRed, renderingMode: .alwaysOriginal)
      UINavigationBar.appearance().backIndicatorImage = backButtonImage
      UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage

      // Hide the "Back" text
      UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .default)

      // Configure App Check with debug provider
      let providerFactory = AppCheckDebugProviderFactory()
      AppCheck.setAppCheckProviderFactory(providerFactory)

      FirebaseApp.configure()

    return true
  }
}

@main
struct UnsolvedApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            WelcomeView(viewModel: StartNewGameViewModel())
        }
    }
}
