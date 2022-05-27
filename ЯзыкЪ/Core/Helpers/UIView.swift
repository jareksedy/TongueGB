//
//  UIView.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 15.05.2022.
//

import UIKit
import AVFoundation

extension UIView {
    public func tieConstraintsToSuperView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    public func speak(_ textToSpeak: String) {
        let utterance = AVSpeechUtterance(string: textToSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func presentAddCardScenePopover(delegate: AddCardSceneDelegate, viewController: UIViewController) -> Bool {
        if let addCardSceneViewController = viewController.storyboard?.instantiateViewController(withIdentifier: "AddCardScene") as? AddCardSceneViewController {
            
            addCardSceneViewController.delegate = delegate
            let navigationController = UINavigationController(rootViewController: addCardSceneViewController)
            
            navigationController.navigationBar.prefersLargeTitles = false
            navigationController.modalPresentationStyle = .pageSheet
            
            if #available(iOS 15.0, *) {
                if let sheet = navigationController.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.preferredCornerRadius = 24.0
                }
            }
            
            viewController.present(navigationController, animated: true)
            
            return false
        }
        
        return true
    }
}
