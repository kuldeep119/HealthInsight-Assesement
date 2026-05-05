//
//  ContentView.swift
//  HealthInsight
//
//  Created by kuldeep Singh on 05/05/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 2
 
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(hex: "F2F2F7").ignoresSafeArea()
 
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Fixed header offset for scroll content
                    Color.clear.frame(height: 8)
 
                    StabilitySummaryCard()
                    CycleTrendsCard()
                    BodyMetabolicCard()
                    BodySignalsCard()
                    LifestyleImpactCard()
 
                    Color.clear.frame(height: 20)
                }
                .padding(.horizontal, 14)
            }
            .safeAreaInset(edge: .top) {
                VStack(spacing: 0) {
                    NavBar()
                }
                .background(Color(hex: "F2F2F7"))
            }
 
            BottomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
}
