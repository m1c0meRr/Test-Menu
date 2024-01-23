//
//  NetworkManager.swift
//  KinoBOX
//
//  Created by Sergey Savinkov on 16.10.2023.
//

import Foundation
import UIKit

final class ServiceManager {
    
    static let shared = ServiceManager()
    private init() {}
    
    public func requestImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        task.resume()
    }
}
