//
//  FontAppSize.swift
//  CapX.live
//
//  Created by Praval Gautam on 12/10/24.
//

import SwiftUI

struct AppFontOnlySizeModifier: ViewModifier {
    var size: CGFloat

    func body(content: Content) -> some View {
        content.font(Font.custom("Poppins-Regular", size: size))
    }
}

struct AppFontSizeWeightModifier: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight

    func body(content: Content) -> some View {
        switch weight {
        case .bold:
            content.font(Font.custom("Poppins-Bold", size: size))
        case .semibold:
            content.font(Font.custom("Poppins-SemiBold", size: size))
        case .medium:
            content.font(Font.custom("Poppins-Medium", size: size))
        case .light:
            content.font(Font.custom("Poppins-Light", size: size))
        case .ultraLight: 
            content.font(Font.custom("Poppins-ExtraLight", size: size))
        case .thin:
            content.font(Font.custom("Poppins-Thin", size: size))
        case .heavy:
            content.font(Font.custom("Poppins-Black", size: size))
        default:
            content.font(Font.custom("Poppins-Regular", size: size))
        }
    }
}

extension View {
    func appFontOnlySize(size: CGFloat) -> some View {
        self.modifier(AppFontOnlySizeModifier(size: size))
    }
    
    func appFontSizeWeight(size: CGFloat, weight: Font.Weight) -> some View {
        self.modifier(AppFontSizeWeightModifier(size: size, weight: weight))
    }
}

