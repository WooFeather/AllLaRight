//
//  NavigationDetailView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import UIKit
import SnapKit

final class NavigationDetailView: BaseView {
    private let repository: StarItemRepository = StarItemTableRepository()
    private let titleView = UIView()
    private let separatorView = UIView()
    let backButton = UIButton()
    let starButton = UIButton()
    let iconImageView = UIImageView()
    let symbolLabel = UILabel()
    
    override func configureHierarchy() {
        [titleView, separatorView, backButton, starButton].forEach {
            addSubview($0)
        }
        
        [iconImageView, symbolLabel].forEach {
            titleView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(20)
            make.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(titleView.snp.centerY)
            make.size.equalTo(26)
        }
        
        starButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(titleView.snp.centerY)
            make.size.equalTo(26)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.size.equalTo(26)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    override func configureView() {
        let backIcon = UIImage(systemName: "arrow.left")
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = .textPrimary
        
        let starIcon = UIImage(systemName: "star")
        let starFillIcon = UIImage(systemName: "star.fill")
        starButton.setImage(starIcon, for: .normal)
        starButton.setImage(starFillIcon, for: .selected)
        starButton.tintColor = .textPrimary
        starButton.isSelected = false
        
        DispatchQueue.main.async { [weak self] in
            self?.iconImageView.layer.cornerRadius = (self?.iconImageView.frame.height ?? 0) / 2
        }
        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFill
        
        symbolLabel.font = ALRFont.headlineBold.font
        symbolLabel.textColor = .textPrimary
        
        separatorView.backgroundColor = .textPrimary
    }
}
