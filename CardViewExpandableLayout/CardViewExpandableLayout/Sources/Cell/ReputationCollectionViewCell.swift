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
    titleLabel.text = "평판"
  }
  
  private func setLayout() {
    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(5)
    }
  }
}

extension ReputationCollectionViewCell {
  
  func configure(_ item: ExpandableViewSection.Item) {
    titleLabel.text = item.content
  }
}
