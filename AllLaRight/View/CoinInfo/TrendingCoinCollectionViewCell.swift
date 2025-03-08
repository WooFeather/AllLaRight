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
    let rankScoreLabel = UILabel()
    let symbolImageView = UIImageView()
    let symbolLabel = UILabel()
    let nameLabel = UILabel()
    let changePercentageView = UIView() // TODO: 커스텀뷰로 만들기
    
    override func configureHierarchy() {
        [rankScoreLabel, symbolImageView, symbolLabel, nameLabel, changePercentageView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        rankScoreLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(15)
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
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolLabel.snp.bottom)
            make.leading.equalTo(symbolImageView.snp.trailing).offset(4)
            make.height.equalTo(12)
        }
        
        changePercentageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(12)
            make.width.equalTo(20)
        }
    }
    
    override func configureView() {
        rankScoreLabel.text = "14"
        rankScoreLabel.font = ALRFont.headline.font
        rankScoreLabel.textColor = .themePrimary
        
        symbolImageView.backgroundColor = .orange
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.clipsToBounds = true
        
        symbolLabel.text = "BROCCOLI"
        symbolLabel.font = ALRFont.headlineBold.font
        symbolLabel.textColor = .themePrimary
        
        nameLabel.text = "This is Test"
        nameLabel.font = ALRFont.body.font
        nameLabel.textColor = .themeSecondary
        
        changePercentageView.backgroundColor = .blue
    }
    
    func configureData(data: MockTrendingCoinDetails) {
        rankScoreLabel.text = "\(data.score)"
        
        let urlString = data.thumb
        symbolImageView.kf.setImage(with: URL(string: urlString))
        
        symbolLabel.text = data.symbol
        nameLabel.text = data.name
        
        // TODO: changePercentageView에 change반영
    }
}
