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
    var card: Card? {
        get {
            return Card(word: wordLabel?.text ?? "",
                        translation: translationLabel?.text ?? "",
                        description: descriptionLabel?.text ?? "",
                        category: Category(categoryKey: categoryLabel?.text ?? "",
                                           categoryColor: nil, categoryImage: nil),
                        userEmail: self.userEmail ?? "")
        }
        
        set {
            wordLabel?.text = newValue?.word
            descriptionLabel?.text = newValue?.description
            translationLabel?.text = newValue?.translation
            categoryLabel?.text = newValue?.category.categoryKey
        }
    }
    
    private var wordLabel: UILabel?
    private var descriptionLabel: UILabel?
    private var categoryLabel: UILabel?
    private var translationLabel: UILabel?
    private var userEmail: String?
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 0)
    }
    
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
        self.backgroundColor = UIColor.random
        self.layer.cornerRadius = 18.0
        
        wordLabel = UILabel()
        wordLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        addSubview(wordLabel!)
    }
    
    func setupConstraints() {
        wordLabel?.translatesAutoresizingMaskIntoConstraints = false
        wordLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        wordLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
