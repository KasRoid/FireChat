//
//  CustomInputAccessoryView.swift
//  FireChat
//
//  Created by 천지운 on 2020/06/15.
//  Copyright © 2020 Kas Song. All rights reserved.
//

import UIKit

protocol CustomInputAccessoryViewDelegate: class {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)
}

class CustomInputAccessoryView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CustomInputAccessoryViewDelegate?
    
    let messageInputTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        return tv
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemPurple, for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Message"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        /*
         autoresizingMask: 슈퍼 뷰의 바운드가 변경되었을 때 자신의 크기를 어떻게 재조정하는지를 결정짓는 정수형 비트 마스크
         즉, .flexibleHeight를 하면 다른 Margin은 고정된 채로 높이만 늘어나게 된다.
         기본 값은 .none이다.
         https://ehdrjsdlzzzz.github.io/2019/02/07/Autoresizing-Masks/
         */
        
        backgroundColor = .white
        
        layer.shadowOpacity = 0.25 // 그림자의 불투명도(1이 불투명)
        layer.shadowRadius = 10 // 그림자의 크기
        layer.shadowOffset = .init(width: 0, height: -8) // 해당 View와 그림자와의 거리, 그림자의 시작위치(width -> x, height -> y)
        layer.shadowColor = UIColor.lightGray.cgColor // 그림자의 색
        
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 8)
        sendButton.setDimensions(height: 50, width: 50)
        
        addSubview(messageInputTextView)
        messageInputTextView.anchor(top: topAnchor,
                                    left: leftAnchor,
                                    bottom: safeAreaLayoutGuide.bottomAnchor,
                                    right: sendButton.leftAnchor,
                                    paddingTop: 12, paddingLeft: 4, paddingBottom: 4, paddingRight: 8)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(left: messageInputTextView.leftAnchor, paddingLeft: 4)
        placeholderLabel.centerY(inView: messageInputTextView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    
    // MARK: - Selectors
    
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
    }
    
    @objc func handleSendMessage() {
        guard let message = messageInputTextView.text else { return }
        delegate?.inputView(self, wantsToSend: message)
    }
    
}


