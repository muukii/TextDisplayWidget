//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Muukii on 2025/01/15.
//

import SwiftUI
import WidgetKit
import SwiftData
import SharedTypes

struct Provider: AppIntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
  }

  func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry
  {
    SimpleEntry(date: Date(), configuration: configuration)
  }

  func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<
    SimpleEntry
  > {
    var entries: [SimpleEntry] = []

    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0..<5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate, configuration: configuration)
      entries.append(entry)
    }

    return Timeline(entries: entries, policy: .atEnd)
  }

  //    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
  //        // Generate a list containing the contexts this widget is relevant in.
  //    }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationAppIntent
}


struct WidgetExtensionEntryView: View {
  
  var entry: Provider.Entry
  
  @Query var model: [SharedTypes.Item]
  
  var body: some View {
    VStack {
      Text(entry.date, style: .time)

      TimelineView(.animation()) { context in
        Text(Date().description)
      }
      
      ForEach(model) { item in
        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
      }
            
      Button("Run", intent: CompleteTaskIntent())
    }
  }
}

struct WidgetExtension: Widget {
  let kind: String = "WidgetExtension"

  var body: some WidgetConfiguration {
    AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) {
      entry in
      WidgetExtensionEntryView(entry: entry)
        .containerBackground(.fill.tertiary, for: .widget)
        .modelContainer(for: [Item.self])
    }
  }
}

extension ConfigurationAppIntent {
  fileprivate static var smiley: ConfigurationAppIntent {
    let intent = ConfigurationAppIntent()
    intent.favoriteEmoji = "😀"
    return intent
  }

  fileprivate static var starEyes: ConfigurationAppIntent {
    let intent = ConfigurationAppIntent()
    intent.favoriteEmoji = "🤩"
    return intent
  }
}

#Preview(as: .systemSmall) {
  WidgetExtension()
} timeline: {
  SimpleEntry(date: .now, configuration: .smiley)
  SimpleEntry(date: .now, configuration: .starEyes)
}
