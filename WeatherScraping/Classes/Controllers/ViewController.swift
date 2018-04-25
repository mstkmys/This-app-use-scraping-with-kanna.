//
//  ViewController.swift
//  WeatherScraping
//
//  Created by Miyoshi Masataka on 2018/04/25.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit
import Kanna

class ViewController: UIViewController {
    
    private var scrapingView: ScrapingView = {
        let view = ScrapingView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        return view
    }()
    
    private var tableView: UITableView {
        return scrapingView.tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        [scrapingView].forEach{ self.view.addSubview($0) }
        tableView.dataSource = self
        tableView.delegate = self
    }

}

// MARK: - UITableViewDataSource
/*******************************************************************************************/
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        return cell
    }
    
}


// MARK: - UITableViewDelegate
/*******************************************************************************************/
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
























