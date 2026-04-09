//
//  ChatViewModel.swift
//  aiMessage
//
//  Created by Christin Lacey on 4/9/26.
//

import Foundation
import Observation

@MainActor
@Observable
class ChatViewModel {
    var textInput: String = ""
    var isTyping: Bool = false
    var messages: [ChatMessage] = [
        ChatMessage(text: "Good morning", isUser: true),
        ChatMessage(text: "Hello, how are you? Good morning Good morning Good morning Good morning", isUser: false),
        ChatMessage(text: "I'm doing well, thanks for asking!", isUser: true)
    ]
    var trimmedInput: String {
        textInput.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func sendMessage() async {
        guard !trimmedInput.isEmpty else { return }
        
        let userMessage = ChatMessage(text: trimmedInput, isUser: true)
        messages.append(userMessage)
        
        textInput = ""
        try? await Task.sleep(for: .milliseconds(250))
        isTyping = true

        try? await Task.sleep(for: .milliseconds(750))
        isTyping = false
        let aiResponse = ChatMessage(text: "Your message was received!", isUser: false)
        messages.append(aiResponse)
        
    }
}
