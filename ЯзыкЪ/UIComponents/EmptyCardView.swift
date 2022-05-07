//
//  EmptyCardView.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 07.05.2022.
//

import UIKit

class EmptyCardView: UIControl {
    let screenWidth = UIScreen.main.bounds.size.width
    
    // MARK: - Public properties
    var screenWidthMultiplier: CGFloat = 0.85
    
    // MARK: - Configurable properties
    var cornerRadius = 24.0
    var frontViewBackgroundColor: UIColor = .systemGray5
    
    var tapAnimationDuration = 0.15
    var tapScaleFactor = 0.975
    
    var animationOptions: AnimationOptions = [.allowUserInteraction]
    var transitionOptions: AnimationOptions = [.transitionFlipFromRight, .curveEaseInOut, .allowUserInteraction]
    
    // MARK: - Private properties
    private var wordLabel: UILabel?
    private var descriptionLabel: UILabel?
    
    // MARK: - Front and back Views
    lazy var frontView = makeCardFrontView()
    
    // MARK: - Animations
    lazy var tapDownAnimation = {
        self.transform = CGAffineTransform(scaleX: self.tapScaleFactor, y: self.tapScaleFactor)
    }
    
    lazy var tapUpAnimation = {
        self.transform = .identity
    }
    
    // MARK: - Overrides
    override var intrinsicContentSize: CGSize {
        return CGSize(width: screenWidth * screenWidthMultiplier, height: 100.0)
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupFrontViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setupFrontViewConstraints()
    }
    
    // MARK: - Selectors
    @objc func tapDown() {
        UIView.animate(withDuration: tapAnimationDuration, delay: 0, options: animationOptions, animations: tapDownAnimation)
    }
    
    @objc func tapUpCancelled() {
        UIView.animate(withDuration: tapAnimationDuration, delay: 0, options: animationOptions, animations: tapUpAnimation)
    }
    
    // MARK: - Private methods
    private func makeCardFrontView() -> UIControl {
        let frontView = UIControl()
        
        frontView.backgroundColor = self.frontViewBackgroundColor
        frontView.layer.cornerRadius = cornerRadius
        
        wordLabel = UILabel()
        wordLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        wordLabel?.text = "Пустота"
        frontView.addSubview(wordLabel!)
        
        descriptionLabel = UILabel()
        descriptionLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        descriptionLabel?.alpha = 0.5
        descriptionLabel?.text = "Нажмите здесь чтобы добавить\nвашу первую карточку..."
        frontView.addSubview(descriptionLabel!)
        
        frontView.addTarget(self, action: #selector(tapDown), for: [.touchDown])
        //frontView.addTarget(self, action: #selector(flip), for: [.touchUpInside])
        frontView.addTarget(self, action: #selector(tapUpCancelled), for: [.touchUpInside, .touchDragExit, .touchCancel, .touchUpOutside])
        
        return frontView
    }
    
    private func setupView() {
        addSubview(frontView)
        tieConstraintsToSuperView(frontView)
    }
    
    private func tieConstraintsToSuperView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupFrontViewConstraints() {
        wordLabel?.translatesAutoresizingMaskIntoConstraints = false
        wordLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        wordLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel?.centerYAnchor.constraint(equalTo: self.wordLabel?.centerYAnchor ?? self.centerYAnchor, constant: 25).isActive = true
    }
}
