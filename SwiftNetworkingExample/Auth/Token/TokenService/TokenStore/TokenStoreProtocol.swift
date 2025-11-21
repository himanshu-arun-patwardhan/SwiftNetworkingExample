//
//  TokenStoreProtocol.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import Foundation

protocol TokenStoreProtocol {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
    
    func clearAll()
}
