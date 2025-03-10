//
//  InfoThreeLineView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import UIKit
import SnapKit

final class InfoThreeLineView: BaseView {
    let upperLabel = UILabel()
    let valueLabel = UILabel()
    let lowerLabel = UILabel()
    
    override func configureHierarchy() {
        [upperLabel, valueLabel, lowerLabel].forEach {
            addSubview($0)
        }
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
        
        lowerLabel.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.height.equalTo(12)
        }
    }
    
    override func configureView() {
        upperLabel.font = ALRFont.headline.font
        upperLabel.textColor = .themeSecondary
        
        valueLabel.font = ALRFont.headlineBold.font
        valueLabel.textColor = .themePrimary
        
        lowerLabel.font = ALRFont.bodyBold.font
        lowerLabel.textColor = .themeSecondary
    }
}
