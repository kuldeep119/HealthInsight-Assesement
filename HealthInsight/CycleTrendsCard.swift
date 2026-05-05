//
//  CycleTrendsCard.swift
//  HealthInsight
//
//  Created by kuldeep Singh on 05/05/26.
//

import SwiftUI

struct CycleTrendsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Cycle Trends")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(hex: "1C1C1E"))
 
            HStack(alignment: .bottom, spacing: 6) {
                ForEach(cycleTrends) { trend in
                    CycleBarView(trend: trend)
                }
            }
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.bottom, 12)
    }
}
 
struct CycleBarView: View {
    let trend: CycleTrend
    @State private var appeared = false
 
    let maxHeight: CGFloat = 96
 
    var body: some View {
        VStack(spacing: 5) {
            Text("\(trend.days)")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(Color(hex: "1C1C1E"))
 
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(hex: "E8E8FD"))
                    .frame(width: 30, height: maxHeight)
 
                VStack(spacing: 0) {
                    // Menstrual (top, pink)
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color(hex: "F2A0A8"))
                        .frame(height: appeared ? maxHeight * trend.menstrualRatio : 0)
 
                    // Follicular (middle, light purple)
                    Rectangle()
                        .fill(Color(hex: "C5C5F5"))
                        .frame(height: appeared ? maxHeight * trend.follicularRatio : 0)
 
                    // Luteal (bottom, purple)
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color(hex: "8E8EF0"))
                        .frame(height: appeared ? maxHeight * trend.lutealRatio : 0)
                }
                .frame(width: 30)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .animation(.spring(response: 0.7, dampingFraction: 0.75).delay(Double(cycleTrends.firstIndex(where: { $0.id == trend.id }) ?? 0) * 0.08), value: appeared)
            }
 
            Text(trend.month)
                .font(.system(size: 10))
                .foregroundColor(Color(hex: "8E8E93"))
        }
        .frame(maxWidth: .infinity)
        .onAppear { appeared = true }
    }
}

#Preview {
    CycleTrendsCard()
}
