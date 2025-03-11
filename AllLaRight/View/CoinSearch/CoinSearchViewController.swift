//
//  SearchViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class CoinSearchViewController: BaseViewController {
    private let coinSearchView = CoinSearchView()
    private let disposeBag = DisposeBag()
    
    private let repository: StarItemRepository = StarItemTableRepository()
    
    let viewModel = CoinSearchViewModel()
    
    override func loadView() {
        view = coinSearchView
    }
    
    override func bind() {
        let input = CoinSearchViewModel.Input(
            viewWillAppear: rx.viewWillAppear,
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
            .drive(coinSearchView.searchTableView.rx.items(cellIdentifier: Identifier.SearchTableViewCell.rawValue, cellType: SearchTableViewCell.self)) { [weak self] row, element, cell in
                
                guard let self = self else { return }
                
                cell.configureData(data: element)
                
                let data = Array(self.repository.fetchAll())
                
                let existingData = data.filter {
                    $0.id == element.id
                }
                
                if existingData.count > 0 {
                    cell.starButton.isSelected = true
                } else {
                    cell.starButton.isSelected = false
                }
                
                cell.starButton.rx.tap
                    .asDriver()
                    .drive(with: self) { owner, _ in
                        print(element.id, "starButtonTapped")
                        
                        let data = Array(owner.repository.fetchAll())
                        
                        let existingData = data.filter {
                            $0.id == element.id
                        }
                        
                        if existingData.count > 0 {
                            owner.repository.deleteItem(data: existingData.first ?? existingData[0])
                            cell.starButton.isSelected = false
                            owner.view.makeToast("\(element.name)이(가) 즐겨찾기에서 제거되었습니다.")
                        } else {
                            owner.repository.createItem(id: element.id)
                            cell.starButton.isSelected = true
                            owner.view.makeToast("\(element.name)이(가) 즐겨찾기에 추가되었습니다.")
                        }
                        
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        output.viewWillAppear
            .drive(with: self) { owner, _ in
                owner.coinSearchView.searchTableView.reloadData()
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
    
    // TODO: PageControl VM으로 이동 및 스와이프 기능 추가
    @objc private func didChangeValue(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 1:
            coinSearchView.showSecondView = true
        case 2:
            coinSearchView.showThirdView = true
        default:
            coinSearchView.showFirstView = true
        }
    }
    
    override func configureData() {
        coinSearchView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: Identifier.SearchTableViewCell.rawValue)
    }
    
    override func configureAction() {
        coinSearchView.segmentControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        coinSearchView.segmentControl.selectedSegmentIndex = 0
        didChangeValue(segment: coinSearchView.segmentControl)
    }
}
