//
//  LearningItemListComponent.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 22/05/24.
//

import SwiftUI

struct LearningTimeList: View {
    @State private var selectedDay: WeekdayType = .sunday
    var items: [GrouppedWeekdayEvent] = []
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                ForEach(WeekdayType.allCases, id: \.self) { day in
                    
                    VStack {
                        Text("\(day.shortTerm)")
                            .font(.subheadline)
                            .foregroundStyle(selectedDay == day ? .kTitleText : .kBody)
                            .frame(maxWidth: .infinity)
                            .fontWeight(selectedDay == day ? .bold : .medium)
                        
                        if selectedDay == day {
                            Rectangle()
                                .fill(.kTitleText)
                                .frame(height: 3)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.linear) {
                            selectedDay = day
                        }
                    }
                    
                }
            }
            if let learningTime = items.first(where: { $0.label == selectedDay }) {
                
                if learningTime.events.isEmpty {
                    Text("Oh, it looks like you're very busy!")
                        .fontWeight(.semibold)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(.kAccent, lineWidth: 1)
                        }
                } else {
                    List {
                        ForEach(
                            learningTime.events,
                            id: \.hashValue
                        ) { time in
                            HStack {
                                Text(time.startTime, style: .time)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.kTitleText)
                                Text("-")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.kTitleText)
                                Text(time.endTime, style: .time)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.kTitleText)
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(
                                        .kAccent, lineWidth: 1.5
                                    )
                            }
                            .listRowInsets(
                                EdgeInsets(
                                    .init(
                                        top: 0,
                                        leading: 0,
                                        bottom: 16,
                                        trailing: 0
                                    )
                                )
                            )
                            .listRowSeparator(.hidden)
                        }
                        
                        
                    }
                    .listStyle(.plain)
                }
                
            }
        }
    }
}


#Preview {
    LearningTimeList(items: [])
}
