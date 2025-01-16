//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by Muukii on 2025/01/15.
//

import SwiftUI
import WidgetKit

@main
struct WidgetExtensionBundle: WidgetBundle {
  var body: some Widget {
    WidgetExtension()
    WidgetExtensionControl()
    WidgetExtensionLiveActivity()
  }
}
