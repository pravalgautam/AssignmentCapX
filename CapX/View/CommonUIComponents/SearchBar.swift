//
//  SearchBar.swift
//  CapX
//
//  Created by Praval Gautam on 14/10/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isVisible: Bool
    var action: () -> Void

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(height: 42)
                
                TextField("Search", text: $searchText, onCommit: {
                    action()
                    // Removed immediate hiding
                })
                .foregroundColor(.gray)
                .padding(10)
                .background(Color.clear)
                .cornerRadius(10)
            }
            
            Button(action: {
                action()
                // Removed immediate hiding
            }) {
                Text("Search")
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.vertical)
    }
}
