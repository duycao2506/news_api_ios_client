//
//  ProfileViewController.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    
    
    private var viewModel : ProfileViewModelProtocol = ProfileViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureWith()
        self.setupButtonActions()
        self.setupBinding()
        self.viewModel.loadUser()
        // Do any additional setup after loading the view.
    }
    
    
    
    func setupButtonActions(){
        self.mainButton.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)
        self.secondaryButton.addTarget(self, action: #selector(secondaryButtonAction), for: .touchUpInside)
    }
    
    func configureWith(viewmodel : ProfileViewModelProtocol = ProfileViewModel.init()){
        self.viewModel = viewmodel
    }
    
    func setupBinding(){
        self.txtUsername.addTarget(self, action: #selector(onChangeUserName), for: .editingChanged)
        self.txtPassword.addTarget(self, action: #selector(onChangePassword), for: .editingChanged)
        self.viewModel.isLogoutSuccessful.bind { [weak self] (loggedout) in
            self?.logOut()
        }
        self.viewModel.error.bind { [weak self] (err) in
            self?.showAlert(err?.localizedDescription ?? "")
        }
        self.viewModel.isSuccessful.bind { [weak self](saveSucc) in
            self?.showAlert("Save Successfully")
        }
        self.viewModel.username.bindAndFireEvent { [weak self] (username) in
            guard let self = self else {return}
            self.txtUsername.text = username
        }
        self.viewModel.password.bindAndFireEvent { [weak self] (password) in
            guard let self = self else {return}
            self.txtPassword.text = password
        }
    }
    
    func logOut(){
        guard let window =  UIApplication.shared.connectedScenes
               .filter({$0.activationState == .foregroundActive})
               .map({$0 as? UIWindowScene})
               .compactMap({$0})
               .first?.windows
               .filter({$0.isKeyWindow}).first else {return}
        guard let loginViewController = UIViewController.getViewControllerFromStoryBoard(type: UserSignViewController.self, storyBoard: .LOGIN) else {return}
        let nav = UINavigationController.init(rootViewController: loginViewController)
        window.rootViewController = nav
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }

    @objc func mainButtonAction(){
        self.viewModel.saveProfile()
    }
    
    @objc func onChangeUserName(){
        self.viewModel.username.value = self.txtUsername.text ?? ""
    }
    
    @objc func onChangePassword(){
        self.viewModel.password.value = self.txtPassword.text ?? ""
    }
    
    @objc func secondaryButtonAction(){
        self.viewModel.signOut()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
