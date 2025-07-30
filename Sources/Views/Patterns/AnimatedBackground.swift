//
//  Animation.swift
//  Unsolved
//
//  Created by Margot Pasquali on 07/05/2025.
//

import SwiftUI

struct AnimatedBackground: View {
    // MARK: - Constants
    let pattern1 = "long_pattern"
    let imageWidth: CGFloat = 900
    let bandHeight: CGFloat = 65
    let repeatCount = 3

    // MARK: - Properties
    @State private var offset: CGFloat = 0

    // MARK: - View
    var body: some View {
        ZStack {
            Color.darkBrown
                .ignoresSafeArea()
            VStack {

                scrollingBand(imageName: pattern1, offset: offset)
                    .offset(x: 0, y: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

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
            offset = -imageWidth * CGFloat(repeatCount)
        }
    }
}

#Preview {
    AnimatedBackground()
}
