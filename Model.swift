//
//  Model.swift
//  Bucket List (iOS Client-Side)
//
//  Created by R on 21/05/1443 AH.
//  Copyright © 1443 R. All rights reserved.
//
//

import Foundation

class TaskModel {
    //Get Api
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "http://localhost:7070/bukit/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    //Add to Api
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let urlToReq = URL(string: "http://localhost:7070/bukit/") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "POST"
//                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                // Create some bodyData and attach it to the HTTPBody
                let bodyData = "objectiv=\(objective)"
                request.httpBody = bodyData.data(using: .utf8)
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
    //Delete Api
    static func DeleteTaskWithObjective(id:Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
             // Create the url to request
            if let urlToReq = URL(string: "http://localhost:7070/bukit/\(id)") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "DELETE"
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
    
        static func UPdateTaskWithObjective(objective: String, id:Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
         // Create the url to request
                if let urlToReq = URL(string: "http://localhost:7070/bukit/\(id)") {
                    // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                    var request = URLRequest(url: urlToReq)
                    // Set the method to POST
                    request.httpMethod = "PUT"
                    // Create some bodyData and attach it to the HTTPBody
                    let bodyData = "objectiv:\(objective)"
                    request.httpBody = bodyData.data(using: .utf8)
                   //  Create the session
                    let session = URLSession.shared
                    let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                    task.resume()
                }
        }
    
    

}


