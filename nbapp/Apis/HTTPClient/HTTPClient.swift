//
//  HTTPClient.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

final class HTTPClient {

    // MARK: - Private Properties

    private let httpEngine: HTTPEngine

    // MARK: - Init

    init(httpEngine: HTTPEngine = HTTPEngine(session: URLSession(configuration: .default))) {
        self.httpEngine = httpEngine
    }
    
    // MARK: - Public Methods

    func request<T: Decodable>(url: URL,
                               parameters: [(String, Any)]? = nil,
                               httpHeaders: [(String, String)]? = nil,
                               method: HTTPMethod = .get,
                               callback: @escaping (Result<T, RequestError>) -> Void) {
        let url = setQueryParameters(url: url, with: parameters)
        let request = buildRequest(method, from: url, with: httpHeaders)
        
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
    
    // MARK: - Private Methods

    private func setQueryParameters(url: URL, with parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let parameters = parameters,
              !parameters.isEmpty else {
                  return url       
              }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let url = urlComponents.url else { return url }
        return url
    }
    
    private func buildRequest(_ method: HTTPMethod = .get, from url: URL, with httpHeaders: [(String, String)]?) -> URLRequest {
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
