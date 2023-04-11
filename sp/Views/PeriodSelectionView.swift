//
//  PeriodSelectionView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 11/04/2023.
//

import SwiftUI

struct PeriodSelectionView: View {
    
    var buttonCallBack: (String) -> Void
    
    let options = [
        Option(value: "CURRENT_MONTH", text: "Current Month"),
        Option(value: "PREVIOUS_MONTH", text: "Previous Month"),
        Option(value: "YEAR", text: "Year"),
        Option(value: "CUSTOM", text: "Custom")
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            CustomText(text: "Select Period", size: .p1, color: .secondaryColor, bold: true)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(options, id: \.id) { option in
                        CustomText(text: option.text, size: .p1, color: .secondaryColor)
                            .onTapGesture {
                                self.buttonCallBack(option.value)
                            }
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            .scrollIndicators(.never)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.bgColor)
    }
}


//struct PeriodSelectionView_Previews: PreviewProvider {
//     
//
//    
//    static var previews: some View {
//        PeriodSelectionView(buttonCallBack: onSelectionPeriod)
//    }
//    
//    func onSelectionPeriod(val: String) -> Void {
//        print(val)
//    }
//}
