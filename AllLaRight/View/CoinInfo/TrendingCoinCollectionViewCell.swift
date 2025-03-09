//
//  HotKeywordCollectionViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import UIKit
import SnapKit
import Kingfisher

final class TrendingCoinCollectionViewCell: BaseCollectionViewCell {
    private let rankScoreLabel = UILabel()
    private let symbolImageView = UIImageView()
    private let symbolLabel = UILabel()
    private let nameLabel = UILabel()
    private let changePercentageView = ChangePercentageView()
    
    override func configureHierarchy() {
        [rankScoreLabel, symbolImageView, symbolLabel, nameLabel, changePercentageView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        rankScoreLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(15)
        }
        
        symbolImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(rankScoreLabel.snp.trailing).offset(8)
            make.size.equalTo(26)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(symbolImageView.snp.trailing).offset(4)
            make.height.equalTo(15)
            make.trailing.equalTo(changePercentageView.snp.leading)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolLabel.snp.bottom)
            make.leading.equalTo(symbolImageView.snp.trailing).offset(4)
            make.height.equalTo(12)
            make.width.equalTo(60)
        }
        
        changePercentageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(12)
            make.trailing.equalToSuperview()
        }
    }
    
    override func configureView() {
        rankScoreLabel.font = ALRFont.headline.font
        rankScoreLabel.textColor = .themePrimary
        rankScoreLabel.textAlignment = .right
        
        DispatchQueue.main.async { [weak self] in
            self?.symbolImageView.layer.cornerRadius = (self?.symbolImageView.frame.height ?? 0) / 2
        }
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.clipsToBounds = true
        
        symbolLabel.font = ALRFont.headlineBold.font
        symbolLabel.textColor = .themePrimary
        symbolLabel.textAlignment = .left
        
        nameLabel.font = ALRFont.body.font
        nameLabel.textColor = .themeSecondary
        nameLabel.textAlignment = .left
    }
    
    func configureData(data: TrendingCoinDetails) {
        rankScoreLabel.text = "\(data.score + 1)"
        
        let urlString = data.thumb
        symbolImageView.kf.setImage(with: URL(string: urlString))
        
        symbolLabel.text = data.symbol
        nameLabel.text = data.name
        
        // 등락뷰 세팅
        guard let changeRate = data.data.priceChangePercentage24h["krw"] else { return }
        
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
