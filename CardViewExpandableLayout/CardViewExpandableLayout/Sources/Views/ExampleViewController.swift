//
//  PeopleViewController.swift
//  ExpandingCollectionViewCell
//
//  Created by Shawn Gee on 9/28/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

import RxDataSources
import SnapKit

final class ExampleViewController: UIViewController {

  // Private Properties
  private let dummy: [ExpandableViewSection] = CardElement.dummy
  private var dataSource: ExpandableDiffableDataSource?

  // UI
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
  
  // Layout
  private let padding: CGFloat = 12
  
  // View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setCollectionView()
    setDataSource()
  }
}

// MARK: - Collection View Setup

extension ExampleViewController {

  private func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = padding
    section.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  private func setCollectionView() {
    collectionView.delegate = self
    collectionView.register(ExpandableCell.self, forCellWithReuseIdentifier: String(describing: ExpandableCell.self))
    collectionView.backgroundColor = .white
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setDataSource() {
    dataSource = ExpandableDiffableDataSource(collectionView: collectionView)
    collectionView.dataSource = dataSource
    
    var snapshot = NSDiffableDataSourceSnapshot<Int, ExpandableViewSection>()
    snapshot.appendSections([0])
    snapshot.appendItems(dummy)
    dataSource?.apply(snapshot)
  }
}

// MARK: - Collection View Delegate

extension ExampleViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      shouldSelectItemAt indexPath: IndexPath) -> Bool {
    guard let dataSource = dataSource else { return false }

    if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
      collectionView.deselectItem(at: indexPath, animated: true)
    } else {
      collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    dataSource.refresh()
    
    return false
  }
}

extension UICollectionViewDiffableDataSource {
  func refresh(completion: (() -> Void)? = nil) {
    self.apply(self.snapshot(), animatingDifferences: true, completion: completion)
  }
}
