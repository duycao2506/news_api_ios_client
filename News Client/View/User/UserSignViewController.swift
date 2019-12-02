//
//  UserSignViewController.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

class UserSignViewController: ProfileViewController {

    var viewModel : LoginViewModelProtocol = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func configureWith(viewmodel: ProfileViewModelProtocol ) {
        self.viewModel = LoginViewModel.init()
        guard let profileViewModel = self.viewModel as? ProfileViewModelProtocol else {
            assertionFailure()
            return
        }
        super.configureWith(viewmodel: profileViewModel)
    }
    
    override func setupBinding() {
        super.setupBinding()
        self.viewModel.isRegisteredSuccessful.bind { [weak self] (registered) in
            self?.proceedToMain()
        }
        
        self.viewModel.isSignInSuccessful.bind { [weak self] (success) in
            self?.proceedToMain()
        }
        
        
    }
    
    func proceedToMain(){
        guard let window =  UIApplication.shared.connectedScenes
               .filter({$0.activationState == .foregroundActive})
               .map({$0 as? UIWindowScene})
               .compactMap({$0})
               .first?.windows
               .filter({$0.isKeyWindow}).first else {return}
        guard let tabBarVc = self.getViewControllerFromStoryBoard(type: MyTabBarViewController.self, storyBoard: .MAIN) else {return}
        window.rootViewController = tabBarVc
        self.dismiss(animated: true, completion: nil)
    }
    
    override func mainButtonAction() {
        self.viewModel.signIn()
    }
    
    override func secondaryButtonAction() {
        self.viewModel.register()
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
