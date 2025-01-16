//
//  AppIntent.swift
//  WidgetExtension
//
//  Created by Muukii on 2025/01/15.
//

import AppIntents
import WidgetKit
import SwiftData
import SharedTypes

struct ConfigurationAppIntent: WidgetConfigurationIntent {
  static var title: LocalizedStringResource { "Configuration" }
  static var description: IntentDescription { "This is an example widget." }

  // An example configurable parameter.
  @Parameter(title: "Favorite Emoji", default: "😃")
  var favoriteEmoji: String

  @Parameter(title: "Item")
  var item: ItemEntity?
}

struct ItemEntity: AppEntity {
  
  typealias DefaultQuery = ItemEntityQuery
  
  typealias ID = String

  var id: ID
  var text: String
  
  init(item: Item) {
    self.id = item.identifier
    self.text = item.text
  }

  static var typeDisplayRepresentation: TypeDisplayRepresentation {    
    "Text"
  }
  
  static var defaultQuery: ItemEntityQuery {
    .init()  
  }

  var displayRepresentation: DisplayRepresentation {
    .init(title: "\(text)")
  }
    
}

struct ItemEntityQuery: EntityQuery {
  
  typealias Entity = ItemEntity  
  
  func entities(for identifiers: [String]) async throws -> [ItemEntity] {
    
    let context = ModelContext.init(try ModelContainer(for: SharedTypes.Item.self, configurations: .init()))
    
    let items = try context.fetch(.init(predicate: #Predicate<SharedTypes.Item> {
      identifiers.contains($0.identifier)
    }))
    
    return items.map { item in 
      return .init(item: item)
    }
        
  }
  
  func defaultResult() async -> Entity? {
    try? await suggestedEntities().first
  }
  
  func suggestedEntities() async throws -> [Entity] {
    
    let context = ModelContext.init(try ModelContainer(for: SharedTypes.Item.self, configurations: .init()))

    let items = try context.fetch(.init(predicate: #Predicate<SharedTypes.Item> { _ in
      return true
    }))
    
    return items.map { item in 
      return .init(item: item)
    }
  }
    
}

struct CompleteTaskIntent: AppIntent {

  static var title: LocalizedStringResource = "CompleteTask"

  func perform() async throws -> some IntentResult {
    // タスク完了の処理
    return .result()
  }
}
