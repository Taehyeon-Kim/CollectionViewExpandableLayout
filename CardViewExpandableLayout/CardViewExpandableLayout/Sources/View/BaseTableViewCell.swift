//
//  BaseTableViewCell.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/01.
//

import UIKit

import RxSwift

final class BaseTableViewCell: UITableViewCell {
  
  var disposeBag = DisposeBag()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError()
  }
}
