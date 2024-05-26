//
//  LearningTimerLiveActivity.swift
//  LearningTimer
//
//  Created by Ivan Nur Ilham Syah on 26/05/24.
//

import ActivityKit
import WidgetKit
import SwiftUI
import AppIntents

struct LearningTimerLiveActivity: Widget {
    @State var bookAppear: Int = 0
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LearningTimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack(alignment:.leading, spacing: 16) {
                Text("Learning Session")
                    .foregroundStyle(.kBackground)
                    .bold()
                
                HStack(spacing: 16) {
                    if let pause = context.state.pauseTime {
                        ProgressView(
                            value: pause,
                            total: context.attributes.countdownInterval
                        ) {
                            Image(systemName: "book.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                                .foregroundStyle(.kSuccess)
                        }
                        .labelsHidden()
                        .progressViewStyle(.circular)
                        .frame(height: 40)
                        .tint(.kSuccess)
                    } else {
                        ProgressView(
                            timerInterval: .now...Date.now.addingTimeInterval(context.attributes.countdownInterval),
                            countsDown: true,
                            label: { EmptyView() }
                        ) {
                            Image(systemName: "book.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                                .foregroundStyle(.kSuccess)
                        }
                        .labelsHidden()
                        .progressViewStyle(.circular)
                        .frame(height: 40)
                        .tint(.kSuccess)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Remaining")
                            .font(.subheadline)
                            .foregroundStyle(.kSuccess)
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
                            .font(.title.bold())
                            .foregroundStyle(.kSuccess)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        if context.state.pauseTime != nil {
                            LAButton(
                                icon: "play.fill",
                                size: 32,
                                intent: ResumeButtonIntent(),
                                foregroundStyle: .orange,
                                tint: .orange
                            )
                        } else {
                            LAButton(
                                icon: "pause.fill",
                                size: 32,
                                intent: PauseButtonIntent(),
                                foregroundStyle: .orange,
                                tint: .orange
                            )
                        }
                        
                        LAButton(
                            icon: "xmark",
                            size: 32,
                            intent: StopButtonIntent()
                        )
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.white)
            .background(.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading, priority: 2) {
                    HStack(spacing: 0) {
                        if context.state.pauseTime != nil {
                            LAButton(
                                icon: "play.fill",
                                size: 32, 
                                intent: ResumeButtonIntent(),
                                foregroundStyle: .orange,
                                tint: .orange
                            )
                        } else {
                            LAButton(
                                icon: "pause.fill",
                                size: 32,
                                intent: PauseButtonIntent(),
                                foregroundStyle: .orange,
                                tint: .orange
                            )
                        }
                        
                        LAButton(
                            icon: "xmark",
                            size: 32,
                            intent: StopButtonIntent()
                        )
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                       HStack {
                            Spacer()
                            Text("Remaining")
                                .font(.subheadline)
                                .foregroundStyle(.kSuccess)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 48, alignment: .trailing)
                        }
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

#Preview("Notification", as: .dynamicIsland(.expanded), using: LearningTimerAttributes.preview) {
    LearningTimerLiveActivity()
} contentStates: {
    LearningTimerAttributes.ContentState.smiley
}

struct LAButton: View {
    var icon: String
    var size: Double = 40
    var intent: any LiveActivityIntent
    var foregroundStyle: Color = .white
    var tint: Color = .white
    
    var body: some View {
        Button(intent: intent) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .padding(10)
                .frame(width: size, height: size)
        }
        .foregroundStyle(foregroundStyle)
        .tint(tint)
        .clipShape(Circle())
    }
}
