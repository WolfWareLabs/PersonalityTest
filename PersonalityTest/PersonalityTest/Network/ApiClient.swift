//
//  ApiClient.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 5.12.22.
//

import Foundation

enum RequestResult<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}

enum RequestLoadingError: Error {
    case networkFailure(Error)
    case invalidData
}

typealias QuestionsHandler = (RequestResult<QuestionsArray, RequestLoadingError>) -> Void

class APIClient {
    
    public static let shared = APIClient()
    
    let urlString = "https://mocki.io/v1/41901d87-805c-4b74-baa9-ac2a1d009002"
    
    func getQuestions(completionHandler: @escaping QuestionsHandler) {
        if let endpointUrl = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: endpointUrl) { result in
                switch result {
                case .success(let data):
                    if let questionsResponse = try? JSONDecoder().decode(QuestionsArray.self, from: data) {
                        completionHandler(.success(questionsResponse))
                    } else {
                        completionHandler(.failure(.invalidData))
                    }
                case .failure(let error):
                    completionHandler(.failure(.networkFailure(error)))
                }
            }
            task.resume()
        }
    }
}

/* using mocki.io, I created a sample API endpoint which should return the following JSON:
 
[{"answersArray":[{"introvertPoints":75,"answerTitle":"Go with great hesitation as these sessions are torture for you","extrovertPoits":25},{"introvertPoints":20,"answerTitle":"Look forward to hearing what your boss thinks about you and expects from you","extrovertPoits":80},{"introvertPoints":85,"answerTitle":"Rehearse ad nauseam the arguments and ideas that youâ€™ve prepared for the meeting","extrovertPoits":15},{"introvertPoints":30,"answerTitle":"Go along unprepared as you are confident and like improvising","extrovertPoits":70}],"questionTitle":"Itâ€™s time for your annual appraisal with your boss. You:","questionId":"C954C666-B9C5-4DE9-9929-6CD0F87D1605"},{"answersArray":[{"introvertPoints":90,"answerTitle":"Donâ€™t want anyone to find out, so you take the bus instead","extrovertPoits":10},{"introvertPoints":60,"answerTitle":"Panic and search madly without asking anyone for help","extrovertPoits":40},{"introvertPoints":65,"answerTitle":"Grumble without telling your family why youâ€™re in a bad mood","extrovertPoits":35},{"introvertPoints":10,"answerTitle":"Accuse those around you for misplacing them","extrovertPoits":90}],"questionTitle":"You canâ€™t find your car keys. You:","questionId":"06563402-AC58-4047-A18A-28D0A3BEDF1B"},{"answersArray":[{"introvertPoints":80,"answerTitle":"Say, â€˜Itâ€™s not a problem,â€™ even if thatâ€™s not what you really think","extrovertPoits":20},{"introvertPoints":30,"answerTitle":"Give them a filthy look and sulk for the rest of the evening","extrovertPoits":70},{"introvertPoints":20,"answerTitle":"Tell them, â€˜Youâ€™re too much! Have you seen the time?â€™","extrovertPoits":80},{"introvertPoints":5,"answerTitle":"Make a scene in front of everyone","extrovertPoits":95}],"questionTitle":"A friend arrives late for your meeting. You:","questionId":"59258AC4-F134-4FBD-BF41-35F32D88CF0A"},{"answersArray":[{"introvertPoints":100,"answerTitle":"Donâ€™t share your point of view with anyone","extrovertPoits":0},{"introvertPoints":90,"answerTitle":"Didnâ€™t like the film, but keep your views to yourself when asked","extrovertPoits":10},{"introvertPoints":30,"answerTitle":"State your point of view with enthusiasm","extrovertPoits":70},{"introvertPoints":10,"answerTitle":"Try to bring the others round to your point of view","extrovertPoits":90}],"questionTitle":"Youâ€™ve been see a movie with your family and the reviews are mixed. You:","questionId":"354CD556-1E6B-4D5D-8F16-3801A90EA726"},{"answersArray":[{"introvertPoints":70,"answerTitle":"Give them a hand, as usual","extrovertPoits":30},{"introvertPoints":70,"answerTitle":"Accept â€” youâ€™re known for being helpful","extrovertPoits":30},{"introvertPoints":25,"answerTitle":"Ask them, please, to find somebody else for a change","extrovertPoits":75},{"introvertPoints":10,"answerTitle":"Loudly make it known that youâ€™re annoyed","extrovertPoits":90}],"questionTitle":"At work, somebody asks for your help for the hundredth time. You:","questionId":"73B21A5D-30D5-40E1-87CE-26024A8BE8BD"}]
 
 */
