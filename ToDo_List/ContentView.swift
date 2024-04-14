//
//  ContentView.swift
//  ToDo_List
//
//  Created by Saroj Kunwar on 2024-04-08.
//

import SwiftUI

class GlobalState: ObservableObject {
    @Published var todos: [ToDo] = []

}

struct ContentView: View {
        
    @StateObject var state = GlobalState()
    
    var body: some View {
        TabView{
            AddTodo()
                .environmentObject(state)
                .tabItem {
                    Label("Add Todo", systemImage: "pencil.tip.crop.circle.badge.plus.fill")
                }
            ListTodo()
                .environmentObject(state)
                .tabItem {
                    Label("List Todo", systemImage: "list.bullet")
                }
        }
    }
}
#Preview {
    ContentView()
}
