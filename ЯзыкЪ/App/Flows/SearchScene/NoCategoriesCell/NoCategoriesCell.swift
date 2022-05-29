//
//  NoCategoriesCell.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 29.05.2022.
//

import UIKit

class NoCategoriesCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Configuration
    func configure(text: String?) {
        titleLabel.text = text
    }
}
