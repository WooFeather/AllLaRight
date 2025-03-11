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
import RxDataSources
import Toast

final class CoinDetailViewController: BaseViewController {
    
    private let coinDetailView = CoinDetailView()
    private let disposeBag = DisposeBag()
    let viewModel = CoinDetailViewModel()
    
    override func bind() {
        let input = CoinDetailViewModel.Input(
            viewWillAppear: rx.viewWillAppear,
            backButtonTapped: coinDetailView.navigationView.backButton.rx.tap,
            starButtonTapped: coinDetailView.navigationView.starButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        LoadingIndicator.showLoading()
        
        let dataSource = RxTableViewSectionedReloadDataSource<CoinDetailSectionModel> { dataSource, tableView, indexPath, item in
            
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.DetailChartTableViewCell.rawValue, for: indexPath) as? DetailChartTableViewCell else { return UITableViewCell() }
                
                LoadingIndicator.hideLoading()
                
                cell.configureData(data: item)
                
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.DetailPriceTableViewCell.rawValue, for: indexPath) as? DetailPriceTableViewCell else { return UITableViewCell() }
                
                LoadingIndicator.hideLoading()
                
                cell.configureData(data: item)
                cell.headerView.moreButton.rx.tap
                    .asDriver()
                    .drive(with: self) { owner, _ in
                        owner.view.makeToast("준비 중입니다", duration: 1.0)
                    }
                    .disposed(by: cell.disposeBag)
                
                return cell
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.DetailInvestmentTableViewCell.rawValue, for: indexPath) as? DetailInvestmentTableViewCell else { return UITableViewCell() }
                
                LoadingIndicator.hideLoading()
                
                cell.configureData(data: item)
                cell.headerView.moreButton.rx.tap
                    .asDriver()
                    .drive(with: self) { owner, _ in
                        owner.view.makeToast("준비 중입니다", duration: 1.0)
                    }
                    .disposed(by: cell.disposeBag)
                
                return cell
            default:
                return UITableViewCell()
            }
        }
        
        output.detailInfoData
            .drive(coinDetailView.detailTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
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
        
        output.isStared
            .drive(with: self) { owner, isStared in
                if isStared { // 추가돼있는 상태
                    owner.coinDetailView.navigationView.starButton.isSelected = true
                    owner.view.makeToast("\(owner.viewModel.symbolText.value)이(가) 즐겨찾기에 추가되었습니다.")
                } else { // 없는상태
                    owner.coinDetailView.navigationView.starButton.isSelected = false
                    owner.view.makeToast("\(owner.viewModel.symbolText.value)이(가) 즐겨찾기에서 제거되었습니다.")
                    
                }
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .drive(with: self) { owner, value in
                LoadingIndicator.hideLoading()
                
                owner.showAlert(title: "오류발생", message: value, button: "확인") {
                    owner.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - ConfigureView
    override func loadView() {
        view = coinDetailView
    }
    
    override func configureData() {
        coinDetailView.detailTableView.register(DetailChartTableViewCell.self, forCellReuseIdentifier: Identifier.DetailChartTableViewCell.rawValue)
        
        coinDetailView.detailTableView.register(DetailPriceTableViewCell.self, forCellReuseIdentifier: Identifier.DetailPriceTableViewCell.rawValue)
        
        coinDetailView.detailTableView.register(DetailInvestmentTableViewCell.self, forCellReuseIdentifier: Identifier.DetailInvestmentTableViewCell.rawValue)
    }
}
