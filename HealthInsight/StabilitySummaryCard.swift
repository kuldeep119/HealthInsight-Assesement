//
//  StabilitySummaryCard.swift
//  HealthInsight
//
//  Created by kuldeep Singh on 05/05/26.
//

import SwiftUI

struct StabilitySummaryCard: View {
    @State private var appeared = false
 
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Stability Summary")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(hex: "1C1C1E"))
 
            Text("Based on your recent logs and symptom patterns.")
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "8E8E93"))
 
            Text("Stability Score")
                .font(.system(size: 13))
                .foregroundColor(Color(hex: "8E8E93"))
 
            Text("78%")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(Color(hex: "1C1C1E"))
 
            // Chart
            StabilityChartView(appeared: appeared)
                .frame(height: 90)
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.bottom, 12)
        .onAppear { withAnimation(.easeOut(duration: 0.6)) { appeared = true } }
    }
}
 
struct StabilityChartView: View {
    let appeared: Bool
 
    let points: [(x: Double, y: Double)] = [
        (0, 65), (0.15, 62), (0.3, 55), (0.45, 48),
        (0.6, 38), (0.72, 28), (0.82, 20), (1.0, 14)
    ]
 
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height - 16
 
            ZStack(alignment: .topLeading) {
                // Y labels
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach(["32d","28d","24d"], id: \.self) { label in
                        Text(label)
                            .font(.system(size: 9))
                            .foregroundColor(Color(hex: "8E8E93"))
                        if label != "24d" { Spacer() }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 2)
                .frame(height: h)
 
                // Area + line
                let pts = points.map { CGPoint(x: $0.x * (w - 28), y: $0.y / 80 * h) }
 
                // Area fill
                Path { path in
                    guard let first = pts.first else { return }
                    path.move(to: CGPoint(x: first.x, y: h))
                    path.addLine(to: first)
                    for pt in pts.dropFirst() { path.addLine(to: pt) }
                    path.addLine(to: CGPoint(x: pts.last!.x, y: h))
                    path.closeSubpath()
                }
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "C5C5F5").opacity(0.55), Color(hex: "C5C5F5").opacity(0.03)],
                        startPoint: .top, endPoint: .bottom
                    )
                )
                .animation(.easeOut(duration: 0.8), value: appeared)
 
                // Line stroke
                Path { path in
                    guard let first = pts.first else { return }
                    path.move(to: first)
                    for pt in pts.dropFirst() { path.addLine(to: pt) }
                }
                .stroke(Color(hex: "8E8EF0"), lineWidth: 2)
 
                // Tooltip at Mar marker (~x=0.6)
                let tipX = 0.6 * (w - 28)
                let tipY = 38.0 / 80.0 * h
 
                Circle()
                    .fill(Color.white)
                    .overlay(Circle().stroke(Color(hex: "8E8EF0"), lineWidth: 2))
                    .frame(width: 10, height: 10)
                    .position(x: tipX, y: tipY)
 
                // Tooltip bubble
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: "1C1C1E"))
                    Text("Stability\nImproving")
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 68, height: 30)
                .position(x: tipX, y: tipY - 24)
 
                // X labels
                HStack {
                    ForEach(["Jan","Feb","Mar","Apr"], id: \.self) { m in
                        Text(m)
                            .font(.system(size: 10, weight: m == "Mar" ? .semibold : .regular))
                            .foregroundColor(m == "Mar" ? Color(hex: "8E8EF0") : Color(hex: "8E8E93"))
                        if m != "Apr" { Spacer() }
                    }
                }
                .padding(.leading, 4)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

#Preview {
    StabilitySummaryCard()
}
