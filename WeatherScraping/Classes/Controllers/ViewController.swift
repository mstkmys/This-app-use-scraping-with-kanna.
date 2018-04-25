//
//  ViewController.swift
//  WeatherScraping
//
//  Created by Miyoshi Masataka on 2018/04/25.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {
    
    private var scrapingView: ScrapingView = {
        let view = ScrapingView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        return view
    }()
    
    private var tableView: UITableView {
        return scrapingView.tableView
    }
    
    private var finalDataArray = [Weather]() {
        didSet {
            updateUI()
        }
    }
    private var yesterdayDataArray = [Weather]()
    private var todayDataArray = [Weather]()

    override func viewDidLoad() {
        super.viewDidLoad()
        [scrapingView].forEach{ self.view.addSubview($0) }
        tableView.dataSource = self
        tableView.delegate = self
        executed()
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func executed() {
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "東京の天気を取得しています...")
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "jp.mstk.queue1")
        let queue2 = DispatchQueue(label: "jp.mskt.queue2")
        queue1.async(group: group) {
            guard let url = URL(string: "http://www.jma.go.jp/jp/amedas_h/yesterday-44132.html?areaCode=000&groupCode=30") else { return }
            let webScraping = WebScraping(url: url)
            self.yesterdayDataArray = webScraping.parseHtml(day: "yesterday", data: webScraping.getHtml())
        }
        queue2.async(group: group) {
            guard let url = URL(string: "http://www.jma.go.jp/jp/amedas_h/today-44132.html?areaCode=000&groupCode=30") else { return }
            let webScraping = WebScraping(url: url)
            self.todayDataArray = webScraping.parseHtml(day: "today", data: webScraping.getHtml())
        }
        group.notify(queue: DispatchQueue.main) {
            self.finalDataArray = self.yesterdayDataArray + self.todayDataArray
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }

}

// MARK: - UITableViewDataSource
/*******************************************************************************************/
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        let weather = finalDataArray[indexPath.row]
        cell.timeStamp.text = "\(weather.day): \(weather.hour)時"
        cell.temperature.text = "\(weather.temperature)°"
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
























