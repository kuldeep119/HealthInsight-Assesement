//
//  BodySignalsCard.swift
//  HealthInsight
//
//  Created by kuldeep Singh on 05/05/26.
//

import SwiftUI

struct BodySignalsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Body Signals")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(hex: "1C1C1E"))
 
            Text("Symptom Trends")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "1C1C1E"))
                .padding(.top, 4)
 
            Text("Compared to last cycle")
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "8E8E93"))
 
            DonutChartView(segments: symptoms)
                .frame(height: 220)
                .padding(.vertical, 8)
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.bottom, 12)
    }
}
 
struct DonutChartView: View {
    let segments: [SymptomSegment]
    @State private var appeared = false
 
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            let radius = size * 0.34
            let lineWidth: CGFloat = size * 0.14
 
            ZStack {
                // Donut arcs
                ForEach(Array(segments.enumerated()), id: \.element.id) { index, seg in
                    let startAngle = startAngle(for: index)
                    let endAngle = endAngle(for: index)
 
                    Circle()
                        .trim(
                            from: startAngle / 360,
                            to: appeared ? endAngle / 360 : startAngle / 360
                        )
                        .stroke(seg.color, lineWidth: lineWidth)
                        .frame(width: radius * 2, height: radius * 2)
                        .rotationEffect(.degrees(-90))
                        .animation(.spring(response: 0.9, dampingFraction: 0.7).delay(Double(index) * 0.1), value: appeared)
                }
 
                // Center hole
                Circle()
                    .fill(Color.white)
                    .frame(width: (radius - lineWidth / 2) * 2)
 
                // Labels positioned around donut
                ForEach(Array(segments.enumerated()), id: \.element.id) { index, seg in
                    let midAngle = midAngle(for: index)
                    let labelRadius = radius + lineWidth + 24
                    let x = center.x + labelRadius * cos(midAngle * .pi / 180)
                    let y = center.y + labelRadius * sin(midAngle * .pi / 180)
 
                    VStack(spacing: 1) {
                        Text("\(Int(seg.percentage))%")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(seg.color == Color(hex: "C5C5F5") ? Color(hex: "8E8EF0") : seg.color)
                        Text(seg.name)
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "8E8E93"))
                    }
                    .position(x: x, y: y)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(Double(index) * 0.1 + 0.4), value: appeared)
                }
            }
            .onAppear { appeared = true }
        }
    }
 
    private func cumulativePercentage(before index: Int) -> Double {
        segments.prefix(index).reduce(0) { $0 + $1.percentage }
    }
 
    private func startAngle(for index: Int) -> Double {
        cumulativePercentage(before: index) / 100 * 360
    }
 
    private func endAngle(for index: Int) -> Double {
        (cumulativePercentage(before: index) + segments[index].percentage) / 100 * 360
    }
 
    private func midAngle(for index: Int) -> Double {
        startAngle(for: index) + segments[index].percentage / 100 * 360 / 2 - 90
    }
}

#Preview {
    BodySignalsCard()
}
