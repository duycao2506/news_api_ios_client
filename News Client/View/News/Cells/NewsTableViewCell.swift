//
//  NewsTableViewCell.swift
//  News Client
//
//  Created by Duy Cao on 12/1/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit
import SDWebImage

protocol ListCellProtocol : class {
    func configure(withViewmodel viewmodel: ListItemViewModelProtocol)
}

class ListTableViewCell : UITableViewCell,ListCellProtocol {
    func configure(withViewmodel viewmodel: ListItemViewModelProtocol) {
        
    }
    
    
}

class NewsTableViewCell: ListTableViewCell {
    static let identifier : String = "NewsTableViewCell"
    
    @IBOutlet weak var imgFeature : UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configure(withViewmodel viewmodel: ListItemViewModelProtocol) {
        guard let viewmodel  = viewmodel as? NewsListItemViewModelProtocol else {return}
        self.lblDate.text = viewmodel.date
        self.lblAuthor.text = viewmodel.author
        self.imgFeature.sd_setImage(with: URL.init(string: viewmodel.imageUrl), placeholderImage: UIImage.init(named: "placeholderimg"), options: [.continueInBackground, .retryFailed], completed: nil)
        self.lblNewsTitle.text = viewmodel.title
        self.lblDescription.text = viewmodel.newsDescription
    }
    
}
