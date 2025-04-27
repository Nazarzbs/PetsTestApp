//
//  TextStyle.swift
//  PetsTestApp
//
//  Created by Nazar on 26/4/25.
//


import SwiftUI

struct TextStyle {
    let font: Font
    let color: Color
    
    init(font: Font, color: Color = .primary) {
        self.font = font
        self.color = color
    }
}

extension TextStyle {
    static func heading1(color: Color = .primary) -> TextStyle {
        TextStyle(
            font: .custom("Konkhmer Sleokchher", size: 32).weight(.regular),
            color: color
        )
    }
    
    static func body1(color: Color = .primary, weight: Font.Weight = .regular) -> TextStyle {
        TextStyle(
            font: .custom("Konkhmer Sleokchher", size: 16).weight(weight),
            color: color
        )
    }
    
    static func body2(color: Color = .primary, weight: Font.Weight = .regular) -> TextStyle {
        TextStyle(
            font: .custom("Konkhmer Sleokchher", size: 12).weight(weight),
            color: color
        )
    }
}

struct TextStyleModifier: ViewModifier {
    let style: TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .foregroundColor(style.color)
    }
}

extension View {
    func textStyle(_ style: TextStyle) -> some View {
        self.modifier(TextStyleModifier(style: style))
    }
}
