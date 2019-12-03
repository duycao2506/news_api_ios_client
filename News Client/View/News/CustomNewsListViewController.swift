//
//  CustomNewsListViewController.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

class CustomNewsListViewController: NewsListViewController {
    var viewModel : CustomNewsListViewModelProtocol!
    @IBOutlet weak var btnPickQuery : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func setupBinding() {
        super.setupBinding()
        self.btnPickQuery.addTarget(self, action: #selector(pickQuery), for: .touchUpInside)
        self.viewModel.newsQuery.bindAndFireEvent { [weak self](query) in
            guard let self = self else {return}
            self.btnPickQuery.setTitle(query.rawValue.capitalizingFirstLetter(), for: .normal)
            self.refresh(sender: self.btnPickQuery as Any)
        }
    }
    
    @objc func pickQuery (){
        let sheet = UIAlertController.init(title: "Pick a category", message: "News based on your sake", preferredStyle: .actionSheet)
        for i in Query.allCases {
            let action = UIAlertAction.init(title: i.rawValue.capitalizingFirstLetter(), style: .default) { [weak self](action) in
                self?.handleQueryAction(action: action)
            }
            sheet.addAction(action)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        sheet.addAction(cancelAction)
        present(sheet, animated: true, completion: nil)
    }
    
    func handleQueryAction(action : UIAlertAction) {
        guard let query = Query.init(rawValue: action.title?.lowercased() ?? "") else {return}
        self.viewModel.updateNewsQuery(query: query)
        
    }
    
    override func configure(withViewmodel viewModel: NewsListViewModelProtocol) {
        let vmodel = CustomNewsListViewModel.init()
        self.viewModel = vmodel
        super.configure(withViewmodel: vmodel)
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
