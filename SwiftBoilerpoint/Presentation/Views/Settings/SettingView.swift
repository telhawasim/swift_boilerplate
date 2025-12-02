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
    
    @EnvironmentObject private var language: LanguageManager
        
    // MARK: - VIEWS -
    var body: some View {
        List {
            Section(AppTexts.Settings.appearance) {
                HStack {
                    Text(AppTexts.Settings.darkMode)
                    
                    Spacer()
                    
                    Toggle(isOn: self.$appData.isDarkMode, label: {
                        EmptyView()
                    })
                }
            }
            
            Section(AppTexts.Settings.language) {
                ForEach(AppLanguage.allCases) { language in
                    Button(action: {
                        self.language.currentLanguage = language
                    }, label: {
                        HStack {
                            Text(language.flag)
                            Text(language.displayName)
                                .foregroundStyle(Color.primary)
                            
                            Spacer()
                            
                            if self.language.currentLanguage == language {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.blue)
                            }
                        }
                    })
                }
            }
        }
        .navigationTitle(AppTexts.Settings.title)
    }
}

#Preview {
    SettingView()
        .environmentObject(LanguageManager.shared)
}
