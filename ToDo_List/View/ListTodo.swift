//
//  ListTodo.swift
//  todo-app
//
//  Created by Prasiddha Neupane on 07/04/2024.
//

import SwiftUI

struct ListTodo: View {
    
    @EnvironmentObject var state: GlobalState
    
    @State private var showFavoritesOnly = false
    
    var filteredTodos: [Todo] {
        state.todos.filter { todo in
            (!showFavoritesOnly || todo.isImportant)
            }
        }
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:0){
                Text("Todos").bold().font(.title)
                Spacer()
            }
            .padding(.all)
            if state.todos.count==0 {
                Spacer()
                Text("No todos found").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            else{
                List{
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("Important only")
                    }
                    ForEach(filteredTodos, id: \.self){ todo in
                        TodoItem(todo: todo, setImportant:self.setImportant)
                            .swipeActions {
                                Button {
                                    state.todos.remove(at: state.todos.firstIndex(of: todo)!)
                                }label: {
                                    Text("Delete")
                                }
                                .tint(.red)
                            }
                    }
                }
                .animation(.default, value: filteredTodos)
                
            }
            Spacer()
        }
    }
    
    func setImportant(todo: Todo) {
        state.todos[state.todos.firstIndex(of: todo)!].isImportant.toggle()
    }
}

struct TodoItem: View {
    
    var todo: Todo
    var setImportant : (_ todo: Todo) -> Void
    
    var body: some View{
        HStack(alignment: .top) {
            AsyncImage(url: todo.image)
            { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80, alignment: .top)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading){
                Text(todo.title).bold().font(.title2)
                Text(todo.description)
            }
            Spacer()
            Button {
                self.setImportant(todo)
            } label: {
                Label("Toggle Favorite", systemImage: todo.isImportant ? "star.fill" : "star")
                    .labelStyle(.iconOnly)
                    .foregroundStyle(todo.isImportant ? .yellow : .gray)
            }
            
            
        }
    }
}

#Preview {
    ListTodo()
}
