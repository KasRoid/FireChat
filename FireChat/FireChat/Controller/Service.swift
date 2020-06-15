//
//  Service.swift
//  FireChat
//
//  Created by 천지운 on 2020/06/10.
//  Copyright © 2020 Kas Song. All rights reserved.
//

import Firebase

struct Service {
    
    /*
     @escaping
     해당 함수의 인자로 클로저가 전달되지만, 함수가 반환된 후 실행 되는 것을 의미한다.
     함수에서 선언된 로컬 변수가 로컬 변수의 영역을 뛰어넘어 함수 밖에서도 유효하기 때문이다.
     https://hcn1519.github.io/articles/2017-09/swift_escaping_closure
     아마... 함수 외부에 저장하기를 통해 값을 전달한것으로 보임
     */
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ document in
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                users.append(user)
                completion(users)
            })
        }
    }
    
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": user.uid,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
                COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
        }
    }
    
}
