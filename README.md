# JHTabBarController
支持Lottie动画的UITabBarController。

lottie imageView同时存在如果有Lottie仓库会用Lottie隐藏ImageView，如果工程没Lottie仓库则只展示imageView
只有title会居中展示
只有image或者只有lottie都会居中展示

不喜欢默认样式可以重写 JHTabBarItemContentView



## 安装
```
支持ios11以上版本，swift5支持
默认
pod 'JHTabBarController'
使用Lottie
pod 'JHTabBarController/Lottie'
```
## 使用

```
var image  					默认icon
var selectedImage  			选中状态icon
var title  					标题
var lottieName: 				Lottie文件名称
var textFontSize				标题字体大小
var textColor					标题未选中颜色
var selectedTextColor			标题选中颜色
var renderingMode: Bool 		icon是否使用图片自带颜色
var iconColor					icon使用自定义颜色  默认颜色
var selectedIconColor			icon使用自定义颜色  选中颜色

```

纯代码创建：
```
        let v1 = ViewController()
        let item1 = UITabBarItem()
        item1.image = UIImage.init(named: "tab_chat_nor")
        item1.selectedImage = UIImage.init(named: "tab_chat_hi")
        item1.title = "123"
        v1.tabBarItem = item1
        let v2 = ViewController()
        let item2 = UITabBarItem()
        item2.image = UIImage.init(named: "tab_home_nor")
        item2.selectedImage = UIImage.init(named: "tab_home_hi")
        v2.tabBarItem = item2
        let v3 = ViewController()
        let item3 = UITabBarItem()
        item3.image = UIImage.init(named: "tab_mine_nor")
        item3.selectedImage = UIImage.init(named: "tab_mine_hi")
        item3.lottieName = "03"
        v3.tabBarItem = item3
        let nav1 = UINavigationController.init(rootViewController: v1)
        let nav2 = UINavigationController.init(rootViewController: v2)
        let nav3 = UINavigationController.init(rootViewController: v3)
        
        let tab = JHTabBarController()
        
        tab.viewControllers = [nav1,nav2,nav3]

设置默认选中第几个form 程序启动默认选中第零个
        tab.setSelectIndex(from: 0, to: 2)
        
        let windowScene = scene as! UIWindowScene
        window? = UIWindow.init(windowScene: windowScene)
        window?.frame = windowScene.coordinateSpace.bounds
        window?.makeKeyAndVisible()
        window?.rootViewController = tab
        window?.backgroundColor = .white
```

纯代码参见Demo **SceneDelegate**  放开注释运行即可
 Storyboard用法参见**Main.storyboardstorstor**

<source id="mp4" src="1.mp4" type="video/mp4">

### 安装

#### cocoapods导入

`pod 'Swift_Form'`

#### SPM导入

`https://github.com/jackiehu/SwiftyForm`

#### 手动导入