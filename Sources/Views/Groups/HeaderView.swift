//
//  HeaderView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 08/05/2025.
//

import SwiftUI

struct HeaderView: View {
    let username: String
    let score: Int

    var body: some View {
            HStack {
                Image("eye")
                    .resizable()
                    .frame(width: 25, height: 25)

                Text(username)
                    .font(.custom("BeVietnamPro-Bold", size: 14))
                    .foregroundStyle(Color.lightBeige)

                Spacer()

                        Text("Score: \(score)")
                            .font(.custom("BeVietnamPro-Bold", size: 14))
                            .foregroundStyle(Color.lightBeige)
                    }
            }
        }

#Preview {
    HeaderView(username: "Test", score: 5)
}
