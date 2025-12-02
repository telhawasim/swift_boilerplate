//
//  Optional+Ext.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 01/12/2025.
//

import Foundation

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}
