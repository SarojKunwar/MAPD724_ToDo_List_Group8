//
//  AddTodo.swift
//  todo-app
//
//  Created by saroj K on 07/04/2024.
//

import SwiftUI

struct AddTodo: View {
    
    @State private var title: String = "";
    @State private var description: String = "";
    @State var imageURL: URL?;
    @State private var pickerSelected: Bool = false;
    @State private var pdfPickerSelected: Bool = false;
    
    @EnvironmentObject var state: GlobalState
    
    
    var body: some View {
        VStack(spacing: 10){
            Text("Add Todo")
                .bold()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.bottom)
            Button{pickerSelected=true} label: {
                Text("Select Image")
            }
            if(imageURL != nil){
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                } placeholder: {
                    ProgressView()
                }
            }
            TextField(
                "Title",
                text: $title
            )
            .disableAutocorrection(true)
            TextField(
                "Description",
                text: $description
            )
            .disableAutocorrection(true)
            .padding(.bottom)
            Button{
                let todo: Todo = Todo(id: UUID().uuidString, title: title, description: description,  image: imageURL, isImportant: false)
                state.todos.append(todo)
                
                title=""
                description = ""
                imageURL = nil
                
            } label: {
                Text("Add Todo")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .contentMargins(10)
            Spacer()
        }
        .fileImporter(isPresented: $pickerSelected, allowedContentTypes: [.image]) { result in
            switch result {
                case .success(let url):
                    imageURL = url
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        .padding(.all)
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    AddTodo()
}
