//
//  RestaurantDetailSection.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/03.
//

import Foundation

import RxDataSources

// Multiple Sections
enum RestaurantDetailSection {
  case point([Item])  // 특징
  case food([Item])   // 음식
  case review([Item]) // 리뷰
}

extension RestaurantDetailSection: Hashable {
  struct Item {
    let id = UUID()
    let contents: String
  }
}

extension RestaurantDetailSection.Item: Hashable, Equatable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func ==(lhs: RestaurantDetailSection.Item, rhs: RestaurantDetailSection.Item) -> Bool {
      return lhs.id == rhs.id
  }
}
