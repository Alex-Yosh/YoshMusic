//
//  FontStyle.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-25.
//

import Foundation
import SwiftUI

struct DefaultText: ViewModifier {
    
    static var fontSize = 16.0
    static var color: Color = .black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Inter-Bold", size: DefaultText.fontSize))
            .frame(alignment: .leading)
            .foregroundColor(DefaultText.color)
    }
}
