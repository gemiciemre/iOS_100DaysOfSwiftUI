//
//  DetailView.swift
//  Day68-Project14-Bucketlist
//
//  Created by Emre Gemici on 18.05.2023.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave : (Location) -> Void
    
    @State private var name: String
    @State private var description : String
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place Details")
            .toolbar{
                Button("Save"){
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
    init(location : Location, onSave: @escaping (Location) -> Void){
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example){ newLocation in
        }
    }
}
