//
//  SettingView.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import SwiftUI

struct SettingView: View {
    
    // MARK: - PROPERTIES -
    
    @Bindable private var appData = AppData.shared
    
    // MARK: - VIEWS -
    var body: some View {
        HStack {
            Text("Dark Mode:")
            
            Spacer()
            
            Toggle(isOn: self.$appData.isDarkMode, label: {
                EmptyView()
            })
        }
        .padding()
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingView()
}
