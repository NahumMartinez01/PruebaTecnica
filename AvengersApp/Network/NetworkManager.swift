//
//  NetworkManager.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 23/10/25.
//

import Foundation
@MainActor
class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    enum NetworkError: Error, LocalizedError {
        case invalidURL
        case invalidResponse(statusCode: Int)
        case decodingError
        case unknown(Error)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL: return "URL inválida"
            case .invalidResponse(let code): return "Error HTTP: \(code)"
            case .decodingError: return "Error al decodificar la respuesta"
            case .unknown(let error): return error.localizedDescription
            }
        }
    }
    
    func request<T: Decodable>(path: String, queryItems: [URLQueryItem] = []) async throws -> T {
        guard var components = URLComponents(string: APIConstants.baseURL + path) else {
            throw NetworkError.invalidURL
        }
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 300
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(APIConstants.bearerToken, forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
            
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(T.self, from: data)
                return decoded
            } catch {
                throw NetworkError.decodingError
            }
            
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
