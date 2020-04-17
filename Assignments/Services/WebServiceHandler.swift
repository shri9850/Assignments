//
//  WebServiceHandler.swift
//  Assignments
//
//  Created by Shri's Mac Mini on 16/04/20.
//  Copyright © 2020 Redbytes. All rights reserved.
//

import Foundation
class WebServiceHandler {
    func postApi(url:String, httpMethod: String = "POST", values: [String: Any], onSuccess: @escaping(Data?) -> Void, onFailure: @escaping(Error) -> Void){
        
        var _url = url
        var param = values
        if httpMethod.lowercased() == "get" {
            var lastParam = "?"
            for (key, value) in values {
                lastParam += key
                lastParam += "="
                lastParam += "\(value)&"
            }
            if lastParam.count > 2 {
                _url += lastParam
                param.removeAll()
            }
        }
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: _url)! as URL)
        
        if httpMethod.lowercased() != "get" {
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: param, options: [])
        }
        
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        
        debugPrint("Request:- ", url, "With Parameters:- ", param, request.allHTTPHeaderFields ?? "", "URLRequest:- ", request)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                DispatchQueue.main.async {
                    onFailure(error!)
                }
            } else {
                do {
                    if let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        print(result,"result")
                        onSuccess(data)
                    }
                    if let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Any] {
                        print(result,"result")
                        onSuccess(data)
                    }
                } catch {
                    debugPrint("Error serializing JSON: \(error.localizedDescription)")
                    onSuccess(data)
                }
            }
        })
        task.resume()
    }
}
