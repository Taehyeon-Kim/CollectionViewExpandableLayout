//
//  BaseCollectionViewCell.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/01.
//

import UIKit

import RxSwift

final class BaseCollectionViewCell: UICollectionViewCell {
  
  var disposeBag = DisposeBag()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError()
  }
}
