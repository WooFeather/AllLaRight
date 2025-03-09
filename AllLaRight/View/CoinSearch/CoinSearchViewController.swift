//
//  SearchViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa

final class CoinSearchViewController: BaseViewController {
    private let coinSearchView = CoinSearchView()
    var textFieldContents: String?
    
    override func loadView() {
        view = coinSearchView
    }
    
    // TODO: ViewModel로 이동
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func configureAction() {
        coinSearchView.navigationView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    override func configureView() {
        super.configureView()
        coinSearchView.navigationView.searchTextField.text = textFieldContents
    }
}
