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
  
  @Attribute(.unique)
  public var identifier: String
    
  public var text: String
  
  public init(text: String) {
    self.identifier = UUID().uuidString
    self.text = text
  }
}
