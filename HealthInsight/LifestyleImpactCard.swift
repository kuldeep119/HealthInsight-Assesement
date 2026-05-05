//
//  LifestyleImpactCard.swift
//  HealthInsight
//
//  Created by kuldeep Singh on 05/05/26.
//

import SwiftUI


struct LifestyleImpactCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Lifestyle Impact")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(hex: "1C1C1E"))
                Spacer()
                HStack(spacing: 4) {
                    Text("4 months")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "8E8E93"))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10))
                        .foregroundColor(Color(hex: "8E8E93"))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color(hex: "F2F2F7"))
                .cornerRadius(8)
            }
 
            Text("Correlation Strength")
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "8E8E93"))
 
            VStack(spacing: 8) {
                ForEach(lifestyleRows) { row in
                    LifestyleRowView(row: row)
                }
            }
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.bottom, 12)
    }
}
 
struct LifestyleRowView: View {
    let row: LifestyleRow
    @State private var appeared = false
 
    var body: some View {
        HStack(spacing: 8) {
            Text(row.label)
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "8E8E93"))
                .frame(width: 58, alignment: .leading)
 
            HStack(spacing: 3) {
                ForEach(Array(row.colors.enumerated()), id: \.offset) { i, color in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(height: 22)
                        .frame(maxWidth: .infinity)
                        .opacity(appeared ? 1 : 0)
                        .scaleEffect(x: appeared ? 1 : 0, anchor: .leading)
                        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(Double(i) * 0.04), value: appeared)
                }
            }
        }
        .onAppear { appeared = true }
    }
}

#Preview {
    LifestyleImpactCard()
}
