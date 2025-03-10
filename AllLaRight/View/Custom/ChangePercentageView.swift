//
//  ChangePercentageView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/8/25.
//

import UIKit
import SnapKit

final class ChangePercentageView: BaseView {
    let iconImageView = UIImageView()
    let changeRateLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(iconImageView)
        addSubview(changeRateLabel)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(changeRateLabel.snp.leading).offset(-4)
            make.centerY.equalToSuperview()
            make.size.equalTo(9)
        }
        
        changeRateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(12)
        }
    }
    
    override func configureView() {
        iconImageView.contentMode = .scaleAspectFill
        
        changeRateLabel.font = ALRFont.bodyBold.font
    }
}
