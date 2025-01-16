//
//  AppIntent.swift
//  WidgetExtension
//
//  Created by Muukii on 2025/01/15.
//

import AppIntents
import WidgetKit

struct ConfigurationAppIntent: WidgetConfigurationIntent {
  static var title: LocalizedStringResource { "Configuration" }
  static var description: IntentDescription { "This is an example widget." }

  // An example configurable parameter.
  @Parameter(title: "Favorite Emoji", default: "😃")
  var favoriteEmoji: String

  @Parameter(title: "Items", optionsProvider: ItemProvider())
  var items: [String]?
}

private struct ItemProvider: DynamicOptionsProvider {
  
  typealias Result = [String]

  func results() async throws -> [String] {
    return [
      "Item 1",
      "Item 2",
      "Item 3",      
    ]
  }
  
}

//struct ItemQuery: EntityQuery {
//  
//    
//}

struct CompleteTaskIntent: AppIntent {

  static var title: LocalizedStringResource = "CompleteTask"

  func perform() async throws -> some IntentResult {
    // タスク完了の処理
    return .result()
  }
}
