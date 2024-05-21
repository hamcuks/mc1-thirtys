//
//  GoalViewModel.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 21/05/24.
//

import Foundation

class GoalViewModel: ObservableObject {
    
    @Published var selectedDay: String = "SUN"
    @Published var goals_title: String = ""
    @Published var goals_duration: String = ""
    @Published var suggestTime: [String] = ["coba", "cobi", "cobu"]
    
    
    func getSuggestionTime(selectedDay: String) -> [String]{
        
        switch selectedDay{
        case "SUN":
            return ["coba", "1", "2"]

        case "MON":
            return ["10", "11", "12"]
            
        case "TUE":
            return ["20", "21", "22"]
            
        case "WED":
            return ["10", "11", "12"]
            
        case "THU":
            return ["20", "21", "22"]
            
        case "FRI":
            return ["10", "11", "12"]
            
        case "SAT":
            return ["20", "21", "22"]
            
        default:
            return ["10", "11", "12"]
        }
        
    }
    
    
    
}
