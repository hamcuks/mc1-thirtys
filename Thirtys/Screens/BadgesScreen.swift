//
//  BadgesScreen.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 21/05/24.
//

import SwiftUI

struct BadgesScreen: View {
    
    var columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var badgeImage : [String] = []
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(badgeImage, id: \.self){ i in
                        Image("\(i)")
                            .padding()
                            .frame(height: 100)
                    }
                }
            }
            .navigationTitle("Badges")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    BadgesScreen()
}
