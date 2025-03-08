//
//  TestSectionHeader.swift
//  AllLaRight
//
//  Created by 조우현 on 3/8/25.
//

import UIKit
import SnapKit

final class SectionHeader: UICollectionReusableView {
    
    private let sectionLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        addSubview(sectionLabel)
        addSubview(dateLabel)
    }
    
    private func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
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
        sectionLabel.font = .boldSystemFont(ofSize: 15)
        sectionLabel.textColor = .themePrimary
        
        dateLabel.font = ALRFont.headline.font
        dateLabel.textColor = .themeSecondary
    }
    
    func configureData(sectionTitle: String, dateString: String) {
        sectionLabel.text = sectionTitle
        
        dateLabel.text = dateString
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
