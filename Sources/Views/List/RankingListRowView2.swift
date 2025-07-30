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
                .fill(Color.gray)
                .frame(maxWidth: .infinity, maxHeight: 50)
            HStack {
                Text(playerName)
                    .font(Font.custom("BeVietnamPro-SemiBold", size: 32))
                    .foregroundStyle(Color.red)
                    .padding(.leading, 20)

                Spacer()

                Text(String(score))
                    .font(Font.custom("BeVietnamPro-SemiBold", size: 32))
                    .foregroundStyle(Color.red)
                    .padding(.trailing, 20)
            }.padding(.vertical, 0)
        }
    }
}

#Preview {
    RankingListRowView2(playerName: "Test", score: 4)
}
