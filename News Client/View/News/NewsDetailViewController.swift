//
//  NewsDetailViewController.swift
//  News Client
//
//  Created by Duy Cao on 12/3/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    typealias NewsFullDetailViewmodelProtocol = NewsDetailViewModelProtocol & NewsListItemViewModelProtocol

    
    static func getViewController(withViewmodel viewModel : NewsFullDetailViewmodelProtocol) -> UIViewController? {
        guard let viewController = UIViewController.getViewControllerFromStoryBoard(type: NewsDetailViewController.self, storyBoard: .NEWS_DETAIL) else {
            return nil
        }
        viewController.viewModel = viewModel
        return viewController
    }
    
    @IBOutlet weak var imgFeature: UIImageView!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    var viewModel : NewsFullDetailViewmodelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(self.viewModel != nil)
        // Do any additional setup after loading the view.
        setupBinding()
    }
    
    @IBAction func toSourceAction(_ sender: Any) {
        guard let url = URL(string: self.viewModel.urlToSource) else { return }
        UIApplication.shared.open(url)
    }
    func setupBinding(){
        self.lblAuthor.text = self.viewModel.author
        self.imgFeature.sd_setImage(with: URL(string: self.viewModel.imageUrl), placeholderImage: UIImage.init(named: "placeholderimg"), options: [.continueInBackground, .progressiveLoad], context: nil)
        self.lblTitle.text = self.viewModel.title
        self.lblDate.text = self.viewModel.date
        self.lblContent.text = self.viewModel.content
        self.lblDescription.text = self.viewModel.newsDescription
        
        
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
