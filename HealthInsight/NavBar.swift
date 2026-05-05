//
//  NavBar.swift
//  HealthInsight
//
//  Created by kuldeep Singh on 05/05/26.
//

import SwiftUI

struct NavBar: View {
    var body: some View {
        HStack {
            // Logo grid
            LazyVGrid(columns: [GridItem(.fixed(8)), GridItem(.fixed(8))], spacing: 3) {
                ForEach([Color(hex: "8E8EF0"), Color(hex: "C5C5F5"),
                         Color(hex: "C5C5F5"), Color(hex: "8E8EF0")], id: \.self) { c in
                    RoundedRectangle(cornerRadius: 2.5)
                        .fill(c)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(width: 19, height: 19)
 
            Spacer()
 
            Text("Insights")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color(hex: "1C1C1E"))
 
            Spacer()
 
            // Balance space
            Color.clear.frame(width: 19, height: 19)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

#Preview {
    NavBar()
}
