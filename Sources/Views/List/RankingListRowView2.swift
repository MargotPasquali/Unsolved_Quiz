//
//  RankingListRowView2.swift
//  Unsolved
//
//  Created by Margot Pasquali on 09/05/2025.
//

import SwiftUI

struct RankingListRowView2: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.lightGray)
                .frame(maxWidth: .infinity, maxHeight: 50)
            HStack {
                Text("Joueur1")
                    .font(Font.custom("Dongle-Regular", size: 32))
                    .foregroundStyle(Color.violet)
                    .padding(.leading, 20)

                Spacer()
                
                Text("Score")
                    .font(Font.custom("Dongle-Regular", size: 32))
                    .foregroundStyle(Color.violet)
                    .padding(.trailing, 20)
            }
        }
    }
}

#Preview {
    RankingListRowView2()
}
