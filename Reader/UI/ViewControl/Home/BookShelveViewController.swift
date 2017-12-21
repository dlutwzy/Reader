//
//  BookShelveViewController.swift
//  Reader
//
//  Created by WZY on 2017/12/21.
//  Copyright © 2017年 WZY. All rights reserved.
//

import Foundation
import UIKit

class BookShelveViewController: UIViewController {
    
    var searchBarItem: UIBarButtonItem?
    var manageBarButton: UIBarButtonItem?


    @objc func searchBarButtonTouchUpInside(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            let searchController = R.storyboard.home().instantiateViewController(withIdentifier: "HomePages-SearchBookController")
            self.navigationController?.pushViewController(searchController, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchButton = UIButton(type: .custom)
        searchButton.setTitle("搜索", for: .normal)
        searchButton.setTitleColor(UIColor(red:22/255, green:125/255, blue:250/255, alpha:1), for: .normal)
        searchButton.addTarget(self, action: #selector(searchBarButtonTouchUpInside(_:)), for: .touchUpInside)
        self.searchBarItem = UIBarButtonItem(customView: searchButton)
        self.navigationItem.setLeftBarButton(self.searchBarItem, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
