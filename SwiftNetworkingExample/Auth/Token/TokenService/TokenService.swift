//
//  TokenService.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import Foundation
import Combine
import SwiftNetworking
import SwiftLogger

@MainActor
class TokenService: ObservableObject {
    @Published var networkRequestState: NetworkRequestState<Void> = .idle
    @Published var responseData: TokenServiceResponseModel? = nil
    ///
    private var tokenStore: TokenStoreProtocol = TokenStore.shared
    
    // MARK: - init
    private var networkService: NetworkRequestProtocol
    init(networkService: NetworkRequestProtocol = NetworkRequestManager()) {
        self.networkService = networkService
    }
    
    // MARK: -
    func requestToken() async {
        networkRequestState = .loading
        /// url
        guard let url = URL(string: "https://dummyjson.com/auth/refresh") else {
            Logger.log("Invalid URL", level: .error, category: .network)
            return
        }
        /// body
        guard let refreshToken = TokenStore.shared.refreshToken else {
            Logger.log("token not found", level: .error, category: .network)
            return
        }
        let requestBody = TokenServiceRequestBodyModel(
            refreshToken: refreshToken,
            expiresInMins: 30
        )
        /// header
        let header = NetworkConstants.defaultHeader()
        /// request
        do {
            let bodyData = try JSONEncoder().encode(requestBody)
            let response = try await networkService.request(
                TokenServiceResponseModel.self,
                url: url,
                method: .POST,
                headers: header,
                body: bodyData
            )
            self.responseData = response
            saveTokens(from: response)
            self.networkRequestState = .success(())
        } catch {
            self.networkRequestState = .failure(error)
        }
    }
    
    private func saveTokens(from response: TokenServiceResponseModel) {
        tokenStore.accessToken = response.accessToken
        tokenStore.refreshToken = response.refreshToken
    }
}
