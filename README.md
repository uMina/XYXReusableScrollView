# XYXSkimView
走马灯视图：子页面可复用，省内存。调用方法超简单。子页面都是跟屏幕同宽，高度可以自定义。
![效果图](/eee.gif)

## 支持CocoaPods
获取方法：
pod 'XYXSkimView', '~> 0.9.6'

## 初始化：支持xib 和 纯代码两种方式
‘’‘
let skimView = XYXSkimView()
@IBOutlet weak var xibSkimView: XYXSkimView!
’‘’

## 初始设置
‘’‘
skimView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 80)
skimView.dataSource = self
view.addSubview(skimView)
skimView.register(DemoView.self, forCellReuseIdentifier: "DemoView")    //注册子页面

xibSkimView.register(DemoView.self, forCellReuseIdentifier: "DemoView") //注册子页面
xibSkimView.dataSource = self
’‘’

## 实现委托
'''
func numberOfRows(in skimView: XYXSkimView) -> Int
func skimView(_ skimView: XYXSkimView, cellForRowAt index: Int) -> XYXSkimViewCell
'''

可下载Demo查看委托实现代码
