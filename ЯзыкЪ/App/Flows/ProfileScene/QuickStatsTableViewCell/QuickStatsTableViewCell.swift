//
//  QuickStatsTableViewCell.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 18.05.2022.
//

import UIKit

class QuickStatsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuration
    func configure(caption: String, value: String) {
        captionLabel.text = caption
        valueLabel.text = value
    }
}
