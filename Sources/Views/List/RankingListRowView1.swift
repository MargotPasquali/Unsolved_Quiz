//
//  RankingListRowView1.swift
//  Unsolved
//
//  Created by Margot Pasquali on 09/05/2025.
//

import SwiftUI

struct RankingListRowView1: View {
    let playerName: String
    let score: Int

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(maxWidth: .infinity, maxHeight: 50)
            HStack {
                Text(playerName)
                    .font(Font.custom("BeVietnamPro-SemiBold", size: 32))
                    .foregroundStyle(Color.gray)
                    .padding(.leading, 20)

                Spacer()

                Text(String(score))
                    .font(Font.custom("BeVietnamPro-SemiBold", size: 32))
                    .foregroundStyle(Color.gray)
                    .padding(.trailing, 20)
            }
        }
    }
}

#Preview {
    RankingListRowView1(playerName: "test", score: 3)
}
