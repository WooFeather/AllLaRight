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
        let input = CoinSearchViewModel.Input(
            backButtonTapped: coinSearchView.navigationView.backButton.rx.tap,
            textFieldReturnTapped: coinSearchView.navigationView.searchTextField.rx.controlEvent(.editingDidEndOnExit),
            textFieldText: coinSearchView.navigationView.searchTextField.rx.text.orEmpty
        )
        let output = viewModel.transform(input: input)
        
        output.queryText
            .drive(with: self) { owner, text in
                owner.coinSearchView.navigationView.searchTextField.text = text
            }
            .disposed(by: disposeBag)
        
        output.searchData
            .drive(coinSearchView.searchTableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) { row, element, cell in
                
                cell.configureData(data: element)
            }
            .disposed(by: disposeBag)
        
        // TODO: Error반환시 AlertView 띄우기
        // output.errorMessage
        
        output.backButtonTapped
            .drive(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureData() {
        coinSearchView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
}
