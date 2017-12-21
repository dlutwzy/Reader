//
//  ClickableTitleBarButtonItem.swift
//  Reader
//
//  Created by WZY on 2017/12/21.
//  Copyright © 2017年 WZY. All rights reserved.
//

import Foundation
import UIKit

class ClickableTitleBarButton: UINavigationItem {

    var titleButton: UIButton {
        return self.titleView as! UIButton
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let titleButton = UIButton(type: .custom)
        titleButton.setTitle(self.title, for: .normal)
        titleButton.setTitleColor(UIColor.black, for: .normal)
        //titleButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        self.titleView = titleButton
    }

    @objc func click(button:UIButton?) {
        print(button?.title(for: .normal) ?? "??")
    }
}
