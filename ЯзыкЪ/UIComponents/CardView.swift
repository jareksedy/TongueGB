//
//  CardView.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 03.05.2022.
//

import UIKit
import AVFoundation

class CardView: UIControl {
    let screenWidth = UIScreen.main.bounds.size.width
    
    // MARK: - Public properties
    var screenWidthMultiplier: CGFloat = 0.85
    
    var word: String? {
        get { return wordLabel?.text }
        set { wordLabel?.text = newValue?.capitalizeFirstLetter() }
    }
    
    var translation: String? {
        get { return translationLabel?.text }
        set { translationLabel?.text = newValue?.capitalizeFirstLetter() }
    }
    
    var transcription: String? {
        get { return descriptionLabel?.text }
        set { if let newValue = newValue { descriptionLabel?.text = "[ \(newValue) ]" } }
    }
    
    var category: String? {
        get { return categoryLabel?.text }
        set { categoryLabel?.text = newValue; categoryLabelBack?.text = newValue }
    }
    
    var isFront = true
    
    // MARK: - Configurable properties
    var cornerRadius = 24.0
    var backViewBackgroundColor: UIColor = .systemGray5
    
    var tapAnimationDuration = 0.15
    var tapScaleFactor = 0.975
    var flipTransitionDuration = 0.225
    
    var animationOptions: AnimationOptions = [.allowUserInteraction]
    var transitionOptions: AnimationOptions = [.transitionFlipFromRight, .curveEaseInOut, .allowUserInteraction]
    
    // MARK: - Private properties
    private var speakButton: UIButton?
    private var wordLabel: UILabel?
    private var descriptionLabel: UILabel?
    private var categoryLabel: UILabel?
    private var categoryLabelBack: UILabel?
    private var translationLabel: UILabel?
    
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
        return CGSize(width: screenWidth * screenWidthMultiplier, height: 100.0)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }

        frontView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .randomDark : .randomLight
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
        
        setupView()
        setupFrontViewConstraints()
        setupBackViewConstraints()
    }
    
    // MARK: - Selectors
    @objc func speakButtonTapped() {
        guard let wordToSpeak = word else { return }
        
        speakButton?.setImage(UIImage(systemName: "speaker.wave.3")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        let utterance = AVSpeechUtterance(string: wordToSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.speakButton?.setImage(UIImage(systemName: "speaker.wave.1")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    @objc func tapDown() {
        UIView.animate(withDuration: tapAnimationDuration, delay: 0, options: animationOptions, animations: tapDownAnimation)
    }
    
    @objc func flip() {
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
    
    @objc func tapUpCancelled() {
        UIView.animate(withDuration: tapAnimationDuration, delay: 0, options: animationOptions, animations: tapUpAnimation)
    }
    
    // MARK: - Private methods
    private func makeCardFrontView() -> UIControl {
        let frontView = UIControl()
        
        frontView.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .randomDark : .randomLight
        frontView.layer.cornerRadius = cornerRadius
        
        wordLabel = UILabel()
        wordLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        frontView.addSubview(wordLabel!)
        
        descriptionLabel = UILabel()
        descriptionLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        frontView.addSubview(descriptionLabel!)
        
        categoryLabel = UILabel()
        categoryLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        frontView.addSubview(categoryLabel!)
        
        speakButton = UIButton()
        speakButton?.setImage(UIImage(systemName: "speaker.wave.1")?.withRenderingMode(.alwaysTemplate), for: .normal)
        speakButton?.tintColor = .label
        speakButton?.addTarget(self, action: #selector(speakButtonTapped), for: .touchUpInside)
        speakButton?.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        speakButton?.adjustsImageWhenHighlighted = false
        frontView.addSubview(speakButton!)
        
        frontView.addTarget(self, action: #selector(tapDown), for: [.touchDown])
        frontView.addTarget(self, action: #selector(flip), for: [.touchUpInside])
        frontView.addTarget(self, action: #selector(tapUpCancelled), for: [.touchDragExit, .touchCancel, .touchUpOutside])
        
        return frontView
    }
    
    private func makeCardBackView() -> UIControl {
        let backView = UIControl()
        
        backView.backgroundColor = backViewBackgroundColor
        backView.layer.cornerRadius = cornerRadius
        
        translationLabel = UILabel()
        translationLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        backView.addSubview(translationLabel!)
        
        categoryLabelBack = UILabel()
        categoryLabelBack?.font = UIFont.preferredFont(forTextStyle: .caption2)
        backView.addSubview(categoryLabelBack!)
        
        backView.addTarget(self, action: #selector(tapDown), for: [.touchDown])
        backView.addTarget(self, action: #selector(flip), for: [.touchUpInside])
        backView.addTarget(self, action: #selector(tapUpCancelled), for: [.touchDragExit, .touchCancel, .touchUpOutside])
        
        backView.alpha = 0
        
        return backView
    }
    
    private func setupView() {
        addSubview(frontView)
        addSubview(backView)
        
        tieConstraintsToSuperView(frontView)
        tieConstraintsToSuperView(backView)
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
        wordLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 40).isActive = true
        
        categoryLabel?.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -45).isActive = true
        
        speakButton?.translatesAutoresizingMaskIntoConstraints = false
        speakButton?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        speakButton?.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
    }
    
    private func setupBackViewConstraints() {
        translationLabel?.translatesAutoresizingMaskIntoConstraints = false
        translationLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        translationLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        categoryLabelBack?.translatesAutoresizingMaskIntoConstraints = false
        categoryLabelBack?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabelBack?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -45).isActive = true
    }
}
