//
//  HTTPEngine.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

typealias HTTPResponse = (Data?, HTTPURLResponse?, Error?) -> Void

final class HTTPEngine {

    // MARK: - Properties

    private let session: URLSession
    private var task: URLSessionDataTask?

    // MARK: - Init

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - Public Methods

    func request(with request: URLRequest,
                 parameters: [(String, Any)]? = nil,
                 requestBuilder: ((URL) -> URLRequest)? = nil,
                 callback: @escaping HTTPResponse) {

        task?.cancel()
        task = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                callback(data, nil, error)
                return
            }
            callback(data, response, error)
        }
        task?.resume()
    }
}
