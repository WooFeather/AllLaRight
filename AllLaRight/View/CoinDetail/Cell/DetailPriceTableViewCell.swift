//
//  DetailPriceTableViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import UIKit
import SnapKit

final class DetailPriceTableViewCell: BaseTableViewCell {
    let headerView = DetailSectionHeader(title: "종목정보")
    private let roundedBackgroundView = UIView()
    private let high24hView = InfoTwoLineView()
    private let low24hView = InfoTwoLineView()
    private let athView = InfoThreeLineView()
    private let atlView = InfoThreeLineView()
    
    override func configureHierarchy() {
        contentView.addSubview(headerView)
        contentView.addSubview(roundedBackgroundView)
        [high24hView, low24hView, athView, atlView].forEach {
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
        
        high24hView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.height.greaterThanOrEqualTo(20)
            make.width.equalTo(120)
        }
        
        low24hView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.height.greaterThanOrEqualTo(20)
            make.width.equalTo(120)
            make.trailing.equalToSuperview().offset(-60)
        }
        
        athView.snp.makeConstraints { make in
            make.top.equalTo(high24hView.snp.bottom).offset(44)
            make.leading.equalTo(high24hView.snp.leading)
            make.height.greaterThanOrEqualTo(20)
            make.width.equalTo(120)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        atlView.snp.makeConstraints { make in
            make.top.equalTo(low24hView.snp.bottom).offset(44)
            make.height.greaterThanOrEqualTo(20)
            make.width.equalTo(120)
            make.trailing.equalToSuperview().offset(-60)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    override func configureView() {
        roundedBackgroundView.backgroundColor = .themeTertiary
        roundedBackgroundView.layer.cornerRadius = 10
        roundedBackgroundView.clipsToBounds = true
        
        high24hView.upperLabel.text = "24시간 고가"
        low24hView.upperLabel.text = "24시간 저가"
        athView.upperLabel.text = "역대 최고가"
        atlView.upperLabel.text = "역대 최저가"
    }
    
    func configureData(data: DetailData) {
        high24hView.valueLabel.text = data.high24h?.toWonString()
        low24hView.valueLabel.text = data.low24h?.toWonString()
        athView.valueLabel.text = data.ath.toWonString()
        atlView.valueLabel.text = data.atl.toWonString()
        
        athView.lowerLabel.text = data.athDate.toDate()?.toString(dateFormat: "yy년 M월 d일")
        atlView.lowerLabel.text = data.atlDate.toDate()?.toString(dateFormat: "yy년 M월 d일")
    }
}
