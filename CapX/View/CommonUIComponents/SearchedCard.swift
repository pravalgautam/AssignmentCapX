//
//  SearchedCard.swift
//  CapX
//
//  Created by Praval Gautam on 14/10/24.
//

import SwiftUI

struct SearchedCard: View {
    var backgroundColor: LinearGradient
    var companyName: String
    var price: String
    var changePercentage: String
    var body: some View {
        ZStack {
            backgroundColor
            HStack{
                VStack(alignment:.leading) {
                    
                    HStack {
                        Image("profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        VStack(alignment:.leading) {
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
                        
                        Text(changePercentage)
                            .foregroundColor(.gray)
                            .appFontSizeWeight(size: 12, weight: .semibold)
                    }
                }
                Spacer()
                Image("st2")
                    .resizable()
                    .frame(width: 120,height: 100)
            }.padding()
        }
        .frame(width: Constants.Screen.width - 50, height: 160)
        .cornerRadius(34)
        .shadow(radius: 10)
    }
}

