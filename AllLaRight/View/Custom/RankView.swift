//
//  RankView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import UIKit
import SnapKit

final class RankView: BaseView {
    private let backgroundView = UIView()
    let rankLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(rankLabel)
    }
    
    override func configureLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(12)
        }
    }
    
    override func configureView() {
        backgroundView.layer.borderColor = UIColor.backgroundSecondary.cgColor
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.cornerRadius = 4
        backgroundView.clipsToBounds = true
        
        rankLabel.font = ALRFont.bodyBold.font
        rankLabel.textColor = .themeSecondary
    }
}
