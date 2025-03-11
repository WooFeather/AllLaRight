//
//  InfoPopupViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import UIKit
import RxSwift
import RxCocoa

final class InfoPopupViewController: BaseViewController {
    
    let infoPopupView = InfoPopupView()
    private let disposeBag = DisposeBag()
    let viewModel = InfoPopupViewModel()
    
    override func bind() {
        let input = InfoPopupViewModel.Input(
            retryButtonTapped: infoPopupView.retryButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.errorMessage
            .drive(infoPopupView.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.retryButtonTapped
            .drive(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func loadView() {
        view = infoPopupView
    }
    
    override func configureView() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
}
