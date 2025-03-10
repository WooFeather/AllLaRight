//
//  CoinDetailViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

final class CoinDetailViewController: BaseViewController {
    
    private let coinDetailView = CoinDetailView()
    private let disposeBag = DisposeBag()
    let viewModel = CoinDetailViewModel()
    
    override func bind() {
        let input = CoinDetailViewModel.Input(
            backButtonTapped: coinDetailView.navigationView.backButton.rx.tap,
            starButtonTapped: coinDetailView.navigationView.starButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        Driver.zip(output.imageUrl, output.symbolText)
            .drive(with: self) { owner, value in
                let urlString = value.0
                owner.coinDetailView.navigationView.iconImageView.kf.setImage(with: URL(string: urlString))
                
                owner.coinDetailView.navigationView.symbolLabel.text = value.1
            }
            .disposed(by: disposeBag)
        
        output.backButtonTapped
            .drive(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        // TODO: 즐겨찾기 로직 수정
        output.starButtonTapped
            .drive(with: self) { owner, _ in
                print(owner.viewModel.id.value, "starButtonTapped")
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - ConfigureView
    override func loadView() {
        view = coinDetailView
    }
}
