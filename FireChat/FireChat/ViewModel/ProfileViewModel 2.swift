//
//  ProfileViewModel.swift
//  FireChat
//
//  Created by 천지운 on 2020/06/17.
//  Copyright © 2020 Kas Song. All rights reserved.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable { // CaseIterable ?
    case accountInfo
    case settings
    
    var description: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .settings: return "Settings"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .settings: return "gear"
        }
    }
}
