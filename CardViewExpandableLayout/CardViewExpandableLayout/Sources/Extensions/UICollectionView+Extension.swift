//
//  UICollectionView+Extension.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/03.
//

import UIKit

extension UICollectionView {
  open override func layoutSubviews() {
    super.layoutSubviews()
    if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
      self.invalidateIntrinsicContentSize()
    }
  }
  
  open override var intrinsicContentSize: CGSize {
    return contentSize
  }
}
