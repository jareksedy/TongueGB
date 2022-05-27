//
//  CardView.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 03.05.2022.
//

import UIKit

class CardView: UIControl {
    
    // MARK: - Public properties
    var screenWidthMultiplier: CGFloat = 0.80
    
    var word: String? {
        get { return wordLabel.text }
        set { wordLabel.text = newValue?.capitalizeFirstLetter() }
    }
    
    var translation: String? {
        get { return translationLabel.text }
        set { translationLabel.text = newValue?.capitalizeFirstLetter() }
    }
    
    var transcription: String? {
        get { return descriptionLabel.text }
        set { if let newValue = newValue, newValue != "" { descriptionLabel.text = "[ \(newValue) ]" } else { descriptionLabel.text = "" } }
    }
    
    var category: String? {
        get { return categoryLabel.text }
        set { categoryLabel.text = newValue; categoryLabelBack.text = newValue }
    }
    
    var isFront = true
    var hasSelection = true
    
    // MARK: - Configurable properties
    var cornerRadius = 24.0
    var frontViewBackgroundColorLight: UIColor = .randomLight
    var frontViewBackgroundColorDark: UIColor = .randomDark
    var backViewBackgroundColorDark: UIColor = .cardBackgroundDark
    var backViewBackgroundColorLight: UIColor = .cardBackgroundLight
    
    var tapAnimationDuration = 0.15
    var tapScaleFactor = 0.975
    var flipTransitionDuration = 0.2
    
    var animationOptions: AnimationOptions = [.allowUserInteraction]
    var transitionOptions: AnimationOptions = [.transitionFlipFromRight, .curveEaseInOut, .allowUserInteraction]
    
    // MARK: - Private properties
    private var speakButton: UIButton!
    private var wordLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var categoryLabel: UILabel!
    private var categoryLabelBack: UILabel!
    private var translationLabel: UILabel!
    
    // MARK: - Front and back Views
    lazy var frontView = makeCardFrontView()
    lazy var backView = makeCardBackView()
    
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        frontView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? frontViewBackgroundColorDark : frontViewBackgroundColorLight
        backView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? backViewBackgroundColorDark : backViewBackgroundColorLight
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupFrontViewConstraints()
        setupBackViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private methods
    private func makeCardFrontView() -> UIControl {
        let frontView = UIControl()
        
        frontView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? frontViewBackgroundColorDark : frontViewBackgroundColorLight
        frontView.layer.cornerRadius = cornerRadius
        
        wordLabel = UILabel()
        wordLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        wordLabel.numberOfLines = 0
        wordLabel.textAlignment = .center
        frontView.addSubview(wordLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        descriptionLabel.alpha = 0.5
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        frontView.addSubview(descriptionLabel)
        
        categoryLabel = UILabel()
        categoryLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .center
        frontView.addSubview(categoryLabel)
        
        speakButton = UIButton()
        speakButton.setImage(UIImage(systemName: "speaker.wave.1")?.withRenderingMode(.alwaysTemplate), for: .normal)
        speakButton.tintColor = .label
        speakButton.addTarget(self, action: #selector(speakButtonTapped), for: .touchUpInside)
        speakButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        speakButton.adjustsImageWhenHighlighted = false
        frontView.addSubview(speakButton)
        
        frontView.addTarget(self, action: #selector(tapDown), for: [.touchDown])
        frontView.addTarget(self, action: #selector(flip), for: [.touchUpInside])
        frontView.addTarget(self, action: #selector(tapUpCancelled), for: [.touchDragExit, .touchCancel, .touchUpOutside])
        
        frontView.clipsToBounds = true
        
        return frontView
    }
    
    private func makeCardBackView() -> UIControl {
        let backView = UIControl()
        
        backView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? backViewBackgroundColorDark : backViewBackgroundColorLight
        backView.layer.cornerRadius = cornerRadius
        
        translationLabel = UILabel()
        translationLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        translationLabel.numberOfLines = 0
        translationLabel.textAlignment = .center
        backView.addSubview(translationLabel)
        
        categoryLabelBack = UILabel()
        categoryLabelBack.font = UIFont.preferredFont(forTextStyle: .caption2)
        categoryLabelBack.numberOfLines = 0
        categoryLabelBack.textAlignment = .center
        backView.addSubview(categoryLabelBack)
        
        backView.addTarget(self, action: #selector(tapDown), for: [.touchDown])
        backView.addTarget(self, action: #selector(flip), for: [.touchUpInside])
        backView.addTarget(self, action: #selector(tapUpCancelled), for: [.touchDragExit, .touchCancel, .touchUpOutside])
        
        backView.alpha = 0
        backView.clipsToBounds = true
        
        return backView
    }
    
    private func setupView() {
        let gap = ((CGFloat.screenWidth - (CGFloat.screenWidth * CGFloat.cardScreenWidthMultiplier)) / 2) - (CGFloat.cardStackSpacing / 2)
        let effectiveWidth = CGFloat.screenWidth - (gap * 2 + CGFloat.cardStackSpacing)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: effectiveWidth)
        ])
        
        addSubview(frontView)
        addSubview(backView)
        
        tieConstraintsToSuperView(frontView)
        tieConstraintsToSuperView(backView)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    private func setupFrontViewConstraints() {
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        speakButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wordLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wordLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            wordLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: self.wordLabel.bottomAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
            
            categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            categoryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
            
            speakButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            speakButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 40)
        ])
    }
    
    private func setupBackViewConstraints() {
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabelBack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            translationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            translationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            translationLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
            
            categoryLabelBack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            categoryLabelBack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            categoryLabelBack.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50)
        ])
    }
}

@objc extension CardView {
    
    // MARK: - Selectors
    func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            hasSelection.toggle()
        } else if sender.state == .began {
            self.alpha = hasSelection ? 0.5 : 1.0
        }
    }
    
    func speakButtonTapped() {
        guard let wordToSpeak = word else { return }
        
        speakButton.setImage(UIImage(systemName: "speaker.wave.3")!.withRenderingMode(.alwaysTemplate), for: .normal)
        speak(wordToSpeak)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.speakButton.setImage(UIImage(systemName: "speaker.wave.1")!.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    func tapDown() {
        UIView.animate(withDuration: tapAnimationDuration, delay: 0, options: animationOptions, animations: tapDownAnimation)
    }
    
    func flip() {
        let tapUpAnimationFront = {
            self.transform = .identity
            self.frontView.alpha = self.isFront ? 0 : 1
        }
        
        let tapUpAnimationBack = {
            self.transform = .identity
            self.backView.alpha = self.isFront ? 1 : 0
        }
        
        isFront ? backView.removeFromSuperview() : frontView.removeFromSuperview()
        addSubview(isFront ? backView : frontView)
        tieConstraintsToSuperView(isFront ? backView : frontView)
        setupFrontViewConstraints()
        setupBackViewConstraints()
        
        UIView.transition(with: frontView, duration: flipTransitionDuration, options: transitionOptions, animations: tapUpAnimationFront)
        UIView.transition(with: backView, duration: flipTransitionDuration, options: transitionOptions, animations: tapUpAnimationBack)
        
        isFront.toggle()
    }
    
    func tapUpCancelled() {
        UIView.animate(withDuration: tapAnimationDuration, delay: 0, options: animationOptions, animations: tapUpAnimation)
    }
}
