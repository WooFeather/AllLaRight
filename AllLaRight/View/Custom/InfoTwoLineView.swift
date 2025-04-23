//
//  InfoTwoLineView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import UIKit
import SnapKit

final class InfoTwoLineView: BaseView {
    let upperLabel = UILabel()
    let valueLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(upperLabel)
        addSubview(valueLabel)
    }
    
    override func configureLayout() {
        upperLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.equalTo(15)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(upperLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.height.equalTo(15)
        }
    }
    
    override func configureView() {
        upperLabel.font = ALRFont.headline.font
        upperLabel.textColor = .themeSecondary
        
        valueLabel.font = ALRFont.headlineBold.font
        valueLabel.textColor = .textPrimary
    }
}
