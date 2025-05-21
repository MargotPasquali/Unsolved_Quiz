//
//  NewGameSheetView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 08/05/2025.
//

import SwiftUI

struct NewGameSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: StartNewGameViewModel
    @State private var errorMessage: String?
    @State private var isNavigatingToQuiz = false
    
    
    var body: some View {
        NavigationStack {
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
                            
                            if let error = viewModel.errorMessage {
                                errorMessage = error
                            } else {
                                isNavigatingToQuiz = true
                                dismiss()
                            }
                        }
                    }) {
                        Text("start_game_button")
                            .frame(width: 240, height: 50)
                            .padding()
                            .background(viewModel.username.isEmpty ? Color.gray : Color.lightGray)
                            .font(Font.custom("Dongle-Bold", size: 40))
                            .foregroundStyle(Color.navyBlue)
                            .cornerRadius(19)
                    }
                    .disabled(viewModel.username.isEmpty)
                    .padding(.horizontal, 20)
                    .navigationDestination(isPresented: $isNavigatingToQuiz) {
                        MainQuizView(viewModel: MainQuizViewModel(username: viewModel.username))
                    }
                }
                .interactiveDismissDisabled()
            }
        }
    }
}

#Preview {
    NewGameSheetView(viewModel: StartNewGameViewModel())
}
