//
//  CardView.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 03.05.2022.
//

import UIKit

// -- remove this later <start> --
struct Card {
     let word: String
     let translation: String
     let description: String?
     let category: Category
     let userEmail: String
 }

struct Category {
     let categoryKey: String
     let categoryColor: String?
     let categoryImage: String?
 }
// -- remove his later <end> --

class CardView: UIView {
    var wordLabel: UILabel?
    var descriptionLabel: UILabel?
    var categoryLabel: UILabel?
    var translationLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        self.backgroundColor = .systemPink
        self.layer.cornerRadius = 24.0
    }
    
    func setupConstraints() {
    }
}
