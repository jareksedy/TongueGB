//
//  AddCardScenePresenter.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Presenter
final class AddCardScenePresenter {
    weak var viewDelegate: AddCardSceneViewDelegate?
    
    // MARK: - Services
      private let requestFactory: RequestFactory
      
      // MARK: - Initializers
      init(requestFactory: RequestFactory) {
          self.requestFactory = requestFactory
      }
    
    // MARK: - Public methods
    func fetchDictionaryRecord(for text: String) {
        guard text != "" else { return }
        
        let factory = requestFactory.makeDictionaryRequestFactory()
        let request = DictionaryRequest(key: yandexDictionaryAPIKey, lang: "en-ru", text: text)
        
        factory.dictionaryRequest(request: request) { response in
            switch response.result {
                
            case .success(let result):
                if result.def.count > 0 {
                    let translation = result.def[0].tr[0].text.capitalizeFirstLetter()
                    let transcription = result.def[0].ts
                    let category = ""
                    self.viewDelegate?.displayDictionaryRecord(translation: translation, transcription: transcription, category: category)
                } else {
                    self.viewDelegate?.displayEmptyDictionaryRecord()
                }

            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.displayEmptyDictionaryRecord()
            }
        }
    }
}
