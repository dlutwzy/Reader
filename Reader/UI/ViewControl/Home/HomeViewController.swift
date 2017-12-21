//
//  HomeViewController.swift
//  Reader
//
//  Created by WZY on 2017/11/22.
//  Copyright © 2017 WZY. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor(patternImage: R.image.shelf_divider()!)
        Alamofire.request(BingeBookRouter.ranking()).responseJModel { (response: DataResponse<Ranking>) in

            if let ranking = response.result.value {
                print("json obj is : \(ranking)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
