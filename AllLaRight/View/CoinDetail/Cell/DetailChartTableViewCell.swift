//
//  DetailChartTableViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import UIKit
import SnapKit

final class DetailChartTableViewCell: BaseTableViewCell {
    private let currentPriceLabel = UILabel()
    private let changePercentageView = ChangePercentageView()
    private let chartView = UIView() // TODO: Chart작업
    private let updateLabel = UILabel()
    
    override func configureHierarchy() {
        [currentPriceLabel, changePercentageView, chartView, updateLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        currentPriceLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.height.equalTo(24)
        }
        
        changePercentageView.snp.makeConstraints { make in
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(4)
            make.leading.equalTo(currentPriceLabel.snp.leading)
            make.height.equalTo(12)
            make.width.greaterThanOrEqualTo(20)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(changePercentageView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(updateLabel.snp.top).offset(-4)
        }
        
        updateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(12)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        currentPriceLabel.font = .boldSystemFont(ofSize: 21)
        currentPriceLabel.textColor = .themePrimary
        
        chartView.backgroundColor = .chartFall
        
        updateLabel.font = ALRFont.body.font
        updateLabel.textColor = .themeSecondary
    }
    
    func configureData(data: DetailData) {
        currentPriceLabel.text = data.currentPrice.toWonString()
        
        updateLabel.text = data.lastUpdated.toDate()?.toString(dateFormat: "M/d HH:mm:ss 업데이트")
        
        // 등락뷰 세팅
        guard let changeRate = data.priceChangePercentage24h else {
            changePercentageView.iconImageView.image = UIImage()
            changePercentageView.changeRateLabel.text = ""
            return
        }
        
        let riseIcon = UIImage(systemName: "arrowtriangle.up.fill")
        let fallIcon = UIImage(systemName: "arrowtriangle.down.fill")
        
        changePercentageView.changeRateLabel.text = changeRate.toABSString()
        
        if changeRate > 0 {
            changePercentageView.iconImageView.image = riseIcon
            changePercentageView.iconImageView.tintColor = .chartRise
            changePercentageView.changeRateLabel.textColor = .chartRise
        } else if changeRate < 0 {
            changePercentageView.iconImageView.image = fallIcon
            changePercentageView.iconImageView.tintColor = .chartFall
            changePercentageView.changeRateLabel.textColor = .chartFall
        } else {
            changePercentageView.iconImageView.image = UIImage()
            changePercentageView.iconImageView.tintColor = .themePrimary
            changePercentageView.changeRateLabel.textColor = .themePrimary
        }
    }
}
