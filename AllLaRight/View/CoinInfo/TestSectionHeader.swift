//
//  TestSectionHeader.swift
//  AllLaRight
//
//  Created by 조우현 on 3/8/25.
//

import UIKit
import SnapKit

final class SectionHeader: UICollectionReusableView {
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    static let elementKind = "SectionHeader"
    static let identifier = "SectionHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(sectionLabel)
        sectionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind(sectionTitle: String) {
        sectionLabel.text = sectionTitle
    }
    
}
