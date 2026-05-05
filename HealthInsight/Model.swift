//
//  Model.swift
//  HealthInsight
//
//  Created by kuldeep Singh on 05/05/26.
//
import SwiftUI
import Charts

struct CycleTrend: Identifiable {
    let id = UUID()
    let month: String
    let days: Int
    let menstrualRatio: Double
    let follicularRatio: Double
    let lutealRatio: Double
}
 
struct WeightEntry: Identifiable {
    let id = UUID()
    let month: String
    let weight: Double
}
 
struct SymptomSegment: Identifiable {
    let id = UUID()
    let name: String
    let percentage: Double
    let color: Color
}
 
struct LifestyleRow: Identifiable {
    let id = UUID()
    let label: String
    let colors: [Color]
}
 
// MARK: - Sample Data
 
let cycleTrends: [CycleTrend] = [
    CycleTrend(month: "Jan", days: 28, menstrualRatio: 0.15, follicularRatio: 0.65, lutealRatio: 0.20),
    CycleTrend(month: "Feb", days: 30, menstrualRatio: 0.12, follicularRatio: 0.68, lutealRatio: 0.20),
    CycleTrend(month: "Mar", days: 28, menstrualRatio: 0.14, follicularRatio: 0.64, lutealRatio: 0.22),
    CycleTrend(month: "Apr", days: 32, menstrualRatio: 0.12, follicularRatio: 0.66, lutealRatio: 0.22),
    CycleTrend(month: "May", days: 28, menstrualRatio: 0.14, follicularRatio: 0.64, lutealRatio: 0.22),
    CycleTrend(month: "Jun", days: 28, menstrualRatio: 0.14, follicularRatio: 0.64, lutealRatio: 0.22),
]
 
let weightEntries: [WeightEntry] = [
    WeightEntry(month: "Jan", weight: 58),
    WeightEntry(month: "Feb", weight: 57),
    WeightEntry(month: "Mar", weight: 72),
    WeightEntry(month: "Apr", weight: 64),
    WeightEntry(month: "May", weight: 61),
]
 
let symptoms: [SymptomSegment] = [
    SymptomSegment(name: "Mood",     percentage: 30, color: Color(hex: "C5C5F5")),
    SymptomSegment(name: "Bloating", percentage: 31, color: Color(hex: "8E8EF0")),
    SymptomSegment(name: "Fatigue",  percentage: 21, color: Color(hex: "F2A0A8")),
    SymptomSegment(name: "Acne",     percentage: 18, color: Color(hex: "A8C9B8")),
]
 
let lifestyleRows: [LifestyleRow] = [
    LifestyleRow(label: "Sleep", colors: [
        Color(hex: "8E8EF0"), Color(hex: "8E8EF0"),Color(hex: "8E8EF0"),
        Color(hex: "8E8EF0"), Color(hex: "8E8EF0"), Color(hex: "8E8EF0"),
        Color(hex: "8E8EF0"), Color(hex: "E8E8FD"), Color(hex: "E8E8FD")
    ]),
    LifestyleRow(label: "Hydrate", colors: [
        Color(hex: "F2A0A8"), Color(hex: "F2A0A8"), Color(hex: "F2A0A8"),
        Color(hex: "E8E8FD"), Color(hex: "E8E8FD"), Color(hex: "E8E8FD"),
        Color(hex: "E8E8FD"), Color(hex: "E8E8FD"), Color(hex: "E8E8FD")
    ]),
    LifestyleRow(label: "Caffeine", colors: [
        Color(hex: "A8C9B8"), Color(hex: "A8C9B8"), Color(hex: "A8C9B8"),
        Color(hex: "A8C9B8"), Color(hex: "B8D4C8"), Color(hex: "E8E8FD"),
        Color(hex: "E8E8FD"), Color(hex: "E8E8FD"), Color(hex: "E8E8FD")
    ]),
    LifestyleRow(label: "Exercise", colors: [
        Color(hex: "F2C0C4"), Color(hex: "F2C0C4"),Color(hex: "F2C0C4"),
        Color(hex: "F2C0C4"), Color(hex: "E8E8FD"), Color(hex: "E8E8FD"),
        Color(hex: "E8E8FD"), Color(hex: "E8E8FD"), Color(hex: "E8E8FD")
    ]),
]
 
// MARK: - Color Extension
 
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
