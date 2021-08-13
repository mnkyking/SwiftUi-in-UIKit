//
//  HeaderView.swift
//  SwiftUi In UiKitTable
//
//  Created by Robin G on 8/13/21.
//

import SwiftUI

struct HeaderView: View {
    
    var buttonAction: (()->Void)?
    var body: some View {
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
    }
}
