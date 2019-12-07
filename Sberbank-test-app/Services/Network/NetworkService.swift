//
//  RequestManager.swift
//  Sberbank-test-app
//
//  Created by Геннадий Бочаров on 04/12/2019.
//  Copyright © 2019 Геннадий Бочаров. All rights reserved.
//

import Foundation

protocol NetworkServiceInterface: class {
    var supportedLanguages: [Language] { get }
    func translate(text: String, lang: String, completion: @escaping OptionalItemClosureWithError<String>)
}

final class NetworkService {
    
    // MARK: Static properties
    
    static let shared = NetworkService()
    
    // MARK: private properties
    
    private let apiKey = "trnsl.1.1.20190530T151045Z.34cc1346d4144c48.80aa1f059a23d6ba97ea66add036e921ee13442a"
    
    // MARK: init
    
    init() {}
    
    // MARK: private methods
        
    private func post(url: String, body: String = "", completion: @escaping ItemClosure<([String: Any]?, Int?, Error?)>) {
        guard let url: URL = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion((nil, nil, error))
                return
            } else {
                if let data = data, let response = response as? HTTPURLResponse  {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        guard let jsonArray = jsonResponse as? [String: Any] else {
                            completion((nil, nil, nil))
                            return
                        }
                        completion((jsonArray, response.statusCode, nil))
                    } catch {
                        print(error.localizedDescription)
                        completion((nil, nil, error))
                    }
                    
                }
            }
        }
        task.resume()
    }
}

// MARK: Extensions NetworkServiceInterface

extension NetworkService: NetworkServiceInterface {
    var supportedLanguages: [Language] {
        var languages: [Language] = []
        languages.append(Language(name: "Russian", key: "ru"))
        languages.append(Language(name: "English", key: "en"))
        languages.append(Language(name: "Spanish", key: "es"))
        return languages
    }
    
    func translate(text: String, lang: String, completion: @escaping OptionalItemClosureWithError<String>) {
        post(url: "https://translate.yandex.net/api/v1.5/tr.json/translate?lang=\(lang)&key=\(apiKey)", body: "text=\(text)") { (json, _, error) in
            if let data = json?["text"] as? [String], let translateText = data.first {
                completion(translateText, nil)
                return
            }
            completion(nil, error)
        }
    }
}
