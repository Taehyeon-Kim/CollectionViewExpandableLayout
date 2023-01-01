//
//  ExpandableView.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/01.
//

import UIKit

import RxDataSources
import RxCocoa
import RxSwift
import SnapKit

final class ExpandableView: BaseView {
  
  // MARK: UI
  let vStackView = UIStackView()
  let titleLabel = UILabel()
  let disclosure = UIButton()
  let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
  
  // MARK: Properties
  let dataSource: RxCollectionViewSectionedReloadDataSource<ExpandableViewSection>!
  var sections = BehaviorRelay<[ExpandableViewSection]>(value: [])
  var isExpanded = BehaviorRelay(value: false)
  var handler: ((IndexPath?) -> Void)?
  var indexPath: IndexPath?
  
  override init(frame: CGRect) {
    dataSource = Self.dataSourceFactory()
    super.init(frame: frame)
  }
  
  override func setStyle() {
    collectionView.backgroundColor = .lightGray
    collectionView.isHidden = true
    titleLabel.text = "TITLE"
    disclosure.backgroundColor = .green
    
    vStackView.axis = .vertical
    vStackView.distribution = .fill
    
    registerCells()
    setCollectionView()
    setBindings()
  }
  
  override func setLayout() {
    addSubview(titleLabel)
    addSubview(disclosure)
    
    vStackView.addArrangedSubview(collectionView)
    addSubview(vStackView)
    
    titleLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(5)
      $0.height.equalTo(37).priority(.high)
    }
    
    disclosure.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel.snp.centerY)
      $0.trailing.equalToSuperview().inset(5)
      $0.size.equalTo(20)
    }
    
    vStackView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(5)
      $0.directionalHorizontalEdges.bottom.equalToSuperview().inset(5)
    }
    
    collectionView.snp.makeConstraints {
      $0.height.equalTo(20).priority(.low)
    }
  }
}

extension ExpandableView {
  
  func registerCells() {
    collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
    
    collectionView.register(ReputationCollectionViewCell.self, forCellWithReuseIdentifier: ReputationCollectionViewCell.identifier)
    collectionView.register(StudyCollectionViewCell.self, forCellWithReuseIdentifier: StudyCollectionViewCell.identifier)
    collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
  }
  
  private func setCollectionView() {
    collectionView.collectionViewLayout = Self.layoutFactory()
  }
  
  private func setBindings() {
    sections
      .bind(to: collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)

    disclosure.rx.tap
      .bind { _ in
        self.handler?(self.indexPath ?? nil)
      }
      .disposed(by: disposeBag)
  }

  private static func dataSourceFactory() -> RxCollectionViewSectionedReloadDataSource<ExpandableViewSection> {
    return .init { dataSource, collectionView, indexPath, item in
      switch dataSource[indexPath.section] {
      case .reputation(let item):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReputationCollectionViewCell.identifier, for: indexPath) as! ReputationCollectionViewCell
        cell.configure(item[indexPath.row])
        return cell
      case .study(let item):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudyCollectionViewCell.identifier, for: indexPath) as! StudyCollectionViewCell
        cell.configure(item[indexPath.row])
        return cell
      case .review(let item):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as! ReviewCollectionViewCell
        cell.configure(item[indexPath.row])
        return cell
      }
    } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
      return header
    }
  }
  
  private static func layoutFactory() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(37))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [Self.createHeaderLayout()]
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  private static func createHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
    return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
  }
  
  func configure(_ elem: inout CardElement) {
    self.sections.accept(elem.sections)
    collectionView.isHidden = !elem.isExpanded
  }
}
