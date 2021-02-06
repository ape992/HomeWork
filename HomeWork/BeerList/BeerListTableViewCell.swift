//
//  BeerListTableViewCell.swift
//  HomeWork
//
//  Created by 근식 on 2021/02/06.
//

import UIKit
import SnapKit
import Kingfisher

final class BeerListTableViewCell: UITableViewCell {
    
    var item: Beer! {
        didSet {
            setData()
        }
    }
    
    private lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 15)
        lb.textColor = .black
        lb.numberOfLines = 0
        return lb
    }()
    
    private lazy var beerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        contentView.addSubview(beerImageView)
        beerImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(8)
            $0.height.width.equalTo(80)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(8)
            $0.top.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setData() {
        let imageURL = URL(string: self.item.imageURL)
        beerImageView.kf.setImage(with: imageURL)
        descriptionLabel.text = self.item.name
    }
    
}

extension BeerListTableViewCell: Reusable {}
