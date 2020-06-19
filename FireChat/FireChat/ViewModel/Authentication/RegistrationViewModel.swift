//
//  RegistrationViewModel.swift
//  FireChat
//
//  Created by 천지운 on 2020/06/09.
//  Copyright © 2020 Kas Song. All rights reserved.
//
import Foundation

struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsVaild: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false &&
            fullname?.isEmpty == false &&
            username?.isEmpty == false
    }
}
