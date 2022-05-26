//
//  CategoryTableViewCell.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 17.05.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet var categoryTitleLabel: UILabel!
    @IBOutlet var cardsInCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let acessoryImageConfiguration = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let accessoryImage = UIImage(systemName: "chevron.compact.right")?
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(acessoryImageConfiguration)
            .withTintColor(.separator)
        
        self.accessoryView = UIImageView(image: accessoryImage)
    }
    
    // MARK: - Configuration
    func configure(category: String?, cardsInCategory: Int) {
        categoryTitleLabel.text = category
        cardsInCategoryLabel.text = "\(cardsInCategory)"
    }
}
