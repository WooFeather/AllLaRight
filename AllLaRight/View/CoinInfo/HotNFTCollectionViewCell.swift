//
//  HotNFTCollectionViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import UIKit
import SnapKit

final class HotNFTCollectionViewCell: BaseCollectionViewCell {
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
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.height.equalTo(12)
        }
        
        changePercentageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.height.equalTo(12)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    override func configureView() {
        symbolImageView.backgroundColor = .cyan
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.clipsToBounds = true
        
        nameLabel.text = "Special NFT"
        nameLabel.font = ALRFont.bodyBold.font
        nameLabel.textColor = .themePrimary
        
        priceLabel.text = "9.99 ETH"
        priceLabel.font = ALRFont.body.font
        priceLabel.textColor = .themeSecondary
        
        changePercentageView.backgroundColor = .red
    }
    
    func configureData() {
        // TODO: 실제 데이터와 연결
    }
}
