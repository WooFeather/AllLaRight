//
//  InfoPopupViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class InfoPopupViewController: UIViewController {
    
    let infoPopupView = InfoPopupView()
    let viewModel = InfoPopupViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        configureView()
    }
    
    func bind() {
        let input = InfoPopupViewModel.Input(
            retryButtonTapped: infoPopupView.retryButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.errorMessage
            .drive(infoPopupView.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.retryButtonTapped
            .drive(with: self) { owner, _ in
                if NetworkMonitor.shared.isConnected {
                    owner.dismiss(animated: true)
                } else {
                    owner.infoPopupView.makeToast("네트워크 통신이 원활하지 않습니다")
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func loadView() {
        view = infoPopupView
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
}
