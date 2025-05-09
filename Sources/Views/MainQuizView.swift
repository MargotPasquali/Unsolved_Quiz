//
//  MainQuizView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 08/05/2025.
//

import SwiftUI
import Kingfisher

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
                        .padding(-1)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack {

                        if let url = URL(string: "https://cdn.stocksnap.io/img-thumbs/960w/ship-wreck_B2MQOD11GA.jpg") {
                            KFImage(url)
                                .placeholder {
                                    RoundedRectangle(cornerRadius: 19)
                                        .frame(maxWidth: .infinity, maxHeight: 225)
                                        .foregroundColor(.violet)
                                }
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 225)
                                .clipShape(RoundedRectangle(cornerRadius: 19, ))
                        } else {
                            RoundedRectangle(cornerRadius: 19)
                                .frame(maxWidth: .infinity, maxHeight: 225)
                                .foregroundColor(.violet)
                        }

                        
                        
                        Text("Quel est le nom du navire fantôme retrouvé intact en 1872, mais sans aucun membre d’équipage à bord ?")
                            .font(Font.custom("Dongle-Regular", size: 26))
                            .foregroundStyle(Color.navyBlue)
                            .lineSpacing(0)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 19)
                                .foregroundStyle(Color.navyBlue)
                                .frame(maxWidth: 300, maxHeight: 50)
                            Text("Réponse 1")
                                .font(Font.custom("Dongle-Regular", size: 26))
                                .foregroundStyle(Color.lightGray)
                                .padding()
                            
                        }
                        Spacer()
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
