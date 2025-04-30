//
//  DetailSectionHeader.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import UIKit
import SnapKit

final class DetailSectionHeader: BaseView {
    let titleLabel = UILabel()
    let moreButton = UIButton()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
    }
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(moreButton)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(17)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(17)
            make.width.equalTo(68)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    override func configureView() {
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .textPrimary
        
        moreButton.configuration = .moreButtonStyle()
        moreButton.setTitle("더보기", for: .normal)
        moreButton.setTitleColor(.themeSecondary, for: .normal)
        moreButton.tintColor = .themeSecondary
    }
}
