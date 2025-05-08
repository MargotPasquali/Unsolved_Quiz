//
//  MainQuizView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 08/05/2025.
//

import SwiftUI

struct MainQuizView: View {
    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()
            VStack {
                HeaderView()
                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color.violet, lineWidth: 4)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                    Text("Question 1")
                        .font(Font.custom("Dongle-Regular", size: 40))
                        .foregroundStyle(Color.violet)
                        .padding()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color.violet, lineWidth: 4)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 225)
                            .foregroundColor(.violet)
                        
                        Text("Quel est le nom du navire fantôme retrouvé intact en 1872, mais sans aucun membre d’équipage à bord ?")
                            .font(Font.custom("Dongle-Regular", size: 26))
                            .foregroundStyle(Color.navyBlue)
                            .lineSpacing(-15)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 19)
                                .foregroundStyle(Color.navyBlue)
                                .frame(maxWidth: 300, maxHeight: 50)
                            Text("Réponse 1")
                                .font(Font.custom("Dongle-Regular", size: 26))
                                .foregroundStyle(Color.lightGray)
                                .padding()
                            
                        }
                    }
                }
                
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    MainQuizView()
}
