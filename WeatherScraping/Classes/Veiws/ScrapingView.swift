//
//  ScrapingView.swift
//  WeatherScraping
//
//  Created by Miyoshi Masataka on 2018/04/26.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit

class ScrapingView: UIView {
    
    public let tableView: UITableView = {
        let view = UITableView()
        view.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [tableView].forEach{ self.addSubview($0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        tableView.anchor(
            top: self.safeAreaLayoutGuide.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.safeAreaLayoutGuide.bottomAnchor,
            trailing: self.trailingAnchor
        )
    }
    
}























