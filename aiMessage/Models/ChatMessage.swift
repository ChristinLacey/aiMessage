//
//  ChatMessage.swift
//  aiMessage
//
//  Created by Christin Lacey on 4/7/26.
//
import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
    
}
