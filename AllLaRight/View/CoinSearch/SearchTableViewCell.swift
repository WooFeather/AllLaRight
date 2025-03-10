//
//  SearchTableViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import UIKit
import SnapKit
import Kingfisher

class SearchTableViewCell: BaseTableViewCell {
    private let iconImageView = UIImageView()
    private let symbolLabel = UILabel()
    private let nameLabel = UILabel()
    private let rankView = RankView()
    private let starButton = UIButton()
    
    override func configureHierarchy() {
        [iconImageView, symbolLabel, nameLabel, rankView, starButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(36)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.height.equalTo(15)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolLabel.snp.bottom).offset(4)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.height.equalTo(12)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        rankView.snp.makeConstraints { make in
            make.centerY.equalTo(symbolLabel.snp.centerY)
            make.leading.equalTo(symbolLabel.snp.trailing).offset(8)
            make.height.equalTo(15)
            make.width.greaterThanOrEqualTo(10)
        }
        
        starButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(26)
        }
    }
    
    override func configureView() {
        DispatchQueue.main.async { [weak self] in
            self?.iconImageView.layer.cornerRadius = (self?.iconImageView.frame.height ?? 0) / 2
        }
        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFill
        
        symbolLabel.font = ALRFont.headlineBold.font
        symbolLabel.textColor = .themePrimary
        
        nameLabel.font = ALRFont.headline.font
        nameLabel.textColor = .themeSecondary
        
        // TODO: configureData에서 분기처리
        let starIcon = UIImage(systemName: "star")
        starButton.setImage(starIcon, for: .normal)
        starButton.tintColor = .themePrimary
    }
    
    func configureData(data: CoinData) {
        let urlString = data.large
        iconImageView.kf.setImage(with: URL(string: urlString))
        
        symbolLabel.text = data.symbol
        
        nameLabel.text = data.name
        
        if let rank = data.marketCapRank {
            rankView.rankLabel.isHidden = false
            rankView.rankLabel.text = "#\(rank)"
        } else {
            rankView.isHidden = true
        }
    }
}
