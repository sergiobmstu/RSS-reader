//
//  NewsTableViewCell.swift
//  RSS-reader
//
//  Created by Sergey on 21.02.2018.
//  Copyright © 2018 Sergey Kochetov. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var newsPictureImageView: UIImageView!
    @IBOutlet private weak var newsTitleLablel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    
    var model: News? {
        didSet {
            guard let model = model else { return }
            if let url = model.imageURL {
                newsPictureImageView.sd_setImage(with: url, placeholderImage: UIImage(named : "defaultPic"), options: .highPriority, completed: nil)
            } else {
                newsPictureImageView.image = #imageLiteral(resourceName: "defaultPic")
            }
            newsTitleLablel.adjustsFontSizeToFitWidth = true;
            newsTitleLablel.text = model.title
            descriptionTextView.text = model.description
            dateLabel.text = convertDate(date: model.date)
            sourceLabel.text = model.source
            descriptionTextView.textContainerInset = .zero
            descriptionTextView.contentInset = UIEdgeInsetsMake(0, -5, 0, 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.newsPictureImageView.layer.cornerRadius = 12
    }
    
    private func convertDate(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm d MMM, yyyy"
        let str = dateFormatter.string(from: date)
        return str
    }

}
