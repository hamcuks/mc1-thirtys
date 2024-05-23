//
//  StreakScreen.swift
//  Thirtys
//
//  Created by DwikySP on 22/05/24.
//

import SwiftUI

struct StreakScreen: View {
    @State private var dates: Set<DateComponents> = []
    
    var uiColor = UIColor(red: 0.52, green: 0.86, blue: 0.78, alpha: 1.00)
    var titleColor = UIColor(red: 0.02, green: 0.25, blue: 0.20, alpha: 1.00)
    
    var body: some View {
        NavigationStack{
            ScrollView{
                
                
                ZStack{
                    Color.kBackground
                    VStack(alignment: .leading, spacing: 24){
                        VStack (alignment: .leading){
                            HStack(spacing: 4) {
                                Image(systemName: "flame.fill")
                                    .resizable()
                                    .frame(width: 46, height: 53)
                                    .foregroundColor(Color.kStreak)
                                VStack(alignment:.leading) {
                                    Text("16")
                                        .font(.largeTitle.bold())
                                        .foregroundColor(Color.kStreak)
                                    
                                    Text("days streak")
                                        .font(.system(.callout, weight: .medium))
                                        .foregroundColor(Color.kLabel)
                                }
                            }
                            
                            RoundedRectangle(cornerRadius: 6)
                                .foregroundColor(Color.kFrameStreak)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .overlay(
                                    Text("Congratulations on your 16-day streak! 🎉 Keep up the great work—consistency is key to success. Just a 30 minutes each day can make a huge difference! 🚀")
                                        .font(.caption)
                                        .foregroundColor(Color.black)
                                )
                                .frame(width: 361, height: 81)
                        }
                        .padding(16)
                        .background(.white)
                        
                        VStack(alignment: .center, spacing: 16){
                            HStack{
                                Text("Badges")
                                    .font(.system(.body, weight: .bold))
                                Spacer()
                                Text("View All")
                                    .font(.system(.footnote, weight: .semibold))
                                    .foregroundColor(Color.kLabel)
                            }
                            HStack {
                                ForEach(0..<5){ _ in
                                    ZStack {
                                        Image("badge logo")
                                            .resizable()
                                            .frame(width: 64, height: 75)
                                        Text("Badge Logo")
                                            .font(.caption)
                                            .foregroundColor(Color.kLabel)
                                    }
                                    .background(Color.kAccent)
                                    .cornerRadius(10)
                                }
                            }
                        }
                        .padding(16)
                        .background(.white)
                        
                        VStack(alignment: .leading){
                            Text("Calendar")
                                .font(.system(.body, weight: .bold))
                            MultiRangeDatePicker()
                                .padding(.horizontal, 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(uiColor: uiColor), lineWidth: 2)
                                        .frame(maxWidth: .infinity)
                                )
                                .accentColor(Color(uiColor: uiColor))
                            
                        }
                        .padding(16)
                        .background(.white)
                    }
                    .padding(.bottom, 32)
                }   .navigationTitle("Strike")
                    .font(.title)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct StreakScreen_Previews: PreviewProvider {
    static var previews: some View {
        StreakScreen()
    }
}

