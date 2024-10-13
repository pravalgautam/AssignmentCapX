//
//  HomeButton.swift
//  CapX
//
//  Created by Praval Gautam on 14/10/24.
//

import SwiftUI

struct HomeButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color
    var textColor: Color = .white
    var cornerRadius: CGFloat = 20
    var padding: CGFloat = 15
    var image : String
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.white)
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(textColor)
                    .padding(.vertical, padding)
                    .padding(.leading, 5)
            }
            .frame(maxWidth: UIScreen.main.bounds.width / 2)
            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor))
            .shadow(radius: 5)
            .padding(.horizontal, 5)
        }
        .accessibilityLabel(title)
        .buttonStyle(PlainButtonStyle())
    }
}


