//
//  StreakScreen.swift
//  Thirtys
//
//  Created by DwikySP on 22/05/24.
//

import SwiftUI

struct StreakScreen: View {
    
    @State private var isViewClicked: Bool = false
    @State private var path = NavigationPath()
    
    @EnvironmentObject private var vm: DailyStreakViewModel
    
    var body: some View {
        NavigationStack(path: $path){
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    VStack (alignment: .leading, spacing: 16){
                        HStack(spacing: 8) {
                            Image(systemName: "flame.fill")
                                .resizable()
                                .frame(width: 46, height: 53)
                                .foregroundColor(Color.kStreak)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(vm.streaks.count)")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(Color.kStreak)
                                
                                Text("days streak")
                                    .font(.system(.callout, weight: .medium))
                                    .foregroundColor(Color.kLabel)
                            }
                        }
                        
                        (
                             vm.streaks.count == 0 ?
                                Text("Let's start your learning journey today! Every great achievement begins with the first step")
                             :
                                Text("Congratulations on your \(vm.streaks.count)-day streak! 🎉 Keep up the great work—consistency is key to success. Just a 30 minutes each day can make a huge difference! 🚀")
                            
                        )
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.kTitleText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.kBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(16)
                    .background(.white)
                    
                    VStack(alignment: .center, spacing: 16){
                        HStack{
                            Text("Badges")
                                .font(.system(.body, weight: .bold))
                            Spacer()
                            Button{
                                isViewClicked.toggle()
                            } label: {
                                Text("View All")
                                    .font(.system(.footnote, weight: .semibold))
                                    .foregroundColor(Color.kSuccess)
                            }
                        }
                        HStack {
                            ForEach(BadgeData.items.prefix(5), id: \.id){ badge in
                                
                                Spacer()
                                
                                Image("\(badge.image)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 56)
                                    .opacity(
                                        vm.isAchieved(badge: badge) ? 1 : 0.5
                                    )
                                    .grayscale(
                                        vm.isAchieved(badge: badge) ? 0 : 1
                                    )
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(16)
                    .background(.white)
                    
                    VStack(alignment: .leading){
                        Text("Calendar")
                            .font(.system(.body, weight: .bold))
                        
                        MultiRangeDatePicker(
                            dates: Set(
                                vm.streaks.map {
                                    Calendar.current.dateComponents(
                                        [.day, .month, .year],
                                        from: $0.date!
                                    )
                                }
                            )
                        )
                        .disabled(true)
                        .padding(.horizontal, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.kAccent, lineWidth: 2)
                                .frame(maxWidth: .infinity)
                        )
                        
                    }
                    .padding(16)
                    .background(.white)
                }
                .padding(.bottom, 32)
                .sheet(isPresented: $isViewClicked){
                    BadgeSheetView(collectedBadges: vm.badges)
                }
                .background(.kBackground)
              
            }
            .refreshable {
                vm.getPlan()
                vm.getLearningStreaks()
                vm.getBadges()
            }
            .onAppear {
                vm.getPlan()
                vm.getLearningStreaks()
                vm.getBadges()
            }
            .navigationTitle("Streak")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct StreakScreen_Previews: PreviewProvider {
    static var previews: some View {
        StreakScreen()
            .environmentObject(DailyStreakViewModel())
    }
}

