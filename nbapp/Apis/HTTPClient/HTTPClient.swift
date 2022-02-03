//
//  HTTPClient.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

final class HTTPClient {

    // MARK: - Properties

    private let httpEngine: HTTPEngine

    // MARK: - Init

    init(httpEngine: HTTPEngine = HTTPEngine(session: URLSession(configuration: .default))) {
        self.httpEngine = httpEngine
    }

    func request<T: Decodable>(url: URL,
                               parameters: [(String, Any)]? = nil,
                               httpHeaders: [(String, String)]? = nil,
                               method: HTTPMethod = .get,
                               callback: @escaping (Result<T, RequestError>) -> Void) {
        let url = encode(baseUrl: url, with: parameters)
        let request = buildRequest(from: url, with: httpHeaders, with: method)
        
        httpEngine.request(with: request, parameters: parameters) { data, response, error in
            guard error == nil else {
                callback(.failure(.error))
                return
            }
            guard let data = data else {
                callback(.failure(.noData))
                return
            }
            guard let response = response, response.statusCode == 200 else {
                callback(.failure(.incorrectResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(T.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
    }

    private func encode(baseUrl: URL, with parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false),
              let parameters = parameters,
              !parameters.isEmpty else {
                  return baseUrl       
              }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
    
    private func buildRequest(from url: URL, with httpHeaders: [(String, String)]?, with method: HTTPMethod = .get) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.asString
        if let httpHeaders = httpHeaders {
            for (key, value) in httpHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}
