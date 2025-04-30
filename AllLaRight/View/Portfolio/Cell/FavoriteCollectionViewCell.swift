//
//  FavoriteCollectionViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 4/30/25.
//

import UIKit
import SnapKit
import Kingfisher

final class FavoriteCollectionViewCell: BaseCollectionViewCell {
    private let roundedBackgroundView = UIView()
    private let symbolImageView = UIImageView()
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let currentPriceLabel = UILabel()
    private let changePercentageView = ChangePercentageView()
    
    override func configureHierarchy() {
        contentView.addSubview(roundedBackgroundView)
        [symbolImageView, nameLabel, symbolLabel, currentPriceLabel, changePercentageView].forEach {
            roundedBackgroundView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        roundedBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        symbolImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.size.equalTo(24)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolImageView)
            make.leading.equalTo(symbolImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().inset(12)
        }

        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
            make.trailing.lessThanOrEqualToSuperview().inset(12)
        }

        currentPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
        }

        changePercentageView.snp.makeConstraints { make in
            make.centerY.equalTo(currentPriceLabel)
            make.trailing.equalToSuperview().inset(12)
            make.leading.greaterThanOrEqualTo(currentPriceLabel.snp.trailing).offset(8)
            make.bottom.lessThanOrEqualToSuperview().inset(12)
        }
    }
    
    override func configureView() {
        roundedBackgroundView.backgroundColor = .backgroundSecondary
        roundedBackgroundView.layer.cornerRadius = 10
        roundedBackgroundView.clipsToBounds = true
        
        DispatchQueue.main.async { [weak self] in
            self?.symbolImageView.layer.cornerRadius = (self?.symbolImageView.frame.height ?? 0) / 2
        }
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.clipsToBounds = true
        
        nameLabel.font = ALRFont.body.font
        nameLabel.textColor = .themeSecondary
        nameLabel.textAlignment = .left
        
        symbolLabel.font = ALRFont.headlineBold.font
        symbolLabel.textColor = .textPrimary
        symbolLabel.textAlignment = .left
        
        currentPriceLabel.font = .boldSystemFont(ofSize: 21)
        currentPriceLabel.textColor = .textPrimary
    }
    
    func configureData(data: DetailData) {
        
        let urlString = data.image
        symbolImageView.kf.setImage(with: URL(string: urlString))
        
        symbolLabel.text = data.symbol
        nameLabel.text = data.name
        
        currentPriceLabel.text = data.currentPrice.toWonString()
        
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
            changePercentageView.iconImageView.tintColor = .textPrimary
            changePercentageView.changeRateLabel.textColor = .textPrimary
        }
    }
}
