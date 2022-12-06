//
//  Question.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 5.12.22.
//

import Foundation

struct Question: Codable {
    var questionTitle: String?
    var answersArray: [Answer]?
    var questionId: UUID
}

typealias QuestionsArray = [Question]
