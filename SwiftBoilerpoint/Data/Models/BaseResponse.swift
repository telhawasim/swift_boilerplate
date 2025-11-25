//
//  BaseResponse.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

struct BaseResponse<T: Decodable>: Decodable {
    let status: Int?
    let message: String?
    let data: T?
}

struct BaseErrorResponse: Decodable {
    let status: Int?
    let message: String?
}
