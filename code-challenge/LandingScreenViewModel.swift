//
//  LandingScreenViewModel.swift
//  code-challenge
//
//  Created by Dilip on 3/25/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation
enum NetworkCallError: Error {
    case jsonDecodeFailure
    case serviceFailure
}
class LandingScreenViewModel {
func getFeed(completion: @escaping(Result<ResponseModel, Error>?)-> Void) {
    guard let url = URL(string: ConstantIdentifiers.appleRSSFeedUrl.rawValue) else { return }
    URLSession.shared.dataTask(with: url) { data,response,error in
        if error != nil  {
            completion(.failure(NetworkCallError.serviceFailure))
        }
        if let responseData = data {
            do {
                let resp = try JSONDecoder().decode(ResponseModel.self, from: responseData)
                completion(.success(resp))
                
            } catch {
                completion(.failure(NetworkCallError.jsonDecodeFailure))
            }
        }
    }.resume()
    }
    
}
