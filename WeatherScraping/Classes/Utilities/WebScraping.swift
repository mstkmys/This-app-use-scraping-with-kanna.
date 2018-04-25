//
//  WebScraping.swift
//  WeatherScraping
//
//  Created by Miyoshi Masataka on 2018/04/26.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import Foundation
import Kanna

protocol Scrapingable {
    
    func getHtml() -> Data
    func parseHtml(day: String, data: Data) -> [Weather]
    
}

struct WebScraping {
    
    var url: URL
    
}

// MARK: - Scrapingable
/*******************************************************************************************/
extension WebScraping: Scrapingable {
    
    public func getHtml() -> Data {
        do {
            return try Data(contentsOf: self.url)
        } catch {
            fatalError("Failer to dowonload.")
        }
    }
    
    public func parseHtml(day: String, data: Data) -> [Weather] {
        guard let docment = try? HTML(html: data, encoding: .utf8) else { fatalError() }
        var dataArray = [Weather]()
        for i in 1...24 {
            let node = docment.xpath("//*[@id='tbl_list']//tr[td[1][text()='\(i)']]/td[2]")
            if let nodeFirst = node.first, let content = nodeFirst.content, let value = Double(content) {
                let weather = Weather(day: day, hour: String(describing: i), temperature: value)
                dataArray.append(weather)
            }
        }
        return dataArray
    }
    
}

























