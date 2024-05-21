//
//  FinishLearningScreen.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 20/05/24.
//

import SwiftUI

struct FinishLearningScreen: View {
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                Color.kBackground
                VStack(spacing: 24){
                    WeeklyStreak()
                    FinishComponent()
                    LearningHistory()
                }
                .padding(.top)
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
            }
            .toolbar{
                HStack{
                    Image(systemName: "flame.fill")
                    Text("100")
                        .font(.system(.body, weight: .black))
                }
                .foregroundStyle(Color.kStreak)
            
            
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Today"))
        }
    }
}


// Image finish learning
struct FinishComponent: View {
    var body: some View {
        VStack(alignment: .center, spacing: 32){
            Image("finish-learning")
                .resizable()
                .frame(maxWidth: 250, maxHeight: 200, alignment: .leading)
            
            Text("Hooray! You’ve completed your 30 minutes of learning today!")
                .multilineTextAlignment(.center)
                .frame(width: 300,alignment: .center)
                .font(.system(.body, weight: .semibold))
        }
        .frame(maxWidth: .infinity)
        .padding([.vertical, .horizontal], 32)
        .background(.white)
    }
}

struct LearningHistory: View {
    
    @State private var isHasContent: Bool = true
    @State private var DurationLearning = [2, 1]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24){
            Text("Learning History")
                .font(.system(.body, weight: .bold))
                .frame(maxWidth: .infinity,alignment: .leading)
            if DurationLearning.count > 0 {
                VStack(spacing: 16){
                    ForEach(DurationLearning, id: \.self){ i in
                        HStack{
                            Text("23 Minutes")
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .font(.system(.subheadline, weight: .semibold))
                            
                            Text("06.15 - 06.38")
                                .frame(maxWidth: .infinity,alignment: .trailing)
                                .font(.system(.subheadline, weight: .semibold))
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.kAccent, lineWidth: 2)
                        )
                    }
                }
            }
        }
        .foregroundColor(Color.kTitleText)
        .padding([.horizontal, .vertical], 20)
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}


struct WeeklyStreak: View {
    
    let data = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    @State private var isDailyAchive: Bool = false
    
    var body: some View {
        
            HStack{
                Grid(horizontalSpacing: 28, verticalSpacing: 0){
                    GridRow{
                        ForEach(data, id: \.hashValue) { i in
                            VStack{
                                Text("\(i)")
                                    .font(.system(.caption2, weight: .semibold))
                                    .foregroundStyle(Color.kBody)
    //                                .padding(.bottom, 12)
                                if isDailyAchive{
                                    Image("daily-achievement")
                                        .frame(maxWidth: 24)
                                } else {
                                    Circle()
                                        .stroke(Color.kPlaceholder, lineWidth: 4)
                                        .frame(maxWidth: 24)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
        
    }
}

#Preview {
    FinishLearningScreen()
}
