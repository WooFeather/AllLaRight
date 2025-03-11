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
    
    private let infoPopupView = InfoPopupView()
    private let viewModel = InfoPopupViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = infoPopupView
    }
    
    override func configureView() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
}
