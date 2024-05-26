////
////  AppDatePickerV2.swift
////  Thirtys
////
////  Created by Rajesh Triadi Noftarizal on 26/05/24.
////
//
//import SwiftUI
//
//struct AppDatePickerV2: View {
//    
//    @Binding var selection: Date
//    
//    var label: String
//    var placeholder: String = "Select Date"
//    
//    @State private var isOpened: Bool = false
//    @Environment(\.isEnabled) private var isEnabled
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8){
//            Text("\(label)")
//                .font(.subheadline)
//                .bold()
//                .foregroundStyle(.kTitleText)
//            
//            HStack {
//                Text(selection, style: .date)
//                    .fontWeight(.medium)
//                
//                Spacer()
//                
//                if isEnabled {
//                    Image(systemName: "calendar")
//                        .onTapGesture {
//                            isOpened.toggle()
//                        }
//                }
//                
//            }
//            .foregroundStyle(.kTitleText)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(16)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(.kAccent, lineWidth: 2)
//            )
//            
//        }
//        .sheet(isPresented: $isOpened) {
//            VStack(spacing: 24){
////                DatePicker("", selection: $selection, in: .now..., displayedComponents: .date)
////                    .datePickerStyle(.graphical)
////                RangeCalendar()
//                
//                Button("Set") {
//                    isOpened.toggle()
//                }.buttonStyle(AppButtonStyle())
//            }
//            .presentationDetents([.medium])
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Text("Save")
//                }
//            }
//            
//        }
//    }
//}
//
//
//
//#Preview {
//    AppDatePickerV2(selection: .constant(.now), label: "Label")
//}
