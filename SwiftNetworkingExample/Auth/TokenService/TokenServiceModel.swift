//
//  TokenServiceModel.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import Foundation

struct TokenServiceResponseModel: Decodable {
    let accessToken: String?
    let refreshToken: String?
}

// MARK: -
enum TokenServiceAuthKeys {
    static let accessToken = "accessToken"
    static let refreshToken = "refreshToken"
}
