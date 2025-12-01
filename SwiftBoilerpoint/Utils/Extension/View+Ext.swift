//
//  View+Ext.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 01/12/2025.
//

import Foundation
import SwiftUI

extension View {
    
    /// In order to show custom alert in case there is no intenert
    /// - Returns: `some View` will return the alert for no internet
    func customNetworkAlert() -> some View {
        self.modifier(NetworkMonitorModifier())
    }
}
