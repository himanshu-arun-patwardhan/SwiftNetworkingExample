//
//  UserInfoStore.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import Foundation
import SwiftUtilities

struct UserInfoStore: UserInfoStoreProtocol {
    static let shared = UserInfoStore()
    ///
    private let storage: UserDefaultsStorageProtocol
    
    // MARK: -
    init(store: UserDefaultsStorageProtocol = UserDefaultsManager()) {
        self.storage = store
    }
    
    // MARK: -
    var userId: String? {
        get { storage.get(forKey: UserInfoStoreKeys.userId) }
        set { storage.set(newValue, forKey: UserInfoStoreKeys.userId) }
    }
    
    var username: String? {
        get { storage.get(forKey: UserInfoStoreKeys.username) }
        set { storage.set(newValue, forKey: UserInfoStoreKeys.username) }
    }
    
    var email: String? {
        get { storage.get(forKey: UserInfoStoreKeys.email) }
        set { storage.set(newValue, forKey: UserInfoStoreKeys.email) }
    }
    
    var firstName: String? {
        get { storage.get(forKey: UserInfoStoreKeys.firstName) }
        set { storage.set(newValue, forKey: UserInfoStoreKeys.firstName) }
    }
    
    var lastName: String? {
        get { storage.get(forKey: UserInfoStoreKeys.lastName) }
        set { storage.set(newValue, forKey: UserInfoStoreKeys.lastName) }
    }
    
    var gender: String? {
        get { storage.get(forKey: UserInfoStoreKeys.gender) }
        set { storage.set(newValue, forKey: UserInfoStoreKeys.gender) }
    }
    
    var image: String? {
        get { storage.get(forKey: UserInfoStoreKeys.image) }
        set { storage.set(newValue, forKey: UserInfoStoreKeys.image) }
    }
    
    func clearAll() {
        storage.clearAll()
    }
}
