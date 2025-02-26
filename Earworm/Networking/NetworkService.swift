//
//  NetworkService.swift
//  Earworm
//
//  Created by Hugo Pinheiro  on 24/01/25.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}

    func fetchRSS(from urlString: String, completion: @escaping (Result<RSSFeed, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "NetworkServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        AF.request(url).responseString { response in
            switch response.result {
            case .success(let xmlString):
                let parser = RSSParser()
                parser.parse(xmlString: xmlString) { feed in
                    if let feed = feed {
                        completion(.success(feed))
                    } else {
                        completion(.failure(NSError(domain: "RSSParserError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse RSS feed"])))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

