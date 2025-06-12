//
//  RankingListRowView2.swift
//  Unsolved
//
//  Created by Margot Pasquali on 09/05/2025.
//

import SwiftUI

struct RankingListRowView2: View {
    let playerName: String
    let score: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.lightGray)
                .frame(maxWidth: .infinity, maxHeight: 50)
            HStack {
                Text(playerName)
                    .font(Font.custom("Dongle-Regular", size: 32))
                    .foregroundStyle(Color.violet)
                    .padding(.leading, 20)

                Spacer()
                
                Text(String(score))
                    .font(Font.custom("Dongle-Regular", size: 32))
                    .foregroundStyle(Color.violet)
                    .padding(.trailing, 20)
            }
        }
    }
}

#Preview {
    RankingListRowView2(playerName: "Test", score: 4)
}
