# aiMessage :love_letter:

simple lil ai chatbot in SwiftUI

## features
⟢ real-time chat, iMessage lookalike

⟢ live AI responses powered by OpenAI

⟢ auto-scroll to latest message

## tech
⟢ SwiftUI

⟢ Swift concurrency (async / await)

⟢ Node.js + Express

⟢ JSON (Codable encoding / decoding)

⟢ OpenAI API

## architecture
⟢ SwiftUI frontend:

* ChatViewModel handles state & async flow
* ChatService handles networking & JSON encoding/decoding
    
⟢ Node.js backend:

* /chat endpoint processes incoming messages
* input validated, forwarded to OpenAI
* returns text response to the client
