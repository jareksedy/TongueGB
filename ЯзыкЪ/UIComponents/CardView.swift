//
//  CardView.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 03.05.2022.
//

import UIKit
import AVFoundation

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

class CardView: UIControl {
    let screenWidth = UIScreen.main.bounds.size.width
    
    var screenWidthMultiplier: CGFloat = 0.85
    
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
    
    private var speakButton: UIButton?
    private var wordLabel: UILabel?
    private var descriptionLabel: UILabel?
    private var categoryLabel: UILabel?
    private var translationLabel: UILabel?
    private var userEmail: String?
    
    lazy var tapDownAnimation = {
        self.transform = CGAffineTransform(scaleX: 0.975, y: 0.975)
        self.layer.cornerRadius = 36.0
        self.alpha = self.cardAlphaTapped
    }
    
    lazy var tapUpAnimation = {
        self.transform = .identity
        self.layer.cornerRadius = 24.0
        self.alpha = 1.0
    }
    
    let animationDuration = 0.10
    let animationSpringDamping = 0.50
    let animationSpringVelocity = 0.25
    let animationOptions: AnimationOptions = [.allowUserInteraction]
    let cardBackgroundAlpha: CGFloat = 0.85
    let cardAlphaTapped: CGFloat = 0.90
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: screenWidth * screenWidthMultiplier, height: 0)
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
    
    @objc func speakButtonTapped() {
        guard let wordToSpeak = card?.word else { return }
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
        UIView.animate(withDuration: animationDuration, delay: 0, animations: tapDownAnimation)
    }
    
    @objc func tapUp() {
        UIView.transition(with: self, duration: 0.25, options: .transitionFlipFromRight, animations: tapUpAnimation)
    }
    
    func setupView() {
        self.backgroundColor = UIColor.random.withAlphaComponent(cardBackgroundAlpha)
        self.layer.cornerRadius = 24.0
        
        wordLabel = UILabel()
        wordLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        addSubview(wordLabel!)
        
        descriptionLabel = UILabel()
        descriptionLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        addSubview(descriptionLabel!)
        
        categoryLabel = UILabel()
        categoryLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        addSubview(categoryLabel!)
        
        speakButton = UIButton()
        speakButton?.setImage(UIImage(systemName: "speaker.wave.1")?.withRenderingMode(.alwaysTemplate), for: .normal)
        speakButton?.tintColor = .label
        speakButton?.addTarget(self, action: #selector(speakButtonTapped), for: .touchUpInside)
        speakButton?.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        addSubview(speakButton!)
        
        self.addTarget(self, action: #selector(tapDown), for: [.touchDown, .touchDragEnter])
        self.addTarget(self, action: #selector(tapUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    func setupConstraints() {
        wordLabel?.translatesAutoresizingMaskIntoConstraints = false
        wordLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        wordLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 25).isActive = true
        
        categoryLabel?.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        
        speakButton?.translatesAutoresizingMaskIntoConstraints = false
        speakButton?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        speakButton?.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
    }
}
