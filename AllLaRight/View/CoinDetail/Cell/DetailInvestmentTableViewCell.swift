//
//  DetailInvestmentTableViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class DetailInvestmentTableViewCell: BaseTableViewCell {
    var disposeBag = DisposeBag()
    let headerView = DetailSectionHeader(title: "투자지표")
    private let roundedBackgroundView = UIView()
    private let marketCapView = InfoTwoLineView()
    private let fdvView = InfoTwoLineView()
    private let totalVolumeView = InfoTwoLineView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureHierarchy() {
        contentView.addSubview(headerView)
        contentView.addSubview(roundedBackgroundView)
        [marketCapView, fdvView, totalVolumeView].forEach {
            roundedBackgroundView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        roundedBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(12)
            make.height.greaterThanOrEqualTo(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        marketCapView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
        fdvView.snp.makeConstraints { make in
            make.top.equalTo(marketCapView.snp.bottom).offset(16)
            make.leading.equalTo(marketCapView.snp.leading)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
        totalVolumeView.snp.makeConstraints { make in
            make.top.equalTo(fdvView.snp.bottom).offset(16)
            make.leading.equalTo(fdvView.snp.leading)
            make.height.equalTo(40)
            make.width.equalTo(200)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    override func configureView() {
        roundedBackgroundView.backgroundColor = .backgroundSecondary
        roundedBackgroundView.layer.cornerRadius = 10
        roundedBackgroundView.clipsToBounds = true
        
        marketCapView.upperLabel.text = "시가총액"
        fdvView.upperLabel.text = "완전 희석 가치(FDV)"
        totalVolumeView.upperLabel.text = "총 거래량"
    }
    
    func configureData(data: DetailData) {
        marketCapView.valueLabel.text = data.marketCap.toWonString()
        fdvView.valueLabel.text = data.fullyDilutedValuation?.toWonString()
        totalVolumeView.valueLabel.text = data.totalVolume.toWonString()
    }
}
