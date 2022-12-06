//
//  PersonalityTestUnitTests.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 5.12.22.
//

import XCTest

final class PersonalityTestUnitTests: XCTestCase {

    let viewModel = QuestionsViewModel()

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testNumberOfBackupQuestions() {
        XCTAssertEqual(QuestionsViewModel().backupQuestions.count, 3)
    }
    
    func testApiCall() {
        viewModel.getQuestions { isSuccessfull in
            XCTAssertGreaterThan(self.viewModel.questions.count, 0)
        }
    }
    
    func testPersonalityPoints() {
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[0].answersArray?[0] ?? Answer(), id: self.viewModel.backupQuestions[0].questionId))
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[1].answersArray?[0] ?? Answer(), id: self.viewModel.backupQuestions[1].questionId))
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[2].answersArray?[0] ?? Answer(), id: self.viewModel.backupQuestions[2].questionId))
        XCTAssertEqual(viewModel.getPersonalityPoints().introvertPoints, 245)
        XCTAssertEqual(viewModel.getPersonalityPoints().extrovertPoints, 55)
    }
    
    func testPersonalityTypeIntrovert() {
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[0].answersArray?[0] ?? Answer(), id: self.viewModel.backupQuestions[0].questionId))
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[1].answersArray?[0] ?? Answer(), id: self.viewModel.backupQuestions[1].questionId))
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[2].answersArray?[0] ?? Answer(), id: self.viewModel.backupQuestions[2].questionId))
        XCTAssertEqual(viewModel.getPersonalityType(), .introvert)
    }
    
    func testPersonalityTypeExtrovert() {
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[0].answersArray?[3] ?? Answer(), id: self.viewModel.backupQuestions[0].questionId))
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[1].answersArray?[3] ?? Answer(), id: self.viewModel.backupQuestions[1].questionId))
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[2].answersArray?[3] ?? Answer(), id: self.viewModel.backupQuestions[2].questionId))
        XCTAssertEqual(viewModel.getPersonalityType(), .extrovert)
    }
    
    func testPersonalityTypeBoth() {
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[0].answersArray?[1] ?? Answer(), id: self.viewModel.backupQuestions[0].questionId))
        viewModel.selectedAnswers.append(UniqueAnswer(answer: self.viewModel.backupQuestions[2].answersArray?[0] ?? Answer(), id: self.viewModel.backupQuestions[2].questionId))
        XCTAssertEqual(viewModel.getPersonalityType(), .both)
    }
}
