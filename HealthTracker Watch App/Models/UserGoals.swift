//
//  UserGoals.swift
//  HealthTracker
//
//  Created by Ken Gonzalez on 2/12/26.
//

import Foundation
import Combine


struct UserGoals: Codable {
    var dailyCaloriesGoal: Double
    var dailyWaterGoals: Double
    
    
    
    static let defaultGoals = UserGoals(
        dailyCaloriesGoal: 2500, dailyWaterGoals: 2000
    )
}

let goals: UserGoals = UserGoals(dailyCaloriesGoal: 1800, dailyWaterGoals: 1800)
let extendedGoals = UserGoals(dailyCaloriesGoal: 3000, dailyWaterGoals: 3000)
