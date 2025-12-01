//
//  NetworkMonitorModifier.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 01/12/2025.
//

import SwiftUI

struct NetworkMonitorModifier: ViewModifier {
    
    // MARK: - PROPERTIES -
    
    //ObservedObject
    @ObservedObject private var networkMonitor =  NetworkMonitor.shared
    //State
    @State private var showAlert: Bool = false
    
    // MARK: - BODY -
    func body(content: Content) -> some View {
        content
            .overlay {
                if self.showAlert {
                    ZStack {
                        Color.primary.opacity(0.4)
                            .ignoresSafeArea()
                        
                        NetworkAlertView()
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            }
            .onChange(of: self.networkMonitor.isConnected) { _, isConnected in
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    self.showAlert = !isConnected
                }
            }
            .onAppear {
                self.showAlert = !self.networkMonitor.isConnected
            }
    }
}
