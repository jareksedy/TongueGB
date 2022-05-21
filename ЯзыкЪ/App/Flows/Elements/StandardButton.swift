//
//  SignInButton.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 08.05.2022.
//

import UIKit

class StandardButton: UIButton {
    // MARK: - Properties
    let buttonBackgroundColor = UIColor.link
    
    // MARK: - Initializers
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    // MARK: - Private methods
    private func setupButton() {
        self.backgroundColor = buttonBackgroundColor.withAlphaComponent(0.85)
        self.setTitleColor(.white.withAlphaComponent(0.85), for: .normal)
        
        self.titleEdgeInsets.top = -1.0
        self.titleEdgeInsets.left = -1.0
        
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        self.layer.cornerRadius = 6.0
        
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
}

@objc extension StandardButton {
    private func touchDown(sender: UIButton) {
        self.backgroundColor = buttonBackgroundColor.withAlphaComponent(0.65)
    }
    
    private func touchUp(sender: UIButton) {
        self.backgroundColor = buttonBackgroundColor.withAlphaComponent(0.85)
    }
}
