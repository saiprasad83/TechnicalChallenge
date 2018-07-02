//
//  NetworkManager.swift
//  technicalChallenge
//
//  Created by Sai prasad Soma on 7/2/18.
//  Copyright © 2018 Sai prasad Soma. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    func getProfiles(completion: @escaping ((_ tracks: [Results]?, _ success: Bool, _ msg:String?) -> Void)){

        if let networkStatus = (reachabilityManager?.isReachable), networkStatus == false {
            completion(nil, false, "No internet")
        }
        let randomInt = 10//Int(arc4random_uniform(UInt32(49)))
        let url = URL(string: "https://randomuser.me/api/?results=\(randomInt)")
        let task = URLSession.shared.dataTask(with: url!) { (data, resp, error) in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(Profile.self, from: data!)
                completion(responseModel.results, true, "Success")
            } catch let error as NSError {
                completion(nil, false, error.localizedDescription)
            }
        }
        task.resume()
        
    }
}
