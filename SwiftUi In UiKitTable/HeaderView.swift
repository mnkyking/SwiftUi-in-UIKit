//
//  HeaderView.swift
//  SwiftUi In UiKitTable
//
//  Created by Robin G on 8/13/21.
//

import SwiftUI

struct HeaderView: View {
    var title: String
    var subtitle: String?
    var buttonAction: (()->Void)?
    
    init(
        title: String,
        subtitle: String? = nil,
        buttonAction: (()->Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(self.title)
                    .font(.title3)
                    .foregroundColor(Color.black)
                if let subtitle = self.subtitle {
                    Text(subtitle)
                        .font(.body)
                        .foregroundColor(Color.gray)
                }
            }
            Spacer()
            if let action = buttonAction {
                Button(action: action, label: {
                    Text("Delete Item")
                        .background(Color.red)
                        .foregroundColor(Color.black)
                })
            }
        }
        /*
         old working stuff
         VStack {
             Text("Header")
             if let action = buttonAction {
                 Button(action: action, label: {
                     Text("Delete Item")
                         .background(Color.red)
                         .foregroundColor(Color.black)
                 })
             }
         }
         */
        
    }
}
