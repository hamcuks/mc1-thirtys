//
//  StepTwoOnboardingScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 20/05/24.
//

import SwiftUI

struct StepTwoOnboardingScreen: View {
    
    var weekDays: [String] = [ 
        "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
    ]
    
    @State private var isTimePickerOpened: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                ScrollView {
                    VStack(spacing: 40) {
                        Image(.workSchedules)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 210)
                        
                        VStack (spacing: 16) {
                            Text("Your Work Schedules!")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.kTitleText)
                            Text("Setting your work hours allows us to allocate your time effectively")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundStyle(.kBody)
                                .multilineTextAlignment(.center)
                        }
                        
                        VStack(spacing: 16) {
                            ForEach(weekDays, id: \.self) { day in
                                ListItemComponent(
                                    label: day, 
                                    selection: .constant([]),
                                    isOpen: $isTimePickerOpened
                                )
                            }
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink(
                    destination: GetStartedScreen()
                ) {
                    AppButton(label: "Next")
                }
                .buttonStyle(.plain)
                
            }
            .scrollIndicators(.hidden)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            })
            .padding()
            .navigationTitle("Step 2/3")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    StepTwoOnboardingScreen()
}
