// ChatViewModel.swift
// StacGPT
//
// Created by Bitania yonas on 4/6/25.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var inputMessage: String = ""
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let openAIService = OpenAIService.shared
    private let knowledgeBase = KnowledgeBase.shared
    
    private let initialMessages = [
        "Hi there! I'm StacGPT, your educational assistant for St. Thomas Aquinas College. How can I help you today?",
        "I can provide information about campus resources, academic policies, programs, and more.",
        "Feel free to ask me anything about STAC!"
    ]
    
    init() {
        addBotMessage(initialMessages[0])
    }
    
    func sendMessage() {
        guard !inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        let userMessage = ChatMessage(content: inputMessage, isFromUser: true)
        messages.append(userMessage)
        
        // Save the input message and clear it
        let sentMessage = inputMessage
        inputMessage = ""
        
        // Show loading state
        isLoading = true
        
        // Generate the response using OpenAI with RAG
        generateResponse(to: sentMessage)
    }
    
    private func generateResponse(to message: String) {
        // 1. Retrieve relevant documents from knowledge base
        let relevantDocs = knowledgeBase.retrieveRelevantDocuments(
            for: message,
            limit: RAGServiceConfig.maxRetrievedDocuments
        )
        let context = knowledgeBase.formatContextForPrompt(documents: relevantDocs)
        
        // 2. Prepare the conversation history for OpenAI
        var apiMessages: [Message] = [
            Message(role: "system", content: RAGServiceConfig.systemPrompt)
        ]
        
        // Add the user query with retrieved context
        let userQueryWithContext = """
        The user asked: "\(message)"
        
        \(context)
        
        Based on the above information, provide a helpful response to the user's question.
        """
        
        apiMessages.append(Message(role: "user", content: userQueryWithContext))
        
        // 3. Call OpenAI API
        openAIService.generateResponse(messages: apiMessages)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    print("Error: \(error)")
                    
                    // Handle different types of errors
                    if let apiError = error as? APIError {
                        switch apiError {
                        case .networkError:
                            self?.addBotMessage(RAGServiceConfig.networkErrorMessage)
                        case .authenticationError:
                            self?.addBotMessage("API key authentication failed. Please check your API key configuration.")
                        case .rateLimitExceeded:
                            self?.addBotMessage("Too many requests. Please try again later.")
                        default:
                            self?.addBotMessage(RAGServiceConfig.apiErrorMessage)
                        }
                    } else {
                        self?.addBotMessage(RAGServiceConfig.generalErrorMessage)
                    }
                    
                    // Fall back to simple response as backup
                    self?.generateSimpleResponse(to: message)
                }
            }, receiveValue: { [weak self] response in
                self?.addBotMessage(response)
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    // Fallback to simple rule-based responses if API fails
    private func generateSimpleResponse(to message: String) {
        let lowercasedMessage = message.lowercased()
        
        if lowercasedMessage.contains("hello") || lowercasedMessage.contains("hi") {
            addBotMessage("Hello! How can I assist you with your educational needs today?")
        } else if lowercasedMessage.contains("bye") || lowercasedMessage.contains("goodbye") {
            addBotMessage("Goodbye! Feel free to come back if you have more questions.")
        } else if lowercasedMessage.contains("course") || lowercasedMessage.contains("class") {
            addBotMessage("I can help you find information about courses. Could you specify which course or department you're interested in?")
        } else if lowercasedMessage.contains("deadline") || lowercasedMessage.contains("due date") {
            addBotMessage("Important upcoming deadlines:\n• Course registration: August 15\n• Tuition payment: September 1\n• Add/drop period ends: September 10")
        } else if lowercasedMessage.contains("library") {
            addBotMessage("The university library is open Monday-Friday from 7am to 11pm, and weekends from 9am to 9pm. You can access online resources 24/7 through the library portal.")
        } else if lowercasedMessage.contains("thank") {
            addBotMessage("You're welcome! Is there anything else I can help you with?")
        } else {
            // Default response for unknown queries
            addBotMessage("That's an interesting question about \"" + message + "\". I don't have specific information about that. You might find more details on the college website or by contacting student services.")
        }
    }
    
    private func addBotMessage(_ content: String) {
        let botMessage = ChatMessage(content: content, isFromUser: false)
        messages.append(botMessage)
    }
} 
