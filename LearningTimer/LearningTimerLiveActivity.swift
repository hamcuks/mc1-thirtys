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
    @State var bookAppear: Int = 0
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LearningTimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack(alignment:.leading, spacing: 16) {
                Text("Learning Session")
                
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "book.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .foregroundStyle(.kSuccess)
                        
                        Spacer()
                        
                        
                    }
                    
                    ProgressView(value: 1600, total: 1800)
                        .background(.kAccent.opacity(0.5))
                        .tint(.kSuccess)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.white)
            .background(.black)
            
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
                            timerInterval: .now...Date.now.addingTimeInterval(
                                context.state.pauseTime ?? context.attributes.countdownInterval
                            ),
                            pauseTime: .now.addingTimeInterval(
                                context.state.pauseTime ?? 0
                            ),
                            countsDown: true
                        )
                        .bold()
                    }
                    .font(.largeTitle.bold())
                    .foregroundStyle(.kSuccess)
                    .frame(height: 48, alignment: .bottom)
                }
                
            } compactLeading: {
                
                if let pause = context.state.pauseTime {
                    ProgressView(
                        value: pause,
                        total: context.attributes.countdownInterval
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
                } else {
                    ProgressView(
                        timerInterval: .now...Date.now.addingTimeInterval(context.attributes.countdownInterval
                        ),
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
                }
                
            } compactTrailing: {
                Text("00:00")
                    .hidden()
                    .overlay {
                        Text(
                            timerInterval: .now...Date.now.addingTimeInterval(
                                context.state.pauseTime ?? context.attributes.countdownInterval
                            ),
                            pauseTime: .now.addingTimeInterval(
                                context.state.pauseTime ?? 0
                            ),
                            countsDown: true
                        )
                        .bold()
                    }
                    .foregroundStyle(.kSuccess)
                    .bold()
                
            } minimal: {
                if let pause = context.state.pauseTime {
                    ProgressView(
                        value: pause,
                        total: context.attributes.countdownInterval
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
                } else {
                    ProgressView(
                        timerInterval: .now...Date.now.addingTimeInterval(context.attributes.countdownInterval
                                                                         ),
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
                }
            }
            .keylineTint(.kAccent)
        }
    }
}

extension LearningTimerAttributes {
    fileprivate static var preview: LearningTimerAttributes {
        LearningTimerAttributes(countdownInterval: 10)
    }
}

extension LearningTimerAttributes.ContentState {
    fileprivate static var smiley: LearningTimerAttributes.ContentState {
        LearningTimerAttributes.ContentState()
    }
}

#Preview("Notification", as: .dynamicIsland(.compact), using: LearningTimerAttributes.preview) {
    LearningTimerLiveActivity()
} contentStates: {
    LearningTimerAttributes.ContentState.smiley
}
