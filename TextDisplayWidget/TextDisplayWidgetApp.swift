//
//  TextDisplayWidgetApp.swift
//  TextDisplayWidget
//
//  Created by Muukii on 2025/01/15.
//

import SwiftData
import SwiftUI
import SharedTypes

@main
struct TextDisplayWidgetApp: App {
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Item.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(sharedModelContainer)
  }
}
