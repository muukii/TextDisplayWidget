//
//  ContentView.swift
//  TextDisplayWidget
//
//  Created by Muukii on 2025/01/15.
//

import SharedTypes
import SwiftData
import SwiftUI
import UserNotifications

struct ContentView: View {

  @Environment(\.modelContext) private var modelContext

  @Query private var items: [Item]

  @State var isAddingNew: Bool = false
  @State var editingItem: Item?

  var body: some View {
    NavigationSplitView {
      List {

        ForEach(items) { item in
          Button("\(item.text)") { 
            editingItem = item
          }
        }
        .onDelete(perform: deleteItems)
      }
      .sheet(item: $editingItem, content: { item in
        NavigationStack {
          EditorView(
            text: item.text,
            onCancel: {
              editingItem = nil
            },
            onSave: { text in
              editingItem = nil
              updateItem(text: text, for: item)
            })
        }
      })
      .sheet(
        isPresented: $isAddingNew,
        content: {
          NavigationStack {
            EditorView(
              text: "",
              onCancel: {
                isAddingNew = false
              },
              onSave: { text in
                isAddingNew = false
                saveItem(text: text)
              })
          }
        }
      )
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
    } detail: {
      Text("Select an item")
    }
  }

  private func addItem() {
    isAddingNew = true
  }
  
  private func saveItem(text: String) {
    withAnimation {
      try? modelContext.transaction {        
        let newItem = Item(text: text)
        modelContext.insert(newItem)        
      }
    }
  }
  
  
  private func updateItem(text: String, for item: Item) {
    withAnimation {
      try? modelContext.transaction {        
        item.text = text
      }
    }
  }

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(items[index])
      }
    }
  }
}

struct EditorView: View {

  @State var text: String
  
  @FocusState var isFocused

  let onCancel: () -> Void
  let onSave: (String) -> Void

  var body: some View {

    TextEditor(text: $text)
      .focused($isFocused)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            onCancel()
          }
        }
        ToolbarItem(placement: .primaryAction) {
          Button("Save") {
            onSave(text)
          }
        }
      }
      .onAppear {
        isFocused = true      
      }

  }

}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
