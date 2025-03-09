//
//  SearchTableViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import UIKit
import SnapKit

class SearchTableViewCell: BaseTableViewCell {
    private let iconImageView = UIImageView()
    private let symbolLabel = UILabel()
    private let nameLabel = UILabel()
    private let rankView = UIView() // TODO: 커스텀뷰로 제작
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
            make.leading.equalTo(symbolLabel.snp.trailing).offset(4)
            make.height.equalTo(12)
            make.width.equalTo(20)
        }
        
        starButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(26)
        }
    }
    
    override func configureView() {
        DispatchQueue.main.async { [weak self] in
            self?.iconImageView.layer.cornerRadius = (self?.iconImageView.frame.height ?? 0) / 2
        }
        
        symbolLabel.font = ALRFont.headlineBold.font
        symbolLabel.textColor = .themePrimary
        
        nameLabel.font = ALRFont.headline.font
        nameLabel.textColor = .themeSecondary
        
        rankView.backgroundColor = .themeSecondary
        
        // TODO: configureData에서 분기처리
        let starIcon = UIImage(systemName: "star")
        starButton.setImage(starIcon, for: .normal)
        starButton.tintColor = .themePrimary
    }
    
    func configureData() {
        
    }
}
