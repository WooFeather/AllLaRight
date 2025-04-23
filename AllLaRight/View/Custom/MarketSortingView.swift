//
//  MarketSortingView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import SnapKit

final class MarketSortingView: BaseView {

    private let titleLabel = UILabel()
    let upperImageView = UIImageView()
    let lowerImageView = UIImageView()

    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        
        isUserInteractionEnabled = true
    }
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(upperImageView)
        addSubview(lowerImageView)
    }
    
    override func configureLayout() {
        upperImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.trailing.equalToSuperview()
            make.size.equalTo(6)
        }
        
        lowerImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-1)
            make.trailing.equalToSuperview()
            make.size.equalTo(6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.trailing.equalTo(lowerImageView.snp.leading).offset(-1)
        }
    }
    
    override func configureView() {
        titleLabel.textColor = .textPrimary
        titleLabel.font = ALRFont.headlineBold.font
        
        upperImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        upperImageView.contentMode = .scaleAspectFill
        
        lowerImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        lowerImageView.contentMode = .scaleAspectFill
    }
}
