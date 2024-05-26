//
//  ReconfigureView.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 26/05/24.
//

import SwiftUI

struct ReconfigureView: View {
    
    @State private var navigateToReconfigSchedule = false
    
    var body: some View {
        NavigationStack{
            Form{
                Section {
                    NavigationLink(destination: WorkScheduleView()) {
                        HStack {
                            Image(systemName: "bag.fill")
                                .foregroundStyle(Color.white)
                                .frame(width: 30, height: 30)
                                .background(Color.orange)
                                .cornerRadius(7)
                            Text("Work Schedules")
                            
                        }
                    }
                    
                    NavigationLink(destination: BedTimeView()) {
                        HStack {
                            Image(systemName: "bed.double.fill")
                                .foregroundStyle(Color.white)
                                .frame(width: 30, height: 30)
                                .background(Color.green)
                                .cornerRadius(7)
                            Text("Bed Time")
                        }
                    }
                }
            header: {
                Text("General Information")
            }
                
                Section {
                    Button{
                        navigateToReconfigSchedule.toggle()
                    } label: {
                        Text("Reconfigure Schedules")
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundStyle(Color.kLabel)
                    }
                    .background{
                        navigationDestination(isPresented: $navigateToReconfigSchedule) {
                            WorkScheduleView()
                        }
                        .hidden()
                    }
                    
                }
                .listRowBackground(Color.kAccent)
            }
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ReconfigureView()
}
