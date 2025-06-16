//
//  MainTabView.swift
//  FitnessTracker
//
//  Created by Ntobeko Sikithi on 2025/06/15.
//

import SwiftUI
import Weather
import WorkoutTracker
import GoalManager


struct MainTabView: View {
    @StateObject private var weatherViewModel: WeatherViewModel
    init() {
        let weatherRepo = WeatherRepositoryImplementation(apiKey: "615c0b5cdb6822c4fcec3e0c800469c7") //Store the APIKey in a safe place
        let weatherViewModel = WeatherViewModel.configured(with: weatherRepo)
        self._weatherViewModel = StateObject(wrappedValue: weatherViewModel)
    }
    var body: some View {
        TabView {
            WorkoutView()
                .tabItem {
                    Image(systemName: "figure.run")
                    Text("Workout")
                }
            
            GoalView()
                .tabItem {
                    Image(systemName: "target")
                    Text("Goals")
                }
            
            WeatherView(viewModel: weatherViewModel)
                .tabItem {
                    Image(systemName: "cloud.sun")
                    Text("Weather")
                }
        }
    }
}
