//
//  GridCard.swift
//  CapX
//
//  Created by Praval Gautam on 14/10/24.
//

import SwiftUI

struct GridCard: View {
    var backgroundColor: LinearGradient
    var profileImageName: String
    var companyName: String
    var price: String
    var changeAmount: String

    var body: some View {
        ZStack {
            backgroundColor
                .cornerRadius(34)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(profileImageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(companyName)
                            .foregroundStyle(.gray)
                            .appFontSizeWeight(size: 16, weight: .semibold)
                        Text("CapxLive")
                            .foregroundStyle(.black)
                            .appFontSizeWeight(size: 12, weight: .regular)
                    }
                }
                Text(price)
                    .appFontSizeWeight(size: 20, weight: .semibold)
                    .foregroundColor(.black)
                
                HStack(spacing: 5) {
                    Image(systemName: "arrowtriangle.up.circle.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.green)
                    
                    Text(changeAmount)
                        .foregroundColor(.gray)
                        .appFontSizeWeight(size: 12, weight: .semibold)
                }
            }
            .padding()
        }
        .frame(width: 160, height: 160)
    }
}

