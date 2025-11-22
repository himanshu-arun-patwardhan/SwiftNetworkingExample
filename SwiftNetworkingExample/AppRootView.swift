//
//  AppRootView.swift
//  SwiftNetworkingExample
//
//  Created by Himanshu Patwardhan
//

import SwiftUI
import SwiftLogger
import SwiftUIComponents

struct AppRootView: View {
    /// global overlay view
    @StateObject private var overlayManager = OverlayViewManager.shared
    
    // MARK: -
    var body: some View {
        ZStack {
            LoginUIView()
            /// global overlay view
            if let overlay = overlayManager.currentOverlay {
                overlay
                    .transition(.opacity)
                    .zIndex(999)
            }
            /// global banner view on top of all views
            BannerView()
        }
    }
}
