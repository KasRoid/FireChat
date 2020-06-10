//
//  Service.swift
//  FireChat
//
//  Created by 천지운 on 2020/06/10.
//  Copyright © 2020 Kas Song. All rights reserved.
//

import Firebase

struct Service {
    
    static func fetchUsers() {
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ document in
                print(document.data())
            })
        }
    }
    
}
