//
//  LearningTimerLiveActivity.swift
//  LearningTimer
//
//  Created by Ivan Nur Ilham Syah on 26/05/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LearningTimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LearningTimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
//                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading, priority: 2) {
                    HStack {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(14)
                            .frame(width: 48, height: 48)
                            .foregroundStyle(.orange)
                            .background(.orange.opacity(0.2))
                            .clipShape(Circle())
                        
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .padding(14)
                            .bold()
                            .frame(width: 48, height: 48)
                            .foregroundStyle(.white)
                            .background(.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                    
                        Text("Remaining")
                            .font(.subheadline)
                            .foregroundStyle(.kSuccess)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 48, alignment: .trailing)
                }
                DynamicIslandExpandedRegion(.trailing, priority: 0) {
                    
                    Text("00:00")
                    .hidden()
                    .overlay {
                        Text(
                            timerInterval: context.state.startDate...context.state.timer,
                            pauseTime: context.state.pauseDate,
                            countsDown: true
                        )
                        .bold()
                    }
                    .font(.largeTitle.bold())
                    .foregroundStyle(.kSuccess)
                    .frame(height: 48, alignment: .bottom)
                }
                
            } compactLeading: {
                ProgressView(
                    timerInterval: context.state.startDate...context.state.timer,
                    countsDown: true,
                    label: { EmptyView() }
                ) {
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                        .foregroundStyle(.kSuccess)
                }
                .labelsHidden()
                .progressViewStyle(.circular)
                .frame(height: 24)
                .tint(.kSuccess)
                .padding(.trailing, 24)
                
            } compactTrailing: {
                Text("00:00")
                    .hidden()
                    .overlay {
                        Text(
                            timerInterval: context.state.startDate...context.state.timer,
                            pauseTime: context.state.pauseDate,
                            countsDown: true
                        )
                        .bold()
                    }
                    .foregroundStyle(.kSuccess)
                    .bold()
                
            } minimal: {
                ProgressView(
                    timerInterval: context.state.startDate...context.state.timer,
                    countsDown: true,
                    label: { EmptyView() }
                ) {
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                        .foregroundStyle(.kSuccess)
                }
                .labelsHidden()
                .progressViewStyle(.circular)
                .frame(height: 24)
                .tint(.kSuccess)
            }
            .keylineTint(.kAccent)
        }
    }
}

extension LearningTimerAttributes {
    fileprivate static var preview: LearningTimerAttributes {
        LearningTimerAttributes()
    }
}

extension LearningTimerAttributes.ContentState {
    fileprivate static var smiley: LearningTimerAttributes.ContentState {
        LearningTimerAttributes.ContentState(startDate: .now, timer: .now)
    }
}

#Preview("Notification", as: .dynamicIsland(.expanded), using: LearningTimerAttributes.preview) {
    LearningTimerLiveActivity()
} contentStates: {
    LearningTimerAttributes.ContentState.smiley
}
