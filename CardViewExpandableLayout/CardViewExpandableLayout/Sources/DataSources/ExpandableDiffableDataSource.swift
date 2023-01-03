//
//  ExpandableDiffableDataSource.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/04.
//

import UIKit

final class ExpandableDiffableDataSource: UICollectionViewDiffableDataSource<Int, ExpandableViewSection> {
  init(collectionView: UICollectionView) {
    super.init(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: String(describing: ExpandableCell.self),
        for: indexPath) as? ExpandableCell else {
          fatalError("Could not cast cell as \(ExpandableCell.self)")
        }
      cell.item = item
      return cell
    }
  }
}
