//
//  LoadingView.swift
//  CapX
//
//  Created by Praval Gautam on 14/10/24.
//


import SwiftUI
import Combine

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack {

            self.content()
                .disabled(self.isShowing)
                .blur(radius: self.isShowing ? 3 : 0)
            
            if isShowing {
                ZStack {
                    
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack(spacing: 20) {
                        ActivityIndicator1()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)
                    }
                    .padding(30)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .transition(.opacity) // Smooth transition
                //    .animation(.easeInOut(duration: 0.3))
                }
            }
        }
    }
}

struct ActivityIndicator1: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(calcScale(index: index))
                        .offset(y: calcYOffset(geometry))
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
//                .animation(Animation
//                    .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
//                    .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
    
    func calcScale(index: Int) -> CGFloat {
        return (!isAnimating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5)
    }
    
    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
}

