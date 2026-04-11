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
        ChatMessage(text: "you can ask me about anything, from space/time relativity to what you should make for dinner tonight.", isUser: false)
    ]
    var trimmedInput: String {
        textInput.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    private let chatService = ChatService()
    
    func sendMessage() async {
        guard !trimmedInput.isEmpty else { return }
        
        let messageToSend = trimmedInput
        let userMessage = ChatMessage(text: messageToSend, isUser: true)
        messages.append(userMessage)
        
        textInput = ""
        do {
            try await Task.sleep(for: .milliseconds(250))
            isTyping = true
            
            let reply = try await chatService.sendMessage(messageToSend)
            
            isTyping = false
            let aiResponse = ChatMessage(text: reply, isUser: false)
            messages.append(aiResponse)
        } catch {
            print("sendMessage error:", error)
            isTyping = false
            let errorMessage = ChatMessage(text: "An error occurred", isUser: false)
            messages.append(errorMessage)
            
        }
    }
}
