//
//  NetworkAlertView.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 01/12/2025.
//

import SwiftUI

struct NetworkAlertView: View {
    
    // MARK: - PROPERTIES -
    
    // MARK: - VIEWS -
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 50))
                .foregroundStyle(Color.primary)
            
            Text("No Internet Connection")
                .font(.headline)
                .foregroundStyle(Color.primary)
            
            Text("Please check your connection and try again")
                .font(.subheadline)
                .foregroundStyle(Color.primary.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding(24)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.5))
        }
        .padding(.horizontal, 40)
        .shadow(radius: 10)
    }
}

#Preview {
    NetworkAlertView()
}
