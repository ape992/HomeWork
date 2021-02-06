//
//  BeerListViewController.swift
//  HomeWork
//
//  Created by 근식 on 2021/02/06.
//

import UIKit
import SnapKit

final class BeerListViewController: UIViewController {

    private var items = [Beer]()
    
    private var currentPage = 0
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(BeerListTableViewCell.self,
                    forCellReuseIdentifier: BeerListTableViewCell.reuseIdentifier)
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "맥주"
        setConstraints()
        fetchData()
    }
    
    private func setConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func fetchData() {
        BeerService.shared.fetchBeers(page: self.currentPage + 1) { (beers) in
            guard let beers = beers else { return }
            
            self.items.append(contentsOf: beers)
            self.currentPage += 1
            self.tableView.reloadData()
        }
    }
    
}


// MARK: - TableView Delegate, DataSource

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListTableViewCell.reuseIdentifier, for: indexPath) as? BeerListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.item = self.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.items[indexPath.row]
        let detailVC = BeerDetailViewController(item: item)
        
        self.show(detailVC, sender: nil)
    }
    
}


// MARK: - ScrollView Delegate

extension BeerListViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let height: CGFloat = scrollView.frame.size.height
      let contentYOffset: CGFloat = scrollView.contentOffset.y
      let scrollViewHeight: CGFloat = scrollView.contentSize.height
      let distanceFromBottom: CGFloat = scrollViewHeight - contentYOffset
                
      if distanceFromBottom < height {
        self.fetchData()
      }
    }
    
    
}
