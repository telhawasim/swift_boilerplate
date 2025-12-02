//
//  AppData+Ext.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 02/12/2025.
//

import SwiftUI

extension AppData {
    
    public enum Bind {
        
        public static var isDarkMode: Binding<Bool> {
            Binding(
                get: { AppData.shared.isDarkMode },
                set: { AppData.shared.isDarkMode = $0 }
            )
        }
    }
}
