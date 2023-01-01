//
//  FixedCell.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/01.
//

import UIKit

import SnapKit

/// Section에서 고정이 될 Cell
final class FixedCell: UICollectionViewCell {
  
  let titleLabal = UILabel()
  let disclosureButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setStyle()
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func setStyle() {
    titleLabal.text = "FIXED TITLE"
    titleLabal.font = .systemFont(ofSize: 18, weight: .bold)
    
    let image = UIImage(systemName: "sunset")
    disclosureButton.setImage(image, for: .normal)
  }
  
  private func setLayout() {
    contentView.addSubview(titleLabal)
    titleLabal.snp.makeConstraints {
      $0.leading.directionalVerticalEdges.equalToSuperview().inset(16)
    }
    
    contentView.addSubview(disclosureButton)
    disclosureButton.snp.makeConstraints {
      $0.centerY.equalTo(titleLabal.snp.centerY)
      $0.trailing.equalToSuperview().inset(16)
      $0.size.equalTo(16)
    }
  }
}

