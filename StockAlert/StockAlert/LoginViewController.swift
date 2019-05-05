//
//  LoginViewController.swift
//  StockAlert
//
//  Created by Annamalai Annamalai on 5/4/19.
//  Copyright © 2019 Annamalai Annamalai. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var userNameTextField: UITextField!
    var passwordTextField: UITextField!
    
    var userNameTextView: UITextView!
    var passwordTextView: UITextView!
    
    var loginButton: UIButton!
    
    weak var delegate: UserLoginDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        userNameTextView = UITextView()
        userNameTextView.translatesAutoresizingMaskIntoConstraints = false
        userNameTextView.text = "Email Address: "
        userNameTextView.textAlignment = .center
        userNameTextView.isEditable = false
        userNameTextView.isScrollEnabled = false
        userNameTextView.font = UIFont.systemFont(ofSize: 16)
        userNameTextView.textColor = .black
        view.addSubview(userNameTextView)
        
        userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.text = ""
        userNameTextField.textAlignment = .left
        userNameTextField.font = UIFont.systemFont(ofSize: 16)
        userNameTextField.textColor = .black
        userNameTextField.backgroundColor = .lightGray
        view.addSubview(userNameTextField)
        
        passwordTextView = UITextView()
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextView.text = "Password: "
        passwordTextView.textAlignment = .center
        passwordTextView.isEditable = false
        passwordTextView.isScrollEnabled = false
        passwordTextView.font = UIFont.systemFont(ofSize: 16)
        passwordTextView.textColor = .black
        view.addSubview(passwordTextView)
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.text = ""
        passwordTextField.textAlignment = .left
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.textColor = .black
        passwordTextField.backgroundColor = .lightGray
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        loginButton.addTarget(self, action: #selector(Login), for: .touchUpInside)
        view.addSubview(loginButton)
        
        setupConstraints()
    }
    
    @objc func Login () {
        NetworkManager.login(email: userNameTextField.text ?? "", password: passwordTextField.text ?? "") { login in
            print("User with token \(login.success) logged in!")
            if  login.success {
                print(login.user[0].id)
                //self.dismiss(animated: true)
                //self.delegate?.updateUser(user: login.user[0])
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = UINavigationController(rootViewController: TabViewController(user: login.user[0]))
            } else {
                let alert = UIAlertController(title: "Alert", message: "Unable to Login", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        //NetworkManager.Search()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userNameTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            userNameTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            userNameTextView.heightAnchor.constraint(equalToConstant: 30),
            userNameTextView.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            userNameTextField.heightAnchor.constraint(equalToConstant: 30),
            userNameTextField.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            passwordTextView.topAnchor.constraint(equalTo: userNameTextView.bottomAnchor, constant: 10),
            passwordTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            passwordTextView.heightAnchor.constraint(equalToConstant: 30),
            passwordTextView.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            loginButton.heightAnchor.constraint(equalToConstant: 25),
            loginButton.widthAnchor.constraint(equalToConstant: 250)
            ])
    }

}
