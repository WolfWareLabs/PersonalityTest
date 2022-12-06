//
//  Strings.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 5.12.22.
//

import Foundation


struct Strings {
    static var landingTitleLabel: String                    { localized("landing-title-label") }
    static var landingDescriptionLabel: String              { localized("landing-description-label") }
    static var buttonStart: String                          { localized("button-start") }
    
    static var buttonPrevious: String                       { localized("button-previous") }
    static var buttonNextQuestion: String                   { localized("button-next-question") }
    static var buttonRetakeTest: String                     { localized("button-retake-test") }
    static var buttonFinishTest: String                     { localized("button-finish-test") }
    
    static var resultsScore: String                         { localized("results-score") }
    static var resultsIntrovertPoints: String               { localized("results-introvert-points") }
    static var resultsExtrovertPoints: String               { localized("results-extrovert-points") }
    
    static var resultsTitle: String                         { localized("results-title") }
    static var resultsDescription: String                   { localized("results-description") }
    static var resultsDescriptionIntrovert: String          { localized("results-description-introvert") }
    static var resultsDescriptionExtrovert: String          { localized("results-description-extrovert") }
    static var resultsDescriptionMiddle: String             { localized("results-description-middle") }
    
    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
