//
//  YazykButton.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 08.05.2022.
//

import UIKit

class YazykButton: UIButton {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    // MARK: - Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.titleLabel?.adjustsFontForContentSizeCategory = true
        self.layer.cornerRadius = 4.0
        
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    // MARK: - Selectors
    @objc private func touchDown(sender: UIButton) {
        self.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
    }
    
    @objc private func touchUp(sender: UIButton) {
        self.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.25)
    }
    
    // MARK: - Private methods
    private func setupButton() {
        self.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.25)
    }
}
