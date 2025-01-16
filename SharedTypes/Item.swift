//
//  Item.swift
//  TextDisplayWidget
//
//  Created by Muukii on 2025/01/15.
//

import Foundation
import SwiftData

@Model
public final class Item {
  public var timestamp: Date

  public init(timestamp: Date) {
    self.timestamp = timestamp
  }
}
