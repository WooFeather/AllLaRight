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
            make.leading.equalTo(coinNameLabel.snp.trailing)
            make.height.equalTo(15)
        }
    }
    
    override func configureView() {
        coinNameLabel.font = ALRFont.headlineBold.font
        coinNameLabel.textColor = .themePrimary
        coinNameLabel.textAlignment = .left
        
        tradePriceLabel.font = ALRFont.headline.font
        tradePriceLabel.textColor = .themePrimary
        
        changeRateLabel.font = ALRFont.headline.font
        
        changePriceLabel.font = ALRFont.body.font
        
        currentPriceLabel.font = ALRFont.headline.font
        currentPriceLabel.textColor = .themePrimary
        
        [tradePriceLabel, changeRateLabel, changePriceLabel, currentPriceLabel].forEach {
            $0.textAlignment = .right
        }
    }
    
    func configureData(data: MarketData) {
        
        // TODO: 코인 이름 명세에 나와있는 이름으로 변경
        coinNameLabel.text = data.coinName
        // TODO: 현재가 표기방식도 변경(명세 참고)
        currentPriceLabel.text = data.currentPrice.formatted()
        
        changeRateLabel.text = data.changeRate.toFormattedString() + "%"
        changePriceLabel.text = data.changePrice.formatted()
        
        [changeRateLabel, changePriceLabel].forEach {
            if data.change == "EVEN" {
                $0.textColor = .themePrimary
            } else if data.change == "RISE" {
                $0.textColor = .chartRise
            } else {
                $0.textColor = .chartFall
            }
        }
        
        // TODO: 금액에 따른 표기방법 변경
        tradePriceLabel.text = data.tradePrice.formatted()
    }
}
