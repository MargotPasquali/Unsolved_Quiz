//
//  NewGameSheetView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 08/05/2025.
//

import SwiftUI

struct NewGameSheetView: View {
    @State private var textInput: String = ""
    var body: some View {
        ZStack {
            Color.navyBlue
                .ignoresSafeArea()

            VStack(alignment: .center) {
                Text("before_begging_a_new_game")
                    .font(Font.custom("Dongle-Bold", size: 48))
                    .foregroundStyle(Color.accent)
                    .padding(.vertical, 30)

                Text("choose_name_text")
                    .font(Font.custom("Dongle-Regular", size: 40))
                    .foregroundStyle(Color.lightGray)

                if textInput.isEmpty {
                    Text("None")
                        .foregroundStyle(Color.gray)
                        .font(Font.custom("Dongle-Regular", size: 40))
                }

                TextField("", text: $textInput)
                    .foregroundStyle(Color.lightGray)
                    .font(Font.custom("Dongle-Regular", size: 40))
                    .autocapitalization(.none)

                Spacer()

                NavigationLink(destination: MainQuizView()) {
                    Text("start_game_button")
                        .frame(width: 240, height: 50)
                        .padding()
                        .background(Color.lightGray)
                        .font(Font.custom("Dongle-Bold", size: 40))
                        .foregroundStyle(Color.navyBlue)
                        .cornerRadius(19)
                }
            }
        }
    }
}

#Preview {
    NewGameSheetView()
}
