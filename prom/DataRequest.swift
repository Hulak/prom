//
//  DataRequest.swift
//  prom
//
//  Created by Alyona Hulak on 11/14/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import UIKit

import Apollo
import FutureKit
import PromiseKit

class DataRequest {
    let limit = 99
    let offset = 0
    let category = 35402
    var sort = "-popularity"
    
    func requestHandler() {
        let headers = ["content-type": "application/json"]
        let url = NSURL(string: "http://prom.ua/_/graph/request?limit="+"\(limit)"+"&offset="+"\(offset)"+"&category="+"\(category)"+"&sort="+sort)!
        let request = NSMutableURLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        var data: Data
        if let path = Bundle.main.path(forResource: "prom", ofType: "txt") {
            let fm = FileManager()
            let exists = fm.fileExists(atPath: path)
            if (exists) {
                let content = fm.contents(atPath: path)
                data = content!
                request.httpBody = data
            }
        }
        if CoreDataService.shared.results?.count == nil {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                if (error != nil) {
                    print(error)
                    return
                }
                do {
                    let context = CoreDataService.shared.persistentContainer.newBackgroundContext()
                    let decoder = JSONDecoder()
                    decoder.userInfo[CodingUserInfoKey.context!] = context
                    _ = try decoder.decode(PromData.self, from: data!)
                        //                CoreDataService.shared.saveWorkerContext()
                        try context.save()
                    
                } catch {
                    let response = response as? HTTPURLResponse
                    print(response)
                }
            })
            dataTask.resume()
        }
        
    }
}
