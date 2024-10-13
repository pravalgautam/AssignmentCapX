//
//  NotificationIconView.swift
//  CapX
//
//  Created by Praval Gautam on 14/10/24.
//

import SwiftUI

struct NotificationIconView: View {
    @State private var hasNewNotifications = true

    var body: some View {
        HStack {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "bell.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.white)

                if hasNewNotifications {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 10, height: 10)
                        .offset(x: 10, y: -5)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NotificationIconView()
}
