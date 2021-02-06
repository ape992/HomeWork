//
//  BeerDetailTableViewCell.swift
//  HomeWork
//
//  Created by 근식 on 2021/02/06.
//

import UIKit

final class BeerDetailTableViewCell: UITableViewCell {
    
    var data: (title: String, subtitle: String)! {
        didSet {
            setData()
        }
    }

    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 15, weight: .medium)
        lb.textColor = .black
        lb.numberOfLines = 0
        return lb
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 15)
        lb.textColor = .darkGray
        lb.numberOfLines = 0
        return lb
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setData() {
        titleLabel.text = self.data.title
        subtitleLabel.text = self.data.subtitle
    }
    
}

extension BeerDetailTableViewCell: Reusable {}
