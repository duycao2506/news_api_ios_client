//
//  NewsListViewController.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView : UITableView!
    private var viewModel : NewsListViewModelProtocol! = NewsListViewModel.init()
    weak var pullControl : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: configure view model
        self.configure()
        
        //MARK: configure ui
        self.configureTableView()
        self.setupPullRequest()
        
        assert(viewModel != nil)
        
        //MARK: Binding
        self.setupBinding()
        
        //MARK: Fetch initial data
        self.viewModel.reload()
        self.pullControl.beginRefreshing()
        
    }
    
    func setupBinding(){
        self.viewModel.error.bind { [weak self] (err) in
            guard let self = self , let err = err else {return}
            self.showAlert(err.localizedDescription)
        }
        
        self.viewModel.loading.bind {[weak self] (shouldLoad) in
            guard let self = self else {return}
            if shouldLoad { self.pullControl.beginRefreshing() }
            else { self.pullControl.endRefreshing() }
        }
        
        self.viewModel.itemList.bindAndFireEvent { [weak self] (list) in
            guard let self = self else {return}
            self.tableView.reloadData()
        }
    }
    
    func setupPullRequest(){
        let pullControl = UIRefreshControl.init()
        pullControl.tintColor = .gray
        pullControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView.insertSubview(pullControl, at: 0)
        self.pullControl = pullControl
    }
    
    func configureTableView(){
        self.tableView.register(UINib.init(nibName: NewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 400.0
    }
    
    
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let model = self.viewModel.itemAt(index: indexPath.row) as? NewsListItemViewModelProtocol else {return 400}
//        let heighttitle = model.title.height(withConstrainedWidth: self.view.frame.width, font: .systemFont(ofSize: 17))
//        let heightdescription = model.newsDescription.height(withConstrainedWidth: self.view.frame.width, font: .systemFont(ofSize: 13))
//        return 400.0 + heighttitle + heightdescription
//    }
    
    @objc func refresh(sender : Any){
        self.viewModel.reload()
    }
    
    func configure(withViewmodel viewModel : NewsListViewModelProtocol = NewsListViewModel.init()) {
        self.viewModel = viewModel
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.itemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell else {
            return .init()
        }
        newsCell.configure(withViewmodel: self.viewModel.itemAt(index: indexPath.row))
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= self.viewModel.itemCount() - 3 {
            self.viewModel.loadMore()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = self.viewModel.itemAt(index: indexPath.row).rawValue as? News else {return}
        guard let detailVc = NewsDetailViewController.getViewController(withViewmodel: NewsDetailViewModel.init(news: news)) else {return}
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}
