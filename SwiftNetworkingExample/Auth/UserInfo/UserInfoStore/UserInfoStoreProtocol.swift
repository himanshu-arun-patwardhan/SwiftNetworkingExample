//
//  UserInfoStoreProtocol.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import Foundation

protocol UserInfoStoreProtocol {
    var userId: String? { get set }
    var username: String? { get set }
    var email: String? { get set }
    var firstName: String? { get set }
    var lastName: String? { get set }
    var gender: String? { get set }
    var image: String? { get set }
    
    func clearAll()
}
