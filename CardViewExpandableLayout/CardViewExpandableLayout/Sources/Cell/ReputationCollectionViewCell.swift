//
//  ReputationCollectionViewCell.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/01.
//

import UIKit

final class ReputationCollectionViewCell: UICollectionViewCell {
  static let identifier = "ReputationCollectionViewCell"
  
  let titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setStyle()
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func setStyle() {
    clipsToBounds = true
    layer.cornerRadius = 8
    contentView.backgroundColor = .darkGray
    titleLabel.textAlignment = .center
  }
  
  private func setLayout() {
    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(5)
    }
  }
}

extension ReputationCollectionViewCell {
  
  func configure(_ item: ExpandableViewSection.Item) {
    titleLabel.text = item.content
  }
}
