# ZMainSlideMenu

iOS view controller, shows left and right views by pressing button or gesture.

## Preview

<img src="https://github.com/Daniel-zww/ZImageResources/blob/master/ZMainSlideMenu/1.png?raw=true" width="285" height="500"/> <img src="https://github.com/Daniel-zww/ZImageResources/blob/master/ZMainSlideMenu/2.png?raw=true" width="285" height="500"/>

### Pod

pod 'ZMainSlideMenu'

### With source code

```swift
import ZMainSlideMenu
```

## Usage

### Initialization

You can use view controllers or views to initialize ZMainSlideMenu:
```swift
        // StoryBoard初始化
        let slideMenuVC = self.window?.rootViewController as? ZMainSlideMenu
        if let slideMenuVC = slideMenuVC {
            let rootVC = self.getVCWithIdentifier(identifier: "SD_MainVC_ID")
            self.tabbarMainVC = rootVC as? ZMainViewController
            slideMenuVC.setRootViewController(rootViewController: rootVC)
            
            let leftVC = self.getVCWithIdentifier(identifier: "SD_LeftVC_ID")
            slideMenuVC.setLeftViewController(leftViewController: leftVC)
            
            //let rightVC = self.getVCWithIdentifier(identifier: "SD_RightVC_ID")
            //slideMenuVC.setRightViewController(rightViewController: rightVC)
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
```
