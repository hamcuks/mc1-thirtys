//
//  ComponentDate.swift
//  Coba-coba
//
//  Created by Bayu Septyan Nur Hidayat on 19/05/24.
//

import SwiftUI

struct ComponentDate: View {
    
    @State private var modalPresent = false
    
    var body: some View {
        Button{
            print("coba")
            modalPresent.toggle()
        } label: {
            Text("Coba")
        }
        .sheet(isPresented: $modalPresent, content: {
            DatePickerCustom()
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.hidden)
        })
    }
}

struct DatePickerCustom : View {
    
    @State private var startDate = Date()
    var uiColor = UIColor(red: 0.52, green: 0.86, blue: 0.78, alpha: 1.00)
    
    var titleColor = UIColor(red: 0.02, green: 0.25, blue: 0.20, alpha: 1.00)
    
    var body: some View{
        VStack{
            Text("Set Up Work Time Range")
                .bold()
                .padding(.bottom, 20)
            VStack{
                HStack(alignment: .top){
    //                Text("Start Time")
                    DatePicker("Start Time :", selection: $startDate, displayedComponents: [.hourAndMinute])
    //                    .labelsHidden()
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
                        .padding([.horizontal], 20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(uiColor: uiColor), lineWidth: 2)
                        )
                        .accentColor(Color(uiColor: uiColor))
                }
                
                HStack(alignment: .top){
    //                Text("Start Time")
                    DatePicker("End Time :", selection: $startDate, displayedComponents: [.hourAndMinute])
    //                    .labelsHidden()
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
                        .padding([.horizontal], 20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(uiColor: uiColor), lineWidth: 2)
                        )
                        .accentColor(Color(uiColor: uiColor))
                }
                
            }
            .font(.system(.body, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            Spacer()
            Button{
                print("coba")
            } label: {
                Text("Set")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, maxHeight: 35)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(uiColor: uiColor))
                    
            
            
            .padding(.horizontal, 30)
            
                
        }
        .padding(.vertical, 40)
        .foregroundColor(Color(uiColor: titleColor))
        
    }
}

#Preview {
    ComponentDate()
}
