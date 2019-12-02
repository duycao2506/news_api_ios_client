//
//  CustomNewsListViewController.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

class CustomNewsListViewController: NewsListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configure(withViewmodel viewModel: NewsListViewModelProtocol) {
        super.configure(withViewmodel: CustomNewsListViewModel.init())
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
