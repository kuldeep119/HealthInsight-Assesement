//
//  BottomTabBar.swift
//  HealthInsight
//
//  Created by kuldeep Singh on 05/05/26.
//

import SwiftUI

struct BottomTabBar: View {
    @Binding var selectedTab: Int
 
    let tabs: [(icon: String, label: String)] = [
        ("house.fill", "Home"),
        ("clock", "Track"),
        ("chart.bar.fill", "Insights"),
        ("plus", ""),
    ]
 
    var body: some View {
        HStack {
            ForEach(tabs.indices, id: \.self) { i in
                Spacer()
                VStack(spacing: 4) {
                    Image(systemName: tabs[i].icon)
                        .font(.system(size: 22, weight: i == selectedTab ? .semibold : .regular))
                        .foregroundColor(i == selectedTab ? Color(hex: "8E8EF0") : Color(hex: "8E8E93"))
                    if !tabs[i].label.isEmpty {
                        Text(tabs[i].label)
                            .font(.system(size: 10, weight: i == selectedTab ? .medium : .regular))
                            .foregroundColor(i == selectedTab ? Color(hex: "8E8EF0") : Color(hex: "8E8E93"))
                    }
                }
                .onTapGesture { withAnimation { selectedTab = i } }
                Spacer()
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 28)
        .background(
            .regularMaterial,
            in: Rectangle()
        )
        .overlay(
            Divider().opacity(0.5),
            alignment: .top
        )
    }
}

#Preview {
    BottomTabBar(selectedTab: .constant(0))
}
