//
//  MarketTableViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import UIKit
import SnapKit

final class MarketTableViewCell: BaseTableViewCell {
    let coinNameLabel = UILabel()
    let currentPriceLabel = UILabel()
    let changeRateLabel = UILabel()
    let changePriceLabel = UILabel()
    let tradePriceLabel = UILabel()
    
    override func configureHierarchy() {
        [coinNameLabel, currentPriceLabel, changeRateLabel, changePriceLabel, tradePriceLabel].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        coinNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(15)
        }
        
        tradePriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(15)
            make.width.equalTo(70)
        }
        
        changeRateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalTo(tradePriceLabel.snp.leading).offset(-30)
            make.height.equalTo(15)
            make.width.equalTo(50)
        }
        
        changePriceLabel.snp.makeConstraints { make in
            make.top.equalTo(changeRateLabel.snp.bottom).offset(4)
            make.centerX.equalTo(changeRateLabel.snp.centerX)
            make.width.equalTo(50)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        currentPriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalTo(changeRateLabel.snp.leading).offset(-24)
            make.height.equalTo(15)
        }
    }
    
    override func configureView() {
        coinNameLabel.font = ALRFont.headlineBold.font
        coinNameLabel.textColor = .themePrimary
        
        tradePriceLabel.font = ALRFont.headline.font
        tradePriceLabel.textColor = .themePrimary
        tradePriceLabel.textAlignment = .right
        
        // TODO: 값에 따라 textColor 분기처리
        changeRateLabel.font = ALRFont.headline.font
        changeRateLabel.textColor = .chartRise
        changeRateLabel.textAlignment = .right
        
        changePriceLabel.font = ALRFont.body.font
        changePriceLabel.textColor = .chartRise
        changePriceLabel.textAlignment = .right
        
        currentPriceLabel.font = ALRFont.headline.font
        currentPriceLabel.textColor = .themePrimary
    }
    
    func configureData(data: UpbitMarket) {
        
        // TODO: 반올림하는 코드 extension으로 빼기
        let digit: Double = pow(10, 2)
        let changeRate = round(data.changeRate * digit) / digit
        
        coinNameLabel.text = data.coinName
        currentPriceLabel.text = data.currentPrice.formatted()
        changeRateLabel.text = "\(changeRate)%"
        changePriceLabel.text = data.changePrice.formatted()
        
        // TODO: 금액에 따른 표기방법 변경
        tradePriceLabel.text = data.tradePrice.formatted()
    }
}
