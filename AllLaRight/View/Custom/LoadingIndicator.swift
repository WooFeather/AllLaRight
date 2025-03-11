//
//  LoadingIndicator.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import UIKit

class LoadingIndicator {
    static func showLoading() {
        DispatchQueue.main.async {
            
            let scenes = UIApplication.shared.connectedScenes
            guard let windowScene = scenes.first as? UIWindowScene,
                  let window = windowScene.windows.first
            else { return }

            let loadingIndicatorView: UIActivityIndicatorView
            if let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView {
                loadingIndicatorView = existedView
            } else {
                loadingIndicatorView = UIActivityIndicatorView(style: .large)
                loadingIndicatorView.frame = window.frame
                loadingIndicatorView.color = .themePrimary
                window.addSubview(loadingIndicatorView)
            }

            loadingIndicatorView.startAnimating()
        }
    }

    static func hideLoading() {
        DispatchQueue.main.async {
            let scenes = UIApplication.shared.connectedScenes
            guard let windowScene = scenes.first as? UIWindowScene,
                  let window = windowScene.windows.first
            else { return }
            
            window.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
        }
    }
}
