//
//  RestaurantDetailSection.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/03.
//

import RxDataSources

// Multiple Sections
enum RestaurantDetailSection {
  case point([Item])  // 특징
  case food([Item])   // 음식
  case review([Item]) // 리뷰
}

extension RestaurantDetailSection: SectionModelType {
  var items: [Item] {
    switch self {
    case .point(let items):
      return items
    case .food(let items):
      return items
    case .review(let items):
      return items
    }
  }
  
  init(original: RestaurantDetailSection, items: [RestaurantDetailSection.Item]) {
    self = original
  }
}

extension RestaurantDetailSection {
  struct Item {
    let contents: String
  }
}
