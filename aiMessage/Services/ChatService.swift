//
//  ChatService.swift
//  aiMessage
//
//  Created by Christin Lacey on 4/9/26.
//
import Foundation

struct ChatService {
    enum ChatServiceError: Error {
        case invalidURL
        case invalidResponse
        case serverError(Int)
    }
    
    func sendMessage(_ message: String) async throws -> String {
        guard let url = URL(string: "http://localhost:3000/chat") else {
            throw ChatServiceError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ChatRequest(message: message)
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ChatServiceError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ChatServiceError.serverError(httpResponse.statusCode)
        }
        
        let decodedResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
        return decodedResponse.reply
    }
}
