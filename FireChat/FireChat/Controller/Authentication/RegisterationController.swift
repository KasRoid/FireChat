//
//  RegisterationController.swift
//  FireChat
//
//  Created by 천지운 on 2020/06/09.
//  Copyright © 2020 Kas Song. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    // MARK: - Properties
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"),
                                               textField: emailTextField)
        return containerView
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"),
                                               textField: fullnameTextField)
        return containerView
    }()
    
    private lazy var usernameContainerView: UIView = {
        let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"),
                                               textField: usernameTextField)
        return containerView
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"),
                                               textField: passwordTextField)
        return containerView
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    private let usernameTextField = CustomTextField(placeholder: "Username")
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                                                        .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSMutableAttributedString(string: "Log In", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                                                         .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                  passwordContainerView,
                                                  fullnameContainerView,
                                                  usernameContainerView,
                                                  signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 32,
                     paddingLeft: 32,
                     paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }

}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 200 / 2
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        
        dismiss(animated: true, completion: nil)
    }
}
