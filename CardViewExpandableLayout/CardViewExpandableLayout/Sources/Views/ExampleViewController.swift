//
//  PeopleViewController.swift
//  ExpandingCollectionViewCell
//
//  Created by Shawn Gee on 9/28/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

import SnapKit

class ExampleViewController: UIViewController {
  enum Section {
    case main
  }
  
  // MARK: - Private Properties
  private let dummy: [ExpandableViewSection] = CardElement.dummy
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
  private var dataSource: UICollectionViewDiffableDataSource<Section, ExpandableViewSection>?
  
  private let padding: CGFloat = 12
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpCollectionView()
    setUpDataSource()
    collectionView.delegate = self
  }
  
  // MARK: - Private Methods
  
  private func createLayout() -> UICollectionViewLayout {
    // The item and group will share this size to allow for automatic sizing of the cell's height
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .estimated(50))
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                   subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = padding
    section.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
    
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  private func setUpCollectionView() {
    collectionView.register(ExpandableCell.self, forCellWithReuseIdentifier: String(describing: ExpandableCell.self))
    collectionView.backgroundColor = .white
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setUpDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, ExpandableViewSection>(collectionView: collectionView) {
      (collectionView, indexPath, item) -> UICollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: String(describing: ExpandableCell.self),
        for: indexPath) as? ExpandableCell else {
        fatalError("Could not cast cell as \(ExpandableCell.self)")
      }
      cell.item = item
      return cell
    }
    collectionView.dataSource = dataSource
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, ExpandableViewSection>()
    snapshot.appendSections([.main])
    snapshot.appendItems(dummy)
    dataSource?.apply(snapshot)
  }
}

// MARK: - Collection View Delegate

extension ExampleViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      shouldSelectItemAt indexPath: IndexPath) -> Bool {
    guard let dataSource = dataSource else { return false }
    
    // Allows for closing an already open cell
    if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
      collectionView.deselectItem(at: indexPath, animated: true)
    } else {
      collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    // collectionView.layoutIfNeeded()
    dataSource.refresh()
    
    return false // The selecting or deselecting is already performed above
  }
}

extension UICollectionViewDiffableDataSource {
  /// Reapplies the current snapshot to the data source, animating the differences.
  /// - Parameters:
  ///   - completion: A closure to be called on completion of reapplying the snapshot.
  func refresh(completion: (() -> Void)? = nil) {
    self.apply(self.snapshot(), animatingDifferences: true, completion: completion)
  }
}
