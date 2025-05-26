//
//  Animation.swift
//  Unsolved
//
//  Created by Margot Pasquali on 07/05/2025.
//

import SwiftUI

struct AnimatedBackground: View {
    // MARK: - Constants
    let pattern1 = "Pattern1"
    let pattern2 = "Pattern2"
    let imageWidth: CGFloat = 700
    let bandHeight: CGFloat = 80
    let repeatCount = 5

    // MARK: - Properties
    @State private var offset1: CGFloat = 0
    @State private var offset2: CGFloat = 0
    @State private var offset3: CGFloat = 0

    // MARK: - View
    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()
            VStack {
                scrollingBand(imageName: pattern1, offset: offset1)
                    .offset(x: 0, y: 159)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .rotationEffect(Angle(degrees: 133))

                scrollingBand(imageName: pattern2, offset: offset2)
                    .offset(x: 0, y: -263)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .rotationEffect(Angle(degrees: 25))

                scrollingBand(imageName: pattern1, offset: offset3)
                    .offset(x: 0, y: -68)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .rotationEffect(Angle(degrees: 130))

                    .onAppear {
                        startAnimations()
                    }
            }
        }
    }
    
    // Fonction pour créer une bande défilante
    func scrollingBand(imageName: String, offset: CGFloat) -> some View {
        HStack(spacing: 0) {
            ForEach(0..<repeatCount * 2, id: \.self) { _ in
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth, height: bandHeight)
            }
        }
        .offset(x: offset)
        .frame(height: bandHeight)

    }
    
    // Fonction pour démarrer l'animation
    func startAnimations() {
        withAnimation(Animation.linear(duration: 30).repeatForever(autoreverses: false)) {
            offset1 = -imageWidth * CGFloat(repeatCount)
        }
        withAnimation(Animation.linear(duration: 30).repeatForever(autoreverses: false)) {
            offset2 = -imageWidth * CGFloat(repeatCount)
        }
        withAnimation(Animation.linear(duration: 30).repeatForever(autoreverses: false)) {
            offset3 = -imageWidth * CGFloat(repeatCount)
        }
    }
}

#Preview {
    AnimatedBackground()
}
