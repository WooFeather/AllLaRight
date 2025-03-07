//
//  HotKeywordCollectionViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import UIKit
import SnapKit

final class HotKeywordCollectionViewCell: BaseCollectionViewCell {
    let rankScoreLabel = UILabel()
    let symbolImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let changePercentageView = UIView() // TODO: 커스텀뷰로 만들기
    
    override func configureHierarchy() {
        [rankScoreLabel, symbolImageView, nameLabel, descriptionLabel, changePercentageView].forEach {
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
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(symbolImageView.snp.trailing).offset(4)
            make.height.equalTo(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
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
        
        nameLabel.text = "BROCCOLI"
        nameLabel.font = ALRFont.headlineBold.font
        nameLabel.textColor = .themePrimary
        
        descriptionLabel.text = "This is Test"
        descriptionLabel.font = ALRFont.body.font
        descriptionLabel.textColor = .themeSecondary
        
        changePercentageView.backgroundColor = .blue
    }
    
    func configureData() {
        // TODO: 실제 데이터와 연결
    }
}
