//
//  UIViewController+Extension.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

public enum Storyboard: String {
    case MAIN = "Main"
    case LOGIN = "Login"
}

extension UIViewController {
    func getViewControllerFromStoryBoard<T: UIViewController>(type: T.Type, storyBoard: Storyboard) -> T? {
        var fullName: String = NSStringFromClass(T.self)
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        if let range = fullName.range(of:".", options:.backwards, range:nil, locale: nil){
            fullName = String(fullName[range.upperBound...])
        }
        return storyboard.instantiateViewController(withIdentifier:fullName) as? T
    }
    
    func showAlert(_ message:String) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
