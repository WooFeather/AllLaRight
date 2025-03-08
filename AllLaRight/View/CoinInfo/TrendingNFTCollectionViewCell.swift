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
    let symbolImageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let changePercentageView = UIView() // TODO: 커스텀뷰로 만들기
    
    override func configureHierarchy() {
        [symbolImageView, nameLabel, priceLabel, changePercentageView].forEach {
            addSubview($0)
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
            make.width.equalTo(40)
        }
    }
    
    override func configureView() {
        symbolImageView.layer.cornerRadius = 24
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.clipsToBounds = true
        
        nameLabel.font = ALRFont.bodyBold.font
        nameLabel.textColor = .themePrimary
        nameLabel.textAlignment = .center
        
        priceLabel.font = ALRFont.body.font
        priceLabel.textColor = .themeSecondary
        priceLabel.textAlignment = .center
        
        changePercentageView.backgroundColor = .blue
    }
    
    func configureData(data: MockTrendingNFTItem) {
        let urlString = data.thumb
        symbolImageView.kf.setImage(with: URL(string: urlString))
        
        nameLabel.text = data.name
        priceLabel.text = data.data.floorPrice
        
        // TODO: changePercentageView에 change반영
    }
}
