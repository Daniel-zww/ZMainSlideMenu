//
//  ZRightViewController.swift
//  ZMainSlideMenuDemo
//
//  Created by Daniel on 12/05/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ZRightViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let btnEvent = UIButton(type: UIButtonType.custom)
        btnEvent.frame = CGRect(x: 20, y: 200, width: 100, height: 35)
        btnEvent.setTitle("京东商城", for: UIControlState.normal)
        btnEvent.setTitleColor(UIColor.blue, for: UIControlState.normal)
        btnEvent.addTarget(self, action: #selector(btnEventClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btnEvent)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func btnEventClick() {
        AppDelegate.slideMenuVC?.showRootViewControllerAnimated(animated: true)
        let itemVC = ZWebViewController()
        itemVC.hidesBottomBarWhenPushed = true
        AppDelegate.selectNavVC?.pushViewController(itemVC, animated: true)
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
