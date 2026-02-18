//
//  Untitled.swift
//  HealthTracker
//
//  Created by Ken Gonzalez on 2/17/26.
//

import Foundation
import Combine
import HealthKit


class HealthKitManager {
    static let shared = HealthKitManager()
    private init() {}
    
    let healthStore = HKHealthStore()
    
    let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
    let heartRateUnit = HKUnit(from: "count/bpm") //BPM
    
    var ifHealthIsAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }
    
    func requestAuthorization() async throws {
        let typesToRead: Set<HKObjectType> = [heartRateType]
        let typesToWrite: Set<HKSampleType> = []
        
        try await healthStore.requestAuthorization(toShare: typesToWrite, read: typesToRead)
    }
    
    func createAuthorizationStatus() -> HKAuthorizationStatus {
        healthStore.authorizationStatus(for: heartRateType)
    }
    
    //Query
    func setchLatestHeartRate() async throws -> Double? {
        return try await withCheckedThrowingContinuation {confirmation in
            //Order for the data
            let sortDescriptor = NSSortDescriptor(
                key: HKSampleSortIdentifierStartDate, //Start date for the measurement to be taken
                ascending: false
            )
            
            let query = HKSampleQuery(
                sampleType: heartRateType,
                predicate: nil,
                limit: 1,
                sortDescriptors: [sortDescriptor]
            )
            {
                query, samples, error in
                if let error = error {
                    confirmation.resume(throwing: error)
                }
                
                guard let sample = samples?.first as? HKQuantitySample else {
                    confirmation.resume(returning: 0)
                    return
                }
                
                let bpm = sample.quantity.doubleValue(for: self.heartRateUnit)
                confirmation.resume(returning: bpm)
                
            }
            healthStore.execute(query)
        }
    }
}
