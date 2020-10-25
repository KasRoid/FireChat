//
//  CustomTextField.swift
//  FireChat
//
//  Created by 천지운 on 2020/06/09.
//  Copyright © 2020 Kas Song. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        borderStyle = .none
        font = .systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
