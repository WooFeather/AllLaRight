//
//  TestSectionHeader.swift
//  AllLaRight
//
//  Created by 조우현 on 3/8/25.
//

import UIKit
import SnapKit

final class InfoSectionHeader: UICollectionReusableView {
    
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(dateLabel)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(17)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(15)
        }
    }
    
    private func configureView() {
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .textPrimary
        
        dateLabel.font = ALRFont.headline.font
        dateLabel.textColor = .themeSecondary
    }
    
    func configureData(sectionTitle: String, dateString: String) {
        titleLabel.text = sectionTitle
        
        dateLabel.text = dateString
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
