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

struct Test {
    var hello: String?
    func helloFunc() {
        print("hello func")
    }
}

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

            var test: Test = Test(hello: "haha")

            let helloFunc = test.helloFunc
            helloFunc()
            let str = test[keyPath: \Test.hello]
            let str2 = test.hello
            print(str)
            print(str2)
            test[keyPath: \Test.hello] = "???"
            print(str)
            print(str2)
        }
        /*
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
 */
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
