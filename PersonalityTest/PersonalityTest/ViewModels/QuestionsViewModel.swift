//
//  QuestionsViewModel.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 5.12.22.
//

import Foundation

class QuestionsViewModel {
    var backupQuestions = [
        Question(questionTitle: "It’s time for your annual appraisal with your boss. You:", answersArray: [
            Answer(answerTitle: "Go with great hesitation as these sessions are torture for you", introvertPoints: 75, extrovertPoits: 25),
            Answer(answerTitle: "Look forward to hearing what your boss thinks about you and expects from you", introvertPoints: 20, extrovertPoits: 80),
            Answer(answerTitle: "Rehearse ad nauseam the arguments and ideas that you’ve prepared for the meeting", introvertPoints: 85, extrovertPoits: 15),
            Answer(answerTitle: "Go along unprepared as you are confident and like improvising", introvertPoints: 30, extrovertPoits: 70),
        ], questionId: UUID()),

        Question(questionTitle: "You can’t find your car keys. You:", answersArray: [
            Answer(answerTitle: "Don’t want anyone to find out, so you take the bus instead", introvertPoints: 90, extrovertPoits: 10),
            Answer(answerTitle: "Panic and search madly without asking anyone for help", introvertPoints: 60, extrovertPoits: 40),
            Answer(answerTitle: "Grumble without telling your family why you’re in a bad mood", introvertPoints: 65, extrovertPoits: 35),
            Answer(answerTitle: "Accuse those around you for misplacing them", introvertPoints: 10, extrovertPoits: 90),
        ], questionId: UUID()),

        Question(questionTitle: "A friend arrives late for your meeting. You:", answersArray: [
            Answer(answerTitle: "Say, ‘It’s not a problem,’ even if that’s not what you really think", introvertPoints: 80, extrovertPoits: 20),
            Answer(answerTitle: "Give them a filthy look and sulk for the rest of the evening", introvertPoints: 30, extrovertPoits: 70),
            Answer(answerTitle: "Tell them, ‘You’re too much! Have you seen the time?’", introvertPoints: 20, extrovertPoits: 80),
            Answer(answerTitle: "Make a scene in front of everyone", introvertPoints: 5, extrovertPoits: 95),
        ], questionId: UUID()),
//
//        Question(questionTitle: "You’ve been see a movie with your family and the reviews are mixed. You:", answersArray: [
//            Answer(answerTitle: "Don’t share your point of view with anyone", introvertPoints: 100, extrovertPoits: 0),
//            Answer(answerTitle: "Didn’t like the film, but keep your views to yourself when asked", introvertPoints: 90, extrovertPoits: 10),
//            Answer(answerTitle: "State your point of view with enthusiasm", introvertPoints: 30, extrovertPoits: 70),
//            Answer(answerTitle: "Try to bring the others round to your point of view", introvertPoints: 10, extrovertPoits: 90),
//        ], questionId: UUID()),
//
//        Question(questionTitle: "At work, somebody asks for your help for the hundredth time. You:", answersArray: [
//            Answer(answerTitle: "Give them a hand, as usual", introvertPoints: 70, extrovertPoits: 30),
//            Answer(answerTitle: "Accept — you’re known for being helpful", introvertPoints: 70, extrovertPoits: 30),
//            Answer(answerTitle: "Ask them, please, to find somebody else for a change", introvertPoints: 25, extrovertPoits: 75),
//            Answer(answerTitle: "Loudly make it known that you’re annoyed", introvertPoints: 10, extrovertPoits: 90),
//        ], questionId: UUID())
    ]
    
    var questions = QuestionsArray()
    var selectedAnswers = [UniqueAnswer]()
    
    func getQuestions(isSuccessfull: @escaping (Bool) -> ()) {
        APIClient.shared.getQuestions() { [weak self] result in
            switch result {
            case .success(let questionsResponse):
                self?.questions = questionsResponse
                isSuccessfull(true)
                break
                //if the api call fails for whatever reason, we use the hardcoded backup questions
            case .failure(.invalidData):
                self?.questions = self?.backupQuestions ?? []
                isSuccessfull(false)
                break
            case .failure(.networkFailure(let error)):
                print(error)
                self?.questions = self?.backupQuestions ?? []
                isSuccessfull(false)
                break
            }
        }
    }
    
    func addSelectedAnswer(selectedAnswer: Answer, forQuestionId questionId: UUID) {
        let uniqueAnswer = UniqueAnswer(answer: selectedAnswer, id: questionId)
        if !selectedAnswers.contains(where: { $0.id == questionId }) {
            selectedAnswers.append(uniqueAnswer)
        } else {
            selectedAnswers.removeAll(where: { $0.id == questionId })
            selectedAnswers.append(uniqueAnswer)
        }
    }
    
    func getPersonalityType() -> PersonalityType {
        var introvertPoints = 0
        var extrovertPoints = 0
        
        for uniqueAnswer in selectedAnswers {
            introvertPoints += uniqueAnswer.answer.introvertPoints ?? 0
            extrovertPoints += uniqueAnswer.answer.extrovertPoits ?? 0
        }
        if introvertPoints > extrovertPoints {
            return .introvert
        } else if introvertPoints < extrovertPoints {
            return .extrovert
        } else {
            return .both
        }
    }
    
    func getPersonalityPoints() -> PersonalityPoints {
        var introvertPoints = 0
        var extrovertPoints = 0
        
        for uniqueAnswer in selectedAnswers {
            introvertPoints += uniqueAnswer.answer.introvertPoints ?? 0
            extrovertPoints += uniqueAnswer.answer.extrovertPoits ?? 0
        }
        return PersonalityPoints(introvertPoints: introvertPoints, extrovertPoints: extrovertPoints)
    }
    
    func resetSelectedAnswers() {
        selectedAnswers = []
    }
}

enum PersonalityType {
    case introvert
    case extrovert
    case both
}

struct PersonalityPoints {
    var introvertPoints: Int
    var extrovertPoints: Int
}
