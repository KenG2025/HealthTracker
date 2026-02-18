//
//  MotivationalQuoteservice.swift
//  HealthTracker
//
//  Created by Ken Gonzalez on 2/17/26.
//

import Foundation
import Combine


//Service to fetch quoyess from Zen API

class MotivationalQuotesService {
    //Singleton
    static let shared = MotivationalQuotesService()
    private init() {}
    
    private var apiurl = "https://zenquotes.io/api/random"
    
    private let decoder = JSONDecoder()
    
    //MaRK: - Fallback Quotes
    //Design Principles: Offline First = always available
    private let fallbackQuotes: [MotivationalQuotes] = [
         MotivationalQuotes(quote: "The more we value things, the less we value ourselves.", author: "unknown"),
         MotivationalQuotes(quote: "Opportunity often comes disguised in the form of misfortune or temporary defeat", author: "unknown"),
         MotivationalQuotes(quote: "Man should fear never beginning to live.", author: "unknown")
     ]
    
    func fetchQuotes() async -> MotivationalQuotes {
        guard let url = URL(string: apiurl) else {
            return fallbackQuotes.randomElement() ?? fallbackQuotes[0]
        }
        do {
            //Data response not decoded
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let response = try decoder.decode([MotivationalQuotes.APIResponse].self, from: data)
            
            if let response = response.first {
                return MotivationalQuotes(quote: response.q, author: response.a)
            }
        }catch{
            return fallbackQuotes.randomElement() ?? fallbackQuotes[0]
        }
        return fallbackQuotes.randomElement() ?? fallbackQuotes[0]
    }
}
