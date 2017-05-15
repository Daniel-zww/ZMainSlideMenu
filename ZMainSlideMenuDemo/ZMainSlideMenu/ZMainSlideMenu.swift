//
//  ZMainSlideMenu.swift
//  ZMainSlideMenuDemo
//
//  Created by Daniel on 12/05/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

/// 菜单的显示区域占屏幕宽度的百分比
fileprivate let kMenuWidthScale: CGFloat = 0.8
/// 遮罩层最高透明度
fileprivate let kMaxCoverAlpha: CGFloat = 0.3

/// 左右添加视图-支持仅单边滑动
class ZMainSlideMenu: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - PublicAttribute
    
    /// 主视图
    public var rootVC: UIViewController? = nil
    /// 左侧视图
    public var leftVC: UIViewController? = nil
    /// 右侧视图
    public var rightVC: UIViewController? = nil
    /// 菜单宽度
    public var menuWidth: CGFloat {
        return kMenuWidthScale * self.view.bounds.size.width
    }
    /// 空白宽度
    public var emptyWidth: CGFloat {
        return self.view.bounds.size.width - self.menuWidth
    }
    
    // MARK: - PraviteAttribute
    
    /// 原始坐标
    private var originalPoint: CGPoint = CGPoint.zero
    /// 遮罩View
    private var coverView: UIView? = nil
    /// 拖拽手势
    private var pan: UIPanGestureRecognizer? = nil
    
    // MARK: - SuperMethod
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fatalError("NSCoding not supported")
    }
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    convenience init(rootViewController: UIViewController) {
        self.init(nibName: nil, bundle: nil)
        self.rootVC = rootViewController
        self.addChildViewController(self.rootVC!)
        self.view.addSubview(self.rootVC!.view)
        self.rootVC?.didMove(toParentViewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pan = UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:)))
        self.pan?.delegate = self
        self.view.addGestureRecognizer(self.pan!)
        
        self.coverView = UIView(frame: self.view.bounds)
        self.coverView?.backgroundColor = UIColor.black
        self.coverView?.alpha = 0
        self.coverView?.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(sender:)))
        self.coverView?.addGestureRecognizer(tap)
        self.rootVC?.view.addSubview(self.coverView!)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateLeftMenuFrame()
        self.updateRightMenuFrame()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        coverView = nil
        pan = nil
        rightVC = nil
        leftVC = nil
        rootVC = nil
    }
    override var shouldAutorotate: Bool {
        return false
    }
    // MARK: - PraviteMethod
    
    private func setLeftViewController(leftViewController: UIViewController) {
        self.leftVC = leftViewController
        self.addChildViewController(self.leftVC!)
        self.view.insertSubview(self.leftVC!.view, at: 0)
        self.leftVC?.didMove(toParentViewController: self)
    }
    private func setRightViewController(rightViewController: UIViewController) {
        self.rightVC = rightViewController
        self.addChildViewController(self.rightVC!)
        self.view.insertSubview(self.rightVC!.view, at: 0)
        self.rightVC?.didMove(toParentViewController: self)
    }
    private func setSlideEnabled(slideEnabled: Bool) {
        self.pan?.isEnabled = slideEnabled
    }
    private func slideEnabled() -> Bool {
        return self.pan == nil ? false : self.pan!.isEnabled
    }
    //显示主视图
    private func showRootViewControllerAnimated(animated: Bool) {
        if let rootVC = self.rootVC {
            weak var weakSelf = self
            UIView.animate(withDuration: self.animationDurationAnimated(animated: animated), animations: {
                var frame = rootVC.view.frame
                frame.origin.x = 0
                rootVC.view.frame = frame
                weakSelf?.updateLeftMenuFrame()
                weakSelf?.updateRightMenuFrame()
                weakSelf?.coverView?.alpha = 0
            }, completion: { (finished) in
                weakSelf?.coverView?.isHidden = true
            })
        }
    }
    //显示左侧菜单
    private func showLeftViewControllerAnimated(animated: Bool) {
        if let leftVC = self.leftVC, let rootVC = self.rootVC {
            self.coverView?.isHidden = false
            if let rightVC = self.rightVC {
                self.view.sendSubview(toBack: rightVC.view)
            }
            weak var weakSelf = self
            UIView.animate(withDuration:self.animationDurationAnimated(animated: animated), animations: {
                let centerX = rootVC.view.bounds.size.width / 2 + self.menuWidth
                rootVC.view.center = CGPoint(x: centerX, y: rootVC.view.center.y)
                leftVC.view.frame = self.view.bounds
                weakSelf?.coverView?.alpha = kMaxCoverAlpha
            })
        }
    }
    //显示右侧菜单
    private func showRightViewControllerAnimated(animated: Bool) {
        if let rightVC = self.rightVC, let rootVC = self.rootVC {
            self.coverView?.isHidden = false
            if let leftVC = self.leftVC {
                self.view.sendSubview(toBack: leftVC.view)
            }
            weak var weakSelf = self
            UIView.animate(withDuration:self.animationDurationAnimated(animated: animated), animations: {
                let centerX = rootVC.view.bounds.size.width / 2 - self.menuWidth
                rootVC.view.center = CGPoint(x: centerX, y: rootVC.view.center.y)
                rightVC.view.frame = self.view.bounds
                weakSelf?.coverView?.alpha = kMaxCoverAlpha
            })
        }
    }
    //改变左侧菜单位置
    private func updateLeftMenuFrame() {
        if let leftVC = self.leftVC, let rootVC = self.rootVC {
            let centerX: CGFloat = (rootVC.view.frame.minX - self.emptyWidth) / 2
            leftVC.view.center = CGPoint(x: centerX, y: leftVC.view.center.y)
        }
    }
    //改变右侧菜单位置
    private func updateRightMenuFrame() {
        if let rightVC = self.rightVC, let rootVC = self.rootVC {
            let centerX: CGFloat = self.view.bounds.size.width + (rootVC.view.frame.maxX - self.emptyWidth) / 2
            rightVC.view.center = CGPoint(x: centerX, y: rightVC.view.center.y)
        }
    }
    //动画时长
    private func animationDurationAnimated(animated: Bool) -> TimeInterval {
        return animated == true ? 0.25 : 0
    }
    //单击遮罩层
    @objc private func tapGesture(sender: UIGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.ended {
            self.showRootViewControllerAnimated(animated: true)
        }
    }
    //改变位置
    @objc private func panGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            if let rootVC = self.rootVC {
                self.originalPoint = rootVC.view.center
            }
        case .changed:
            self.panChanged(sender: sender)
        case .ended:
            if let rootVC = self.rootVC {
                if rootVC.view.frame.minX > self.menuWidth / 2 {
                    self.showLeftViewControllerAnimated(animated: true)
                } else if rootVC.view.frame.maxX < (self.menuWidth/2 + self.emptyWidth) {
                    self.showRightViewControllerAnimated(animated: true)
                } else {
                    self.showRootViewControllerAnimated(animated: true)
                }
            }
        default: break;
        }
    }
    //开始改变位置
    private func panChanged(sender: UIPanGestureRecognizer) {
        //拖拽的距离
        let translation = sender.translation(in: self.view)
        if let rootVC = self.rootVC {
            //移动主控制器
            rootVC.view.center = CGPoint(x: (self.originalPoint.x + translation.x), y: self.originalPoint.y)
            if self.rightVC != nil && rootVC.view.frame.minX <= 0 {
                rootVC.view.frame = self.view.bounds
            }
            if self.leftVC != nil && rootVC.view.frame.minX >= 0 {
                rootVC.view.frame = self.view.bounds
            }
            //滑动到边缘位置后不可以继续滑动
            
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        //设置Navigation子视图不可拖拽
        if let rootVC = self.rootVC {
            switch rootVC {
            case is UINavigationController:
                let navigationController = rootVC as! UINavigationController
                if navigationController.interactivePopGestureRecognizer != nil {
                    if navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer!.isEnabled {
                        return false
                    }
                }
            default: break
            }
        }
        //如果Tabbar的当前视图是UINavigationController，设置UINavigationController子视图不可拖拽
        if let rootVC = self.rootVC {
            switch rootVC {
            case is UITabBarController:
                let tabbarController = rootVC as! UITabBarController
                let selectVC = tabbarController.selectedViewController
                switch selectVC {
                case is UINavigationController:
                    let navigationController = selectVC as! UINavigationController
                    if navigationController.interactivePopGestureRecognizer != nil {
                        if navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer!.isEnabled {
                            return false
                        }
                    }
                default: break
                }
            default: break
            }
        }
        //设置拖拽响应范围
        switch gestureRecognizer {
        case is UIPanGestureRecognizer:
            //拖拽响应范围是距离边界是空白位置宽度
            let actionWidth = self.emptyWidth
            let point = touch.location(in: gestureRecognizer.view)
            if point.x <= actionWidth || point.x > self.view.bounds.size.width - actionWidth {
                return true
            } else {
                return false
            }
        default: break
        }
        return true
    }

}

/// 扩展UIViewController
extension UIViewController {
    var zSlideMenu: ZMainSlideMenu? {
        var slideMenu = self.parent
        if slideMenu != nil {
            while (slideMenu == nil) {
                if slideMenu is ZMainSlideMenu {
                    return slideMenu as? ZMainSlideMenu
                } else if slideMenu?.parent != nil && slideMenu?.parent != slideMenu {
                    slideMenu = slideMenu?.parent
                } else {
                    return nil
                }
            }
        }
        return nil
    }
}



