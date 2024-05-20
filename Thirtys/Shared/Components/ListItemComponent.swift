//
//  ListItemComponent.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 20/05/24.
//

import SwiftUI

struct ListItemComponent: View {
    var label: String
    
    @Binding var selection: [Date]
    @Binding var isOpen: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.kTitleText)
            
            Spacer()
            
            HStack {

                if selection.isEmpty {
                    Text("Set Up")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                } else {
                    (
                        Text(selection.first!, style: .time) +
                        Text(" - ") +
                        Text(selection.last!, style: .time)
                    )
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                    
                Image(
                    systemName: selection.isEmpty ? "chevron.forward" : "pencil"
                )
                
            }
            .bold()
            .foregroundStyle(.kSuccess)
            .onTapGesture {
                isOpen.toggle()
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(
                    .kAccent, lineWidth: 1.5
                )
        }
    }
}

#Preview {
    ListItemComponent(
        label: "Item",
        selection: .constant([.now, .now]),
        isOpen: .constant(false)
    )
}
