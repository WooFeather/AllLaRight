//
//  PortfolioView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import UIKit
import SnapKit

final class PortfolioView: BaseView {

    private let navigationView = NavigationTitleView(title: "포트폴리오")
    lazy var favoriteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override func configureHierarchy() {
        addSubview(navigationView)
        addSubview(favoriteCollectionView)
    }
    
    override func configureLayout() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        favoriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let sideInset: CGFloat = 16

        // 컬렉션뷰 가장자리 inset
        layout.sectionInset = .init(top: spacing, left: sideInset, bottom: spacing, right: sideInset)
        // 아이템 간 세로/가로 간격
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing

        // 가로 방향으로 2열, (전체 너비 – 양쪽 inset – 사이간격) / 2
        let totalSpacing = sideInset * 2 + spacing
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / 2
        // 높이는 필요에 따라 조절 (여기선 너비의 1.0 배)
        layout.itemSize = .init(width: itemWidth, height: itemWidth * 1.0)

        return layout
    }
}
