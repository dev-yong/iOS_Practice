//
//  StockViewController.swift
//  SOPT_Week6
//
//  Created by 이광용 on 2017. 11. 25..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class StockViewController: BaseViewController {
    //MARK:- Property
    @IBOutlet weak var tableView: UITableView!
    var stockList = [Stock]()
    var stockSearchService: SearchStockService?
    
    //MARK:- Method
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad() //StockViewController->BaseViewController ViewDidLoad->setup
        stockSearchService = SearchStockService()
        searchStock()
    }

    //MARK: Override SetUpUI
    override func setUpUI() {
        
    }
    
    //MARK: Search Stock
    func searchStock() {
        stockSearchService?.searchStock(stockCode: "035720", onStock: {(stock) in
            self.stockList.append(stock)
            self.tableView.reloadData()
        })
    }
}

//MARK:- Extension
//MARK: TableView DataSource
extension StockViewController: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        cell.textLabel?.text = stockList[indexPath.row].name
        cell.detailTextLabel?.text = stockList[indexPath.row].currentPrice
        return cell
    }
}

//MARK: TableView Delegate
extension StockViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
