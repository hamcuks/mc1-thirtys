//
//  PathHandler.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 26/05/24.
//

import SwiftUI


class PathHandler: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var isSettingOpen : Bool = false
    
}
