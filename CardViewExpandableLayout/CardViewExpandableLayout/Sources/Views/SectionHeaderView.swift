//
//  SectionHeaderView.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/01.
//

import UIKit

final class SectionHeaderView: UICollectionReusableView {
  static let identifier = "SectionHeaderView"
  
  let titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    titleLabel.text = "섹션헤더"
    titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
    
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(5)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}
