//
//  ContentView.swift
//  aiMessage
//
//  Created by Christin Lacey on 4/7/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ChatViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("aiMessage")
                .font(.largeTitle)
                .padding(.top)
                .padding(.bottom, 8)
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            MessageBubbleView(message: message)
                                .id(message.id)
                        }
                        if viewModel.isTyping {
                            HStack {
                                TypingIndicatorView()
                                Spacer()
                            }
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) {
                    if let last = viewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }
            HStack {
                TextField("Enter a message", text: $viewModel.textInput)
                    .textFieldStyle(.roundedBorder)
                Button("Send") {
                    Task {
                        await viewModel.sendMessage()
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(viewModel.trimmedInput.isEmpty ? Color.blue.opacity(0.5) : Color.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 16))
                .disabled(viewModel.trimmedInput.isEmpty)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
