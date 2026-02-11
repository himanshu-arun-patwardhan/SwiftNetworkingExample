//
//  LoginUIView.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import SwiftUI
import SwiftUIComponents
import SwiftLogger
import SwiftNetworking

struct LoginUIView: View {
    ///
    @State var usernameText: String = "emilys"
    @FocusState private var isUsernameTextFieldFocused: Bool
    ///
    @State var passwordText: String = "emilyspass"
    @FocusState private var isPasswordTextFieldFocused: Bool
    ///
    @StateObject var viewModelLogin = LoginViewModel()
    @StateObject var serviceToken = TokenService()
    @StateObject var serviceUserInfo = UserInfoService()
    
    // MARK: -
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                ZStack {
                    VStack(spacing: 20) {
                        ///
                        Text("Login")
                            .font(.system(size: 25, weight: .bold))
                            .frame(height: 60)
                        ///
                        usernameTextFieldView(proxy: proxy)
                        passwordTextFieldView(proxy: proxy)
                        ///
                        actionButtonsView()
                    }
                    ///
                    switch viewModelLogin.networkRequestState {
                    case .idle:
                        let _ = Logger.log("Idle state", level: .debug, category: .network)
                    case .loading:
                        let _ = Logger.log("Loading state", level: .debug, category: .network)
                        let _ = OverlayViewManager.shared.show(LoadingView())
                    case .success(_):
                        let _ = Logger.log("Success state", level: .info, category: .network)
                        let _ = DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            let _ = OverlayViewManager.shared.dismiss()
                            let _ = BannerManager.shared.showBanner(having: BannerData(type: .success,
                                                                                       title: "Success",
                                                                                       subtitle: "user logged-in successfully.",
                                                                                       duration: 8.0))
                        }
                    case .failure(let error):
                        let _ = Logger.log("Error state", level: .error, category: .network)
                        let _ = Task(operation: {
                            try? await Task.sleep(nanoseconds: 1_000_000_000 * 2) // 2 seconds
                            let _ = OverlayViewManager.shared.dismiss()
                            let _ = BannerManager.shared.showBanner(having: BannerData(type: .error,
                                                                                       title: "Error",
                                                                                       subtitle: "username or password is incorrect.",
                                                                                       duration: 8.0))
                        })
                    }
                }
            }
        }
    }
}

// MARK: -
extension LoginUIView {
    func usernameTextFieldView(proxy: ScrollViewProxy) -> some View {
        InputFieldView(
            text: $usernameText,
            placeholder: "username",
            leftIcon: "person.circle.fill",
            rightButtonTitle: nil,
            onRightButtonTap: nil,
            characterLimit: 15,
            onTextChange: { input in
                Logger.log("on text change", level: .debug, category: .general)
                return true
            },
            returnKeyType: .done,
            onReturn: {
                Logger.log("return tapped", level: .debug, category: .general)
            },
            isFocused: $isUsernameTextFieldFocused,
            font: .system(size: 22, design: .monospaced),
            width: nil,
            height: 60
        )
        //        .onAppear {
        //            /// keyboard auto-focus on load
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        //                isUsernameTextFieldFocused = true
        //            }
        //        }
    }
    
    func passwordTextFieldView(proxy: ScrollViewProxy) -> some View {
        InputFieldView(
            text: $passwordText,
            placeholder: "password",
            leftIcon: "key.circle.fill",
            rightButtonTitle: nil,
            onRightButtonTap: nil,
            characterLimit: 15,
            onTextChange: { input in
                Logger.log("on text change", level: .debug, category: .general)
                return true
            },
            returnKeyType: .done,
            onReturn: {
                Logger.log("return tapped", level: .debug, category: .general)
            },
            isFocused: $isPasswordTextFieldFocused,
            font: .system(size: 22, design: .monospaced),
            width: nil,
            height: 60
        )
    }
}

// MARK: -
extension LoginUIView {
    func actionButtonsView() -> some View {
        HStack(spacing: 10) {
            StyledButton(
                title: "Login",
                titleColor: .black,
                backgroundColor: Color(red: 212/255, green: 204/255, blue: 188/255),
                cornerRadius: 10,
                font: .system(.title2, design: .serif, weight: .bold),
                frameWidth: nil,
                frameHeight: 40,
                borderColor: .clear,
                borderWidth: 0
            ) {
                if usernameText.isEmpty || passwordText.isEmpty {
                    let _ = BannerManager.shared.showBanner(having: BannerData(type: .warning,
                                                                               title: "Oops..",
                                                                               subtitle: "username or password can not be empty.",
                                                                               duration: 5.0))
                } else {
                    Task {
                        await viewModelLogin.requestLogin(username: usernameText, password: passwordText)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20)
    }
}
