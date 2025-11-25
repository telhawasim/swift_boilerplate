//
//  SettingView.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import SwiftUI

struct SettingView: View {
    
    // MARK: - PROPERTIES -
    
    //EnvironmentObject
    @EnvironmentObject private var appearance: AppearanceManager
    //State
    @State private var isDarkModeOn: Bool = false
    
    // MARK: - VIEWS -
    var body: some View {
        HStack {
            Text("Dark Mode:")
            
            Spacer()
            
            Toggle(isOn: self.$isDarkModeOn, label: {
                Text("")
            })
            .onChange(of: self.isDarkModeOn) { (oldValue, newValue) in
                self.appearance.toogleDarkMode(newValue)
            }
        }
        .padding()
        .navigationTitle("Settings")
        .onAppear {
            self.isDarkModeOn = self.appearance.currentAppearance == .dark
        }
    }
}

#Preview {
    SettingView()
        .environmentObject(AppearanceManager())
}
