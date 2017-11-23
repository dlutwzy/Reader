//
//  HomeViewController.swift
//  Reader
//
//  Created by WZY on 2017/11/22.
//  Copyright © 2017年 WZY. All rights reserved.
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

        Alamofire.request(BingeBookRouter.ranking()).responseString { (response) in
//            if let json = response.result.value {
//                print("Json is : \(json)")
//            }
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("data is : \(utf8Text)")
//            }
            if let ranking  = JSONDeserializer<Ranking>.deserializeFrom(json: response.result.value) {
                print("json obj is : \(ranking)")
            }
            if let ranking  = Ranking.deserialize(from: response.result.value) {
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
