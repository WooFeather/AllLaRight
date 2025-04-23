//
//  HotNFTCollectionViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import UIKit
import SnapKit
import Kingfisher

final class TrendingNFTCollectionViewCell: BaseCollectionViewCell {
    private let symbolImageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let changePercentageView = ChangePercentageView()
    
    override func configureHierarchy() {
        [symbolImageView, nameLabel, priceLabel, changePercentageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        symbolImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.size.equalTo(72)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(symbolImageView.snp.bottom).offset(4)
            make.height.equalTo(12)
            make.width.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.height.equalTo(12)
            make.width.equalToSuperview()
        }
        
        changePercentageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.height.equalTo(12)
            make.width.greaterThanOrEqualTo(50)
        }
    }
    
    override func configureView() {
        symbolImageView.layer.cornerRadius = 24
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.clipsToBounds = true
        
        nameLabel.font = ALRFont.bodyBold.font
        nameLabel.textColor = .textPrimary
        nameLabel.textAlignment = .center
        
        priceLabel.font = ALRFont.body.font
        priceLabel.textColor = .themeSecondary
        priceLabel.textAlignment = .center
    }
    
    func configureData(data: TrendingNFTItem) {
        let urlString = data.thumb
        symbolImageView.kf.setImage(with: URL(string: urlString))
        
        nameLabel.text = data.name
        priceLabel.text = data.data.floorPrice
        
        // 등락뷰 세팅
        let changeRate = data.floorPrice24hPercentageChange
        
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
