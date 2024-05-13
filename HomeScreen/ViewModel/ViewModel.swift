//
//  ViewModel.swift
//  Sports
//
//  Created by Mina on 12/05/2024.
//
//APIkey=a8a55192122ca05d8d3ed9c78e5e429734e59abd7d0e8ebf333d58cdc0dbdc01
//APIkey=00df14beddee4ef5d0efee2255fde53ef246055b52806f3c699c4d5af73704e6
import Foundation
class HomeViewModel {
        func getSports() -> [Sport] {
        let sports = [
        Sport(title: "Football", image: "football"),
        Sport(title: "Basketball", image: "basketball"),
        Sport(title: "Tennis", image: "tennis"),
        Sport(title: "Cricket", image: "cricket"),
        Sport(title: "Hockey", image: "hockey")
        /*Sport(title: "Baseball", image: "baseball"),
        Sport(title: "American Football", image: "americanfootball")*/]
        return sports
    }
}

