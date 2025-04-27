//
//  LogoView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-27.
//

import SwiftUI

struct SquareLogoView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SquareLogoView()
}
