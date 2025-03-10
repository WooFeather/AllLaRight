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
    let viewModel = CoinDetailViewModel()
    
    override func bind() {
        let input = CoinDetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        Driver.zip(output.imageUrl, output.symbolText)
            .drive(with: self) { owner, value in
                let urlString = value.0
                owner.coinDetailView.navigationView.iconImageView.kf.setImage(with: URL(string: urlString))
                
                owner.coinDetailView.navigationView.symbolLabel.text = value.1
            }
            .disposed(by: DisposeBag())
    }
    
    // TODO: ViewModel로 이동
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func bookmarkButtonTapped() {
        print("bookmarkButtonTapped")
    }
    
    // MARK: - ConfigureView
    override func loadView() {
        view = coinDetailView
    }
}
