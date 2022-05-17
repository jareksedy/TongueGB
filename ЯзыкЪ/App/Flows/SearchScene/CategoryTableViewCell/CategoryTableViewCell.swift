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
        
        let acessoryImageConfiguration = UIImage.SymbolConfiguration(pointSize: 8, weight: .regular)
        let accessoryImage = UIImage(systemName: "arrow.right")?
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(acessoryImageConfiguration)
            .withTintColor(.secondaryLabel)
        
        self.accessoryView = UIImageView(image: accessoryImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration
    func configure(category: CardsCategory?, cardsInCategory: Int) {
        categoryTitleLabel.text = category?.categoryKey
        cardsInCategoryLabel.text = "\(cardsInCategory)"
    }
}
