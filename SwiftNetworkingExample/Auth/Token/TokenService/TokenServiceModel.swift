//
//  TokenServiceModel.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import Foundation

struct TokenServiceRequestBodyModel: Encodable {
    let refreshToken: String
    let expiresInMins: Int
}

struct TokenServiceResponseModel: Decodable {
    let accessToken: String?
    let refreshToken: String?
}
