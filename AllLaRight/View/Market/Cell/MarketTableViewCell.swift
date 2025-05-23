//
//  MarketTableViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import UIKit
import SnapKit

final class MarketTableViewCell: BaseTableViewCell {
    private let coinNameLabel = UILabel()
    private let currentPriceLabel = UILabel()
    private let changeRateLabel = UILabel()
    private let changePriceLabel = UILabel()
    private let tradePriceLabel = UILabel()
    
    override func configureHierarchy() {
        [coinNameLabel, currentPriceLabel, changeRateLabel, changePriceLabel, tradePriceLabel].forEach {
            contentView.addSubview($0)
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
            make.width.equalTo(80)
        }
        
        changeRateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalTo(tradePriceLabel.snp.leading).offset(-20)
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
        coinNameLabel.textColor = .textPrimary
        coinNameLabel.textAlignment = .left
        
        tradePriceLabel.font = ALRFont.headline.font
        tradePriceLabel.textColor = .textPrimary
        
        changeRateLabel.font = ALRFont.headline.font
        
        changePriceLabel.font = ALRFont.body.font
        
        currentPriceLabel.font = ALRFont.headline.font
        currentPriceLabel.textColor = .textPrimary
        
        [tradePriceLabel, changeRateLabel, changePriceLabel, currentPriceLabel].forEach {
            $0.textAlignment = .right
        }
    }
    
    func configureData(data: MarketData) {
        
        coinNameLabel.text = data.coinName.reversedJoin()
        currentPriceLabel.text = data.currentPrice.toPriceString()

        changeRateLabel.text = data.changeRate.toPercentString()
        changePriceLabel.text = data.changePrice.formatted()
        
        [changeRateLabel, changePriceLabel].forEach {
            if data.change == "EVEN" {
                $0.textColor = .textPrimary
            } else if data.change == "RISE" {
                $0.textColor = .chartRise
            } else {
                $0.textColor = .chartFall
            }
        }
        
        if (data.tradePrice24) > 1000000 {
            tradePriceLabel.text = data.tradePrice24.toMillionString()
        } else {
            tradePriceLabel.text = data.tradePrice24.formatted()
        }
    }
}
