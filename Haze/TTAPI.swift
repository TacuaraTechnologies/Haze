//
//  JAPI.swift
//  JSON File Explorer
//
//  Created by Eduardo Rivarola on 8/20/15.
//  Copyright (c) 2015 Tacuara Technologies. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class TTAPI{
    
    // MARK: Properties
    
    static let sharedInstance = TTAPI()
    
    var mgr: Manager!
    var cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage()
    let apiURL = "http://haze/api"
   
    enum Command: String {
        case LOGIN = "auth/login"
        case USER_BANDS = "/user/bands"
        case USER_FRIENDS = "/user/friends"
        case USER_PICTURES = "/user/pictures"
        
    }
    
    
    // initialization
    
 
    
    init (){
        mgr = cfgrManager()
    }

    var currentRequest: Request?
    func jsonRequest(command: Command, parameters:[String:AnyObject]?, completion: ((json: JSON?, error: String?) -> Void)) {
        let str = apiURL + command.rawValue
       currentRequest =  mgr.request(.POST,str, parameters: parameters, encoding: .JSON)
        
        .responseSwiftyJSONRenamed { request,response,json,error in
            if response?.statusCode >= 200 && response?.statusCode < 300 {
                //response OK
                completion(json: json, error: error?.localizedDescription)
            }else if response?.statusCode == 401 { //Unauthorized
                //Bad Request 401
                completion(json: json, error: error?.localizedDescription)
            }else if response?.statusCode == 400 { //Bad formed json
                completion(json: json, error: error?.localizedDescription)
            }else{
                //Not found 404:
                //Internal server error 500:
                //Unauthorized  401:
                //Forbidden  403:
                completion(json: nil, error: error?.localizedDescription)
            }

     
        }
        
    }

    private func cfgrManager() -> Manager {
        let cfg = NSURLSessionConfiguration.defaultSessionConfiguration()
        cfg.HTTPCookieStorage = cookies
        return Manager(configuration: cfg)
    }
    
}