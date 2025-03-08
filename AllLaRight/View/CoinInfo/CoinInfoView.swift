//
//  CoinInfoView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import UIKit
import SnapKit

final class CoinInfoView: BaseView {
    
    let searchTextField = RoundedTextField()
    lazy var infoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override func configureHierarchy() {
        addSubview(searchTextField)
        addSubview(infoCollectionView)
    }
    
    override func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        infoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        infoCollectionView.isScrollEnabled = false
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let header = makeHeaderView()
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                // 내부 외부 그룹
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/7))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
                
                let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
                
                let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitems: [item])
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [innerGroup])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                section.boundarySupplementaryItems = [header]
                
                return section
            } else {
                // 수평스크롤
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(80), heightDimension: .fractionalHeight(1.0))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(300), heightDimension: .absolute(200))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [header]
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            }
        }
        return layout
    }
    
    private func makeHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: SectionHeader.elementKind,
            alignment: .top)
        
        return header
    }
}
