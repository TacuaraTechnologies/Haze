//
//  TTUser.swift
//  Haze
//
//  Created by Eduardo Rivarola on 8/24/15.
//  Copyright (c) 2015 Tacuara Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class TTUser {
    var email = ""
    var username = ""
    var first_name = ""
    var last_name = ""
    let api = TTAPI.sharedInstance
    
    static let sharedInstance = TTUser()
    
    func jsonToModel(json: JSON) -> TTUser{
        
        return self
    }
    
    func login(email:String,password:String,passwordConfirmation:String,completion: (error: String, success: Bool)->Void) {
        let parameters = ["email":"\(email)","password":"\(password)","password_confirmation":"\(passwordConfirmation)"]
        api.jsonRequest(.LOGIN, parameters: parameters) { (json, error) -> Void in
            if error == nil {
                println(json)
            }else{
                println(error)
            }
        }
        
    }
}