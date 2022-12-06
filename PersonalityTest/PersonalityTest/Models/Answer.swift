//
//  Answer.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 5.12.22.
//

import Foundation

struct Answer: Codable {
    var answerTitle: String?
    var introvertPoints: Int?
    var extrovertPoits: Int?
}

struct UniqueAnswer {
    var answer: Answer
    var id: UUID
}
