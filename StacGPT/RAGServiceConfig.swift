//
//  RAGServiceConfig.swift
//  StacGPT
//
//  Created by Bitania yonas on 4/6/25.
//

import Foundation

// Configuration for RAG and OpenAI service
struct RAGServiceConfig {
    // API configuration
    static let apiKey = "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" // Replace with your actual API key
    static let model = "gpt-4o" // You can use gpt-3.5-turbo for lower cost
    
    // System prompt
    static let systemPrompt = """
    You are StacGPT, an AI assistant for St. Thomas Aquinas College students and faculty.
    Your role is to provide helpful, accurate information about the college, its programs, resources, and services.
    Be friendly, professional, and concise in your responses.
    If you don't know the answer to a question, acknowledge that and suggest where the user might find the information.
    Use the context provided to answer questions, but you can also use your general knowledge to provide helpful responses.
    Always maintain a helpful and positive tone.
    """
    
    // RAG configuration
    static let maxRetrievedDocuments = 3
    
    // Temperature setting for response generation (0.0 to 1.0)
    // Lower values make responses more deterministic, higher values more creative
    static let temperature = 0.7
    
    // Response formatting
    static let responsePrefix = ""
    static let responseSuffix = ""
    
    // Error messages
    static let networkErrorMessage = "I'm sorry, I encountered a network error. Please check your connection and try again."
    static let apiErrorMessage = "I'm sorry, I encountered an error processing your request. Please try again later."
    static let generalErrorMessage = "I apologize for the inconvenience. Something went wrong with my system. Please try again."
} 
