//
//  GreetingsProvider.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 08.05.2022.
//

import Foundation

class GreetingGenerator {
    
    let greetings: [Greeting] = [
        
    Greeting(hello: "Hello!", transcription: "[ həˈləʊ ]", language: "по-английски"),
    Greeting(hello: "Γειά σας!", transcription: "[ ʝaˈ sas ]", language: "по-гречески"),
    Greeting(hello: "Salut!", transcription: "[ zaˈluːt ]", language: "по-немецки"),
    Greeting(hello: "Cześć!", transcription: "[ tʂɛɕʨ ]", language: "по-польски"),
    Greeting(hello: "Ciao!", transcription: "[ ˈʧao ]", language: "по-итальянски"),
    Greeting(hello: "Cәлем!", transcription: "[ sälem ]", language: "по-казахски"),
    Greeting(hello: "你好", transcription: "[ nǐ hǎo ]", language: "по-китайски"),
    Greeting(hello: "Здраво!", transcription: "[ zdravo ]", language: "по-сербски"),
    Greeting(hello: "Bonjour!", transcription: "[ bɔ̃ʒuʁ ]", language: "по-французски"),
    Greeting(hello: "Сайн уу?", transcription: "[ sain uu ]", language: "по-монгольски"),
    
    ]
    
    func randomGreeting() -> Greeting {
        return greetings.randomElement() ?? greetings[0]
    }
}
