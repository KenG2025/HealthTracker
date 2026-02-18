//
//  ContentView.swift
//  HealthTracker Watch App
//
//  Created by Ken Gonzalez on 2/12/26.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HealthViewModel()
    
    var body: some View {
        NavigationStack {
            MainDashboardView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}
