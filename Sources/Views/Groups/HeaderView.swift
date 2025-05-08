//
//  HeaderView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 08/05/2025.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image("account")
                .resizable()
                .frame(width: 25, height: 25)

            Text("Gom4r")
                .font(.custom("Dongle-Regular", size: 26))
                .foregroundStyle(Color.violet)
            
            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: 19)
                    .fill(Color.violet)
                    .frame(width: 120, height: 30)

                HStack {
                    Image("star")
                        .resizable()
                        .frame(width: 20, height: 20)

                    Text("Score: 5")
                        .font(.custom("Dongle-Regular", size: 26))
                        .foregroundStyle(Color.accent)
                }
            }
        }
    }
}

#Preview {
    HeaderView()
}
