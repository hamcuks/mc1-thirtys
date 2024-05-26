//
//  Platform.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 26/05/24.
//

import Foundation
import SwiftUI

struct Platform: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var imageName: String
    var color: Color
}
