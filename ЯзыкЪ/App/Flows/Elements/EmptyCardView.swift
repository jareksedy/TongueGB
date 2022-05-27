//
//  EmptyCardView.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 07.05.2022.
//

import UIKit

class EmptyCardView: UIControl {
    weak var viewDelegate: MainSceneViewDelegate?
    
    // MARK: - Public properties
    var screenWidthMultiplier: CGFloat = 0.80
    
    // MARK: - Configurable properties
    var cornerRadius = 24.0
    var frontViewBackgroundColor: UIColor = .clear
    
    var tapAnimationDuration = 0.15
    var tapScaleFactor = 0.975
    
    var animationOptions: AnimationOptions = [.allowUserInteraction]
    var transitionOptions: AnimationOptions = [.transitionFlipFromRight, .curveEaseInOut, .allowUserInteraction]
    
    // MARK: - Private properties
    private var headingLabel: UILabel!
    private var subHeadingLabel: UILabel!
    private var addIcon: UIImageView!
    
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
        return CGSize(width: CGFloat.screenWidth * screenWidthMultiplier, height: 100.0)
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupFrontViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private methods
    private func makeCardFrontView() -> UIControl {
        let frontView = UIControl()
        
        frontView.backgroundColor = self.frontViewBackgroundColor
        frontView.layer.cornerRadius = cornerRadius
        
        let addIconConfig = UIImage.SymbolConfiguration(pointSize: 36, weight: .light, scale: .large)
        
        addIcon = UIImageView()
        addIcon.image = UIImage(systemName: "plus.rectangle.portrait")?
            .withRenderingMode(.alwaysTemplate)
            .withConfiguration(addIconConfig)
        
        frontView.addSubview(addIcon)
        
        headingLabel = UILabel()
        headingLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        headingLabel.text = "Сейчас здесь совершенно пусто"
        headingLabel.numberOfLines = 0
        headingLabel.textAlignment = .center
        frontView.addSubview(headingLabel)
        
        subHeadingLabel = UILabel()
        subHeadingLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        subHeadingLabel.alpha = 0.5
        subHeadingLabel.text = "Нажмите чтобы добавить вашу первую карточку"
        subHeadingLabel.numberOfLines = 0
        subHeadingLabel.textAlignment = .center
        frontView.addSubview(subHeadingLabel)
        
        frontView.layer.borderColor = UIColor.systemGray5.cgColor
        frontView.layer.borderWidth = 2.0
        
        frontView.addTarget(self, action: #selector(tapDown), for: [.touchDown])
        frontView.addTarget(self, action: #selector(tapUp), for: [.touchUpInside])
        frontView.addTarget(self, action: #selector(tapUpCancelled), for: [.touchDragExit, .touchCancel, .touchUpOutside])
        
        frontView.clipsToBounds = true
        
        return frontView
    }
    
    private func setupView() {
        let gap = ((CGFloat.screenWidth - (CGFloat.screenWidth * CGFloat.cardScreenWidthMultiplier)) / 2) - (CGFloat.cardStackSpacing / 2)
        let effectiveWidth = CGFloat.screenWidth - (gap * 2 + CGFloat.cardStackSpacing)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: effectiveWidth)
        ])
        
        addSubview(frontView)
        tieConstraintsToSuperView(frontView)
    }
    
    private func setupFrontViewConstraints() {
        addIcon.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        subHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addIcon.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            
            headingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -100),
            
            subHeadingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subHeadingLabel.centerYAnchor.constraint(equalTo: self.headingLabel.bottomAnchor, constant: 40),
            subHeadingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -100)
        ])
    }
}

@objc extension EmptyCardView {
    
    // MARK: - Selectors
    @objc func tapUp() {
        UIView.animate(withDuration: tapAnimationDuration, delay: 0, options: animationOptions, animations: tapUpAnimation)
        // tap action here
    }
    
    @objc func tapDown() {
        UIView.animate(withDuration: tapAnimationDuration, delay: 0, options: animationOptions, animations: tapDownAnimation)
    }
    
    @objc func tapUpCancelled() {
        UIView.animate(withDuration: tapAnimationDuration, delay: 0, options: animationOptions, animations: tapUpAnimation)
    }
}
