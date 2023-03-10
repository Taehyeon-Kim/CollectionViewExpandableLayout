//
//  ExpandableViewSection.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/01.
//

import RxDataSources

struct CardElement {
  var isExpanded: Bool = false
  var sections: [ExpandableViewSection]
  
  init(isExpanded: Bool, sections: [ExpandableViewSection]) {
    self.isExpanded = isExpanded
    self.sections = sections
  }
}

extension CardElement {
  static let dummy: [ExpandableViewSection] = [
    .reputation([
      .init(content: "ðĨ"),
      .init(content: "ð"),
      .init(content: "ð"),
      .init(content: "ðĨ"),
      .init(content: "ðĨĶ"),
      .init(content: "ðĨŽ")
    ]),
    .study([
      .init(content: "ð"),
      .init(content: "ð"),
    ]),
    .review([
      .init(content: "ð"),
      .init(content: "ðĶī")
    ])
  ]
}

enum ExpandableViewSection: Hashable {
  case reputation([Item])
  case study([Item])
  case review([Item])
}

extension ExpandableViewSection: SectionModelType {
  var items: [Item] {
    switch self {
    case let .reputation(items):
      return items
    case let .study(items):
      return items
    case let .review(items):
      return items
    }
  }
  
  init(original: ExpandableViewSection, items: [ExpandableViewSection.Item]) {
    switch original {
    case let .reputation(items):
      self = .reputation(items)
    case let .study(items):
      self = .study(items)
    case let .review(items):
      self = .review(items)
    }
  }
}

extension ExpandableViewSection {
  struct Item: Hashable {
    let content: String
  }
}
