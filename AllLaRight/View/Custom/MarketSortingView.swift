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
    private let upperImageView = UIImageView()
    private let lowerImageView = UIImageView()

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
            make.top.trailing.equalToSuperview()
            make.size.equalTo(8)
        }
        
        lowerImageView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.size.equalTo(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.trailing.equalTo(lowerImageView.snp.leading)
        }
    }
    
    override func configureView() {
        titleLabel.textColor = .themePrimary
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        upperImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        upperImageView.tintColor = .themeSecondary
        upperImageView.contentMode = .scaleAspectFill
        
        lowerImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        lowerImageView.tintColor = .themeSecondary
        lowerImageView.contentMode = .scaleAspectFill
    }
}
