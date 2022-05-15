//
//  CategoryTableViewCell.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 15.05.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var cardsInCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration
    func configure(_ category: CardsCategory?) {
        categoryTitleLabel.text = category?.categoryKey
        cardsInCategoryLabel.text = "\(Int.random(in: 2...18))"
    }
}
