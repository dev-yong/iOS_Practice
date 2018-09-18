//
//  SearchStockService.swift
//  SOPT_Week6
//
//  Created by 이광용 on 2017. 11. 25..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

protocol SearcheStockProtocol {
    func searchStock(stockCode: String, onStock: @escaping (Stock)->())
}

//Stock 검색 용도
class SearchStockService: SearcheStockProtocol {
    func searchStock(stockCode: String, onStock: @escaping (Stock)->()) {
        let siteURL = "http://finance.daum.net/item/main.daum?code=\(stockCode)"
        Alamofire.request(siteURL).responseString(){ (response) in
            guard let htmlResponse = response.result.value else {return}
            guard let doc = HTML(html: htmlResponse, encoding: .utf8) else {return}
            
            guard let nameElement = doc.at_css("#topWrap > div.topInfo > h2"),
                let name = nameElement.content else {return}
            guard let priceElement = doc.at_css("#topWrap > div.topInfo > ul.list_stockrate"),
                let price = priceElement.content else {return}
            
            let stock = Stock(code: stockCode, name: name, currentPrice: price)
            onStock(stock)
        }
    }
}
