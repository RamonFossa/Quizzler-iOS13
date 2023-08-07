//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Ramon Fossa on 06/08/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    let answer: Bool
    
    init(_ text: String, _ answer: Bool) {
        self.text = text
        self.answer = answer
    }
}
