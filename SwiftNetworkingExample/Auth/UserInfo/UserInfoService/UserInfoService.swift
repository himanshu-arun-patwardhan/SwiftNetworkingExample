//
//  UserInfoService.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import Foundation
import Combine
import SwiftNetworking
import SwiftLogger

@MainActor
class UserInfoService: ObservableObject {
    @Published var networkRequestState: NetworkRequestState<Void> = .idle
    @Published var responseData: UserInfoServiceResponseModel? = nil
    ///
    private var userInfoStore: UserInfoStoreProtocol = UserInfoStore.shared
    
    // MARK: -
    private var networkService: NetworkRequestProtocol
    init(networkService: NetworkRequestProtocol = NetworkRequestManager()) {
        self.networkService = networkService
    }
    
    // MARK: -
    func requestUserInfo() async {
        networkRequestState = .loading
        /// url
        guard let url = URL(string: "https://dummyjson.com/auth/me") else {
            Logger.log("Invalid URL", level: .error, category: .network)
            return
        }
        /// header
        guard let token = TokenStore.shared.accessToken else {
            Logger.log("token not found", level: .error, category: .network)
            return
        }
        let headers = NetworkConstants.authorizedHeaders(token: token)
        /// request
        do {
            let response = try await networkService.request(
                UserInfoServiceResponseModel.self,
                url: url,
                method: .GET,
                headers: headers,
                body: nil
            )
            self.responseData = response
            saveUserInfo(from: response)
            self.networkRequestState = .success(())
        } catch {
            self.networkRequestState = .failure(error)
        }
    }
    
    private func saveUserInfo(from response: UserInfoServiceResponseModel) {
        userInfoStore.userId = response.id
        userInfoStore.username = response.username
        userInfoStore.email = response.email
        userInfoStore.firstName = response.firstName
        userInfoStore.lastName = response.lastName
        userInfoStore.gender = response.gender
        userInfoStore.image = response.image
    }
}
