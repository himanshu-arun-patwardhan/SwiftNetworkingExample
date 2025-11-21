//
//  LoginViewModel.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import Foundation
import Combine
import SwiftNetworking
import SwiftLogger

@MainActor
class LoginViewModel: ObservableObject {
    @Published var networkRequestState: NetworkRequestState<LoginResponseModel> = .idle
    @Published var loggedInUserInfo: LoginResponseModel? = nil
    private var tokenStore: TokenStoreProtocol = TokenStore.shared
    
    // MARK: - init
    private var networkService: NetworkRequestProtocol
    init(networkService: NetworkRequestProtocol = NetworkRequestManager()) {
        self.networkService = networkService
    }
    
    
    // MARK: - network request
    func requestLogin(username: String, password: String) async {
        self.networkRequestState = .loading
        /// url
        guard let url = URL(string: "https://dummyjson.com/auth/login") else {
            Logger.log("Invalid URL", level: .error, category: .network)
            return
        }
        /// body
        let requestBody = LoginRequestBodyModel(
            username: username,
            password: password,
            expiresInMins: 30
        )
        /// header
        let headers = NetworkConstants.defaultHeader()
        /// request
        do {
            let bodyData = try JSONEncoder().encode(requestBody)
            let response = try await networkService.request(
                LoginResponseModel.self,
                url: url,
                method: .POST,
                headers: headers,
                body: bodyData
            )
            self.networkRequestState = .success(response)
            loggedInUserInfo = response
            saveTokens(accessToken: response.accessToken, refreshToken: response.refreshToken)
        } catch {
            self.networkRequestState = .failure(error)
        }
    }
    
    private func saveTokens(accessToken: String, refreshToken: String) {
        tokenStore.accessToken = accessToken
        tokenStore.refreshToken = refreshToken
    }
}
