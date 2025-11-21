//
//  LoginModel.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import Foundation

struct LoginRequestBodyModel: Encodable {
    let username: String
    let password: String
    let expiresInMins: Int
}

struct LoginResponseModel: Decodable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    let accessToken: String
    let refreshToken: String
}
