//
//  ZFirstViewController.swift
//  ZMainSlideMenuDemo
//
//  Created by Daniel on 15/05/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ZFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLeftEvent(_ sender: Any) {
        AppDelegate.slideMenuVC?.showLeftViewControllerAnimated(animated: true)
    }

    @IBAction func btnRightEvent(_ sender: Any) {
        AppDelegate.slideMenuVC?.showRightViewControllerAnimated(animated: true)
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
