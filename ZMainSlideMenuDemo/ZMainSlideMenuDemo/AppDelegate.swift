//
//  AppDelegate.swift
//  ZMainSlideMenuDemo
//
//  Created by Daniel on 12/05/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyBoard: UIStoryboard?
    /// 左右滑动视图
    var slideMenuVC: ZMainSlideMenu?
    /// 主视图
    var tabbarMainVC: ZMainViewController?
    /// 主视图
    public static var tabBarMainVC: ZMainViewController? {
        return (UIApplication.shared.delegate as! AppDelegate).tabbarMainVC
    }
    /// 主视图选中子视图
    public static var selectNavVC: ZNavigationViewController? {
        return self.tabBarMainVC?.selectedViewController as? ZNavigationViewController
    }
    /// 左右滑动视图
    public static var slideMenuVC: ZMainSlideMenu? {
        return (UIApplication.shared.delegate as! AppDelegate).slideMenuVC
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // StoryBoard初始化
        let slideMenuVC = self.window?.rootViewController as? ZMainSlideMenu
        if let slideMenuVC = slideMenuVC {
            let rootVC = self.getVCWithIdentifier(identifier: "SD_MainVC_ID")
            self.tabbarMainVC = rootVC as? ZMainViewController
            slideMenuVC.setRootViewController(rootViewController: rootVC)
            
            let leftVC = self.getVCWithIdentifier(identifier: "SD_LeftVC_ID")
            slideMenuVC.setLeftViewController(leftViewController: leftVC)
            
            let rightVC = self.getVCWithIdentifier(identifier: "SD_RightVC_ID")
            slideMenuVC.setRightViewController(rightViewController: rightVC)
        }
        self.slideMenuVC = slideMenuVC
        
        // 代码初始化
        /*
        let rootVC = self.getVCWithIdentifier(identifier: "SD_MainVC_ID")
        self.tabbarMainVC = rootVC as? ZMainViewController
        self.slideMenuVC = ZMainSlideMenu(rootViewController: rootVC)
         
        let leftVC = self.getVCWithIdentifier(identifier: "SD_LeftVC_ID")
        self.slideMenuVC?.setLeftViewController(leftViewController: leftVC)
        
        let rightVC = self.getVCWithIdentifier(identifier: "SD_RightVC_ID")
        self.slideMenuVC?.setRightViewController(rightViewController: rightVC)
         
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.slideMenuVC
        */
        
        return true
    }
    /// 根据ID获取Main里面的VC
    func getVCWithIdentifier(identifier: String) -> UIViewController {
        if self.storyBoard == nil {
           self.storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        }
        return self.storyBoard!.instantiateViewController(withIdentifier: identifier)
    }
    
    // MARK: - PublicMethod
    
}

