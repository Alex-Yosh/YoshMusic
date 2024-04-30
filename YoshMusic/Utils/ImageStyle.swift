//
//  ImageStyle.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-29.
//

import Foundation
import SwiftUI

extension Image{
    func artistImageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 64, height: 64)
            .clipShape(Circle())
    }
}
