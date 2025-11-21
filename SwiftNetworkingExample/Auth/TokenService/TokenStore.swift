//
//  TokenStore.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import Foundation
import SwiftUtilities

final class TokenStore: TokenStoreProtocol {
    static let shared = TokenStore()
    ///
    private let storage: KeychainStorageProtocol
    
    // MARK: -
    init(storage: KeychainStorageProtocol = KeychainStorageManager()) {
        self.storage = storage
    }
    
    // MARK: -
    var accessToken: String? {
        get { storage.get(for: TokenServiceAuthKeys.accessToken) }
        set {
            if let value = newValue {
                storage.save(value, for: TokenServiceAuthKeys.accessToken)
            } else {
                storage.delete(for: TokenServiceAuthKeys.accessToken)
            }
        }
    }
    
    var refreshToken: String? {
        get { storage.get(for: TokenServiceAuthKeys.refreshToken) }
        set {
            if let value = newValue {
                storage.save(value, for: TokenServiceAuthKeys.refreshToken)
            } else {
                storage.delete(for: TokenServiceAuthKeys.refreshToken)
            }
        }
    }
    
    // MARK: -
    func clearAll() {
        storage.delete(for: TokenServiceAuthKeys.accessToken)
        storage.delete(for: TokenServiceAuthKeys.refreshToken)
    }
}


