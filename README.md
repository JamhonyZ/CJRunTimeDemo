# CJRunTimeDemo

本demo通过一些runtime使用技巧，对以下三种常用控件进行功能拓展。

实现一：UIButton分类

支持block回调，支持按钮间隔时长设置，支持图片文字frame设置，支持热响应区域设置。

实现二：UIView分类

支持block手势单击和长按。支持占位功能，开放常用无网络，无数据，加载失败 三种常用类型。开放自定义图片和提示文字。具体可参考demo。

实现三：UILabel分类 和 CJLabel父类

支持行间距定制，最大行数设置。

截图如下 截图如下  截图如下  截图如下  截图如下  截图如下  截图如下


![image](https://github.com/JamhonyZ/CJRunTimeDemo/blob/master/CJRunTimeDemo/ScreenShoot/ScreenShot0.png)

![image](https://github.com/JamhonyZ/CJRunTimeDemo/blob/master/CJRunTimeDemo/ScreenShoot/ScreenShot1.png)

![image](https://github.com/JamhonyZ/CJRunTimeDemo/blob/master/CJRunTimeDemo/ScreenShoot/ScreenShot2.png)


注明：
上述实现部分从其他优秀程序猿的博文里转抄，我只是自己又敲了一遍并拓展实用性更强，来学习和记录而已。

部分原文链接：

http://blog.csdn.net/uxyheaven/article/details/48009197

https://github.com/casscqt/lineSpaceTextHeightDemo


/**代码整合了一下便于自己备份记录学习**\


//以下链接，均为github上 仿照市面上成熟应用的小模块功能。

https://github.com/Eastwu5788/XMLYFM   高仿喜马拉雅FM

https://github.com/gsdios/GSD_WeiXin   高仿微信

https://github.com/NoCodeNoWife/LLRiseTabBar-iOS  仿淘宝闲鱼的 TabBar

https://github.com/tubie/JFMeiTuan  高仿美团
