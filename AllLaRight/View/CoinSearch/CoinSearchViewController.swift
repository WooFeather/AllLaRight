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
    private let disposeBag = DisposeBag()
    let viewModel = CoinSearchViewModel()
    
    override func loadView() {
        view = coinSearchView
    }
    
    override func bind() {
        let input = CoinSearchViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.queryText
            .drive(with: self) { owner, text in
                owner.coinSearchView.navigationView.searchTextField.text = text
            }
            .disposed(by: disposeBag)
    }
    
    // TODO: ViewModel로 이동
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func configureAction() {
        coinSearchView.navigationView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
}
