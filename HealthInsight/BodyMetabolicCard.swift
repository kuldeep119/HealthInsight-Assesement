//
//  BodyMetabolicCard.swift
//  HealthInsight
//
//  Created by kuldeep Singh on 05/05/26.
//

import SwiftUI

struct BodyMetabolicCard: View {
    @State private var isMonthly = true
 
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Body & Metabolic Trends")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(hex: "1C1C1E"))
                    Text("Your weight in kg")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "8E8E93"))
                }
                Spacer()
                // Toggle
                HStack(spacing: 0) {
                    ForEach(["Monthly","Weekly"], id: \.self) { label in
                        Text(label)
                            .font(.system(size: 12, weight: (label == "Monthly") == isMonthly ? .medium : .regular))
                            .foregroundColor((label == "Monthly") == isMonthly ? .white : Color(hex: "8E8E93"))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                (label == "Monthly") == isMonthly
                                    ? Color(hex: "1C1C1E")
                                    : Color.clear
                            )
                            .cornerRadius(8)
                            .onTapGesture { withAnimation { isMonthly = label == "Monthly" } }
                    }
                }
                .background(Color(hex: "F2F2F7"))
                .cornerRadius(9)
            }
 
            WeightChartView()
                .frame(height: 100)
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.bottom, 12)
    }
}
 
struct WeightChartView: View {
    let data: [(String, Double)] = [("Jan",58),("Feb",57),("Mar",72),("Apr",64),("May",61)]
 
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height - 18
            let minV = 40.0, maxV = 80.0
 
            let pts: [CGPoint] = data.enumerated().map { i, d in
                let x = CGFloat(i) / CGFloat(data.count - 1) * (w - 24) + 20
                let y = h - CGFloat((d.1 - minV) / (maxV - minV)) * h
                return CGPoint(x: x, y: y)
            }
 
            ZStack(alignment: .topLeading) {
                // Y labels + grid lines
                ForEach([(75.0,"75"),(50.0,"50"),(25.0,"25")], id: \.0) { val, label in
                    let y = h - CGFloat((val - minV) / (maxV - minV)) * h
                    HStack(spacing: 4) {
                        Text(label)
                            .font(.system(size: 9))
                            .foregroundColor(Color(hex: "8E8E93"))
                            .frame(width: 16, alignment: .trailing)
                        Rectangle()
                            .fill(Color(hex: "F2F2F7"))
                            .frame(height: 0.7)
                    }
                    .offset(y: y - 6)
                }
 
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
                        colors: [Color(hex: "F2A0A8").opacity(0.4), Color(hex: "F2A0A8").opacity(0.02)],
                        startPoint: .top, endPoint: .bottom
                    )
                )
 
                // Line
                Path { path in
                    guard let first = pts.first else { return }
                    path.move(to: first)
                    for pt in pts.dropFirst() { path.addLine(to: pt) }
                }
                .stroke(Color(hex: "E87A84"), lineWidth: 1.8)
 
                // X labels
                HStack(spacing: 0) {
                    ForEach(data, id: \.0) { d in
                        Text(d.0)
                            .font(.system(size: 9))
                            .foregroundColor(Color(hex: "8E8E93"))
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.leading, 20)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

#Preview {
    BodyMetabolicCard()
}
