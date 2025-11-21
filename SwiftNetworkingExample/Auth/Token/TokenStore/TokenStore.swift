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
        get { storage.get(for: TokenStoreKeys.accessToken) }
        set {
            if let value = newValue {
                storage.save(value, for: TokenStoreKeys.accessToken)
            } else {
                storage.delete(for: TokenStoreKeys.accessToken)
            }
        }
    }
    
    var refreshToken: String? {
        get { storage.get(for: TokenStoreKeys.refreshToken) }
        set {
            if let value = newValue {
                storage.save(value, for: TokenStoreKeys.refreshToken)
            } else {
                storage.delete(for: TokenStoreKeys.refreshToken)
            }
        }
    }
    
    // MARK: -
    func clearAll() {
        storage.delete(for: TokenStoreKeys.accessToken)
        storage.delete(for: TokenStoreKeys.refreshToken)
    }
}
