//
//  SearchViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa

// TODO: TapPageController 구현
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
            textFieldText: coinSearchView.navigationView.searchTextField.rx.text.orEmpty,
            modelSelected: coinSearchView.searchTableView.rx.modelSelected(CoinData.self)
        )
        let output = viewModel.transform(input: input)
        
        output.queryText
            .drive(with: self) { owner, text in
                owner.coinSearchView.navigationView.searchTextField.text = text
            }
            .disposed(by: disposeBag)
        
        output.searchData
            .drive(coinSearchView.searchTableView.rx.items(cellIdentifier: Identifier.SearchTableViewCell.rawValue, cellType: SearchTableViewCell.self)) { row, element, cell in
                
                cell.configureData(data: element)
                
                // TODO: 즐겨찾기 로직 수정
                cell.starButton.rx.tap
                    .asDriver()
                    .drive(with: self) { owner, _ in
                        print(element.id, "starButtonTapped")
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        // TODO: Error반환시 AlertView 띄우기
        // output.errorMessage
        
        output.modelSelected
            .drive(with: self) { owner, data in
                print(data.id)
                
                let vc = CoinDetailViewController()
                vc.viewModel.id.accept(data.id)
                vc.viewModel.imageUrl.accept(data.large)
                vc.viewModel.symbolText.accept(data.symbol)
                
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.backButtonTapped
            .drive(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureData() {
        coinSearchView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: Identifier.SearchTableViewCell.rawValue)
    }
}
