//
//  FavoriteButton.swift
//  newsApp
//
//  Created by MacBook on 1/28/21.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    var body: some View {
        Button(action: {isSet.toggle()}, label: {
            Image(systemName: isSet ? "star.fill" : "star")
                .foregroundColor(isSet ? Color.yellow : Color.gray)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
