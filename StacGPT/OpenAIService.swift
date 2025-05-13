//
//  OpenAIService.swift
//  StacGPT
//
//  Created by Bitania yonas on 4/6/25.
//

import Foundation
import Combine

class OpenAIService {
    // Using config from RAGServiceConfig
    private let apiKey = RAGServiceConfig.apiKey
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    
    // Singleton instance
    static let shared = OpenAIService()
    
    private init() {}
    
    func generateResponse(messages: [Message]) -> AnyPublisher<String, Error> {
        // Create URL
        guard let url = URL(string: baseURL) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create payload with configuration
        let requestBody = ChatCompletionRequest(
            model: RAGServiceConfig.model,
            messages: messages,
            temperature: RAGServiceConfig.temperature
        )
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            return Fail(error: APIError.encodingError).eraseToAnyPublisher()
        }
        
        // Send request
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                
                // Handle different error codes
                if httpResponse.statusCode == 401 {
                    throw APIError.authenticationError
                } else if httpResponse.statusCode == 429 {
                    throw APIError.rateLimitExceeded
                } else if httpResponse.statusCode != 200 {
                    throw APIError.httpError(statusCode: httpResponse.statusCode)
                }
                
                return data
            }
            .decode(type: ChatCompletionResponse.self, decoder: JSONDecoder())
            .map { response -> String in
                let content = response.choices.first?.message.content ?? "Sorry, I couldn't generate a response."
                return RAGServiceConfig.responsePrefix + content + RAGServiceConfig.responseSuffix
            }
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - API Models
struct ChatCompletionRequest: Codable {
    let model: String
    let messages: [Message]
    let temperature: Double
}

struct Message: Codable {
    let role: String
    let content: String
}

struct ChatCompletionResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    
    struct Choice: Codable {
        let index: Int
        let message: Message
        let finishReason: String
        
        enum CodingKeys: String, CodingKey {
            case index
            case message
            case finishReason = "finish_reason"
        }
    }
}

// MARK: - Errors
enum APIError: Error {
    case invalidURL
    case encodingError
    case invalidResponse
    case authenticationError
    case rateLimitExceeded
    case httpError(statusCode: Int)
    case networkError
    case unknown(Error)
} 
