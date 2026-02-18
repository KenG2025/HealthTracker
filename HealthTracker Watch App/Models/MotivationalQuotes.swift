//
//  MotivationalQuoyes.swift
//  HealthTracker
//
//  Created by Ken Gonzalez on 2/17/26.
//

import Foundation
import Combine


struct MotivationalQuotes: Codable {
    let quote: String
    let author: String
    
    struct APIResponse: Codable {
        let q: String
        let a: String
    }
}
