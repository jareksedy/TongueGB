//
//  RequestFactory.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 21.05.2022.
//

import Foundation
import Alamofire


class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .userInitiated)
    
    func makeDictionaryRequestFactory() -> DictionaryRequestFactory {
        let errorParser = makeErrorParser()
        return DictionaryRequestMaker(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}

