//
//  BeerDetailViewController.swift
//  HomeWork
//
//  Created by 근식 on 2021/02/06.
//

import UIKit
import Kingfisher

final class BeerDetailViewController: UIViewController {
    
    private let item: Beer
    
    private let headerHeight: CGFloat = 200
    
    private lazy var descriptions: [(title: String, subtitle: String)] = {
        return [("품명", item.name),
                ("한 줄 소개", item.tagline),
                ("설명", item.beerDescription),
                ("어울리는 요리", item.foodPairing.map { "- " + $0 }.joined(separator: "\n"))]
    }()

    private lazy var headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(BeerDetailTableViewCell.self, forCellReuseIdentifier: BeerDetailTableViewCell.reuseIdentifier)
        tv.separatorStyle = .none
        tv.contentInset = .init(top: 30, left: 0, bottom: 30, right: 0)
        return tv
    }()
    
    init(item: Beer) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = item.name
        setConstraints()
        setData()
        
        print(self.item)
    }
    
    private func setConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        headerImageView.snp.makeConstraints {
            $0.width.equalTo(view.frame.width)
            $0.height.equalTo(headerImageView.snp.width).multipliedBy(0.75)
        }
    }
    
    private func setData() {
        let imageURL = URL(string: self.item.imageURL)
        headerImageView.kf.setImage(with: imageURL)
    }
    
}


// MARK: - TableView Delegate, DataSource

extension BeerDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.descriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerDetailTableViewCell.reuseIdentifier, for: indexPath) as? BeerDetailTableViewCell else { return UITableViewCell() }
        cell.data = self.descriptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerImageView
    }
    
}
