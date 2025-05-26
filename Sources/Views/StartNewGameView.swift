//
//  NewGameSheetView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 08/05/2025.
//

import SwiftUI

struct StartNewGameView: View {
    @ObservedObject var viewModel: StartNewGameViewModel
    @State private var errorMessage: String?
    @State private var isNavigatingToQuiz = false
    
    var body: some View {
        ZStack {
            Color.navyBlue
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 20) {
                Text("before_begging_a_new_game")
                    .font(Font.custom("Dongle-Bold", size: 48))
                    .foregroundStyle(Color.accent)
                    .padding(.top, 30)
                
                Text("choose_name_text")
                    .font(Font.custom("Dongle-Regular", size: 40))
                    .foregroundStyle(Color.lightGray)
                
                TextField("", text: $viewModel.username, prompt: Text("Entrez votre pseudo").foregroundStyle(Color.gray))
                    .font(Font.custom("Dongle-Regular", size: 40))
                    .foregroundStyle(Color.accent)
                    .textFieldStyle(.plain)
                    .autocapitalization(.none)
                    .padding(.horizontal, 20)
                    .background(Color.navyBlue)
                    .multilineTextAlignment(.center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accent, lineWidth: 1)
                    )
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(Font.custom("Dongle-Regular", size: 24))
                        .foregroundStyle(Color.red)
                }
                
                Spacer()
                
                Button(action: {
                    Task {
                        await viewModel.setUsername(username: viewModel.username)
                        
                        if viewModel.username.isEmpty == false && viewModel.errorMessage == nil {
                            isNavigatingToQuiz = true
                        } else if let error = viewModel.errorMessage {
                            errorMessage = error
                        }
                    }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(Color.navyBlue)
                    } else {
                        Text("start_game_button")
                            .frame(width: 240, height: 50)
                            .padding()
                            .background(viewModel.username.isEmpty ? Color.gray : Color.lightGray)
                            .font(Font.custom("Dongle-Bold", size: 40))
                            .foregroundStyle(Color.navyBlue)
                            .cornerRadius(19)
                    }
                }
                .disabled(viewModel.username.isEmpty || viewModel.isLoading)
                .padding(.horizontal, 20)
                
                NavigationLink(destination: MainQuizView(viewModel: MainQuizViewModel(username: viewModel.username)), isActive: $isNavigatingToQuiz) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    StartNewGameView(viewModel: StartNewGameViewModel())
}
