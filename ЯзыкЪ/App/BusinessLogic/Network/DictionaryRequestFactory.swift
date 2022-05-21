//
//  DictionaryRequestFactory.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 21.05.2022.
//

import Foundation
import Alamofire

protocol DictionaryRequestFactory {
    func dictionaryRequest(request: DictionaryRequest, completionHandler: @escaping (AFDataResponse<DictionaryResponse>) -> Void)
}

class DictionaryRequestMaker: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    let baseUrl = URL(string: "https://dictionary.yandex.net/api/v1/dicservice.json/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension DictionaryRequestMaker: DictionaryRequestFactory {
    func dictionaryRequest(request: DictionaryRequest, completionHandler: @escaping (AFDataResponse<DictionaryResponse>) -> Void) {
        let requestModel = dictionaryRequestModel(baseUrl: baseUrl, request: request)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension DictionaryRequestMaker {
    struct dictionaryRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "lookup"
        let request: DictionaryRequest
        var parameters: Parameters? {
            [
                "key": request.key,
                "lang": request.lang,
                "text": request.text
            ]
        }
    }
}
