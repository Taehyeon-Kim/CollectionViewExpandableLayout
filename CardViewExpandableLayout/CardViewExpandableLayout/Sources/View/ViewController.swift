//
//  ViewController.swift
//  CardViewExpandableLayout
//
//  Created by taekki on 2023/01/01.
//

import UIKit

class ViewController: UIViewController {
  
  let tableView = UITableView()
  let expandableView = ExpandableView()
  
  var data: [CardElement] = [
    CardElement(isExpanded: false, sections: CardElement.dummy),
    CardElement(isExpanded: false, sections: CardElement.dummy),
    CardElement(isExpanded: false, sections: CardElement.dummy),
    CardElement(isExpanded: false, sections: CardElement.dummy),
    CardElement(isExpanded: false, sections: CardElement.dummy),
    CardElement(isExpanded: false, sections: CardElement.dummy),
    CardElement(isExpanded: false, sections: CardElement.dummy),
    CardElement(isExpanded: false, sections: CardElement.dummy),
    CardElement(isExpanded: false, sections: CardElement.dummy),
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    setTableView()
  }
  
  private func setTableView() {
    tableView.register(ExpandableCell.self, forCellReuseIdentifier: ExpandableCell.identifier)
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
  }
}

extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    data.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.identifier) as! ExpandableCell

    cell.expandableView.configure(&data[indexPath.section])
    cell.expandableView.indexPath = indexPath
    
    cell.expandableView.handler = { indexPath in
      guard let indexPath else { return }
      self.data[indexPath.section].isExpanded.toggle()
      cell.expandableView.collectionView.reloadData()
      tableView.reloadData()
    }

    cell.layoutIfNeeded()
    return cell
  }
}
