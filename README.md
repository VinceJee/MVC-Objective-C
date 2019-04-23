# MVC-Objective-C
This MVC Structure(use Objective-C developer language.) swift can see @onevcat [https://gist.github.com/onevcat/9e08111cebb1967cb96a737ed40f9f14]

### 根据自己对(@onevcat)大牛的MVC的博文及demo，使用Objective-C写的。不对的地方，欢迎指正~

### [关于应用使用架构]。
说到MVC，还是要提一下斯坦福大学的老师的这张经典图示。
![MVC架构详解图](https://ws3.sinaimg.cn/large/006tNc79gy1g28xnjngy2j30zk0l21kx.jpg)

> 值得提出的是，在实际的项目开发中，很大一部分开发人员都不能做到正确的使用 MVC架构来进行开发工作。例如在使用 TableView 开发中，常见会把 Model 直接传入 View 中。


- Model 和 View 之间是不能直接进行通信的，必须要通过 Controller 来进行通信。

- Controller 直接和 Model 通信，而 Model 则需要通过 Notification 与 KVO 与 Controller 进行间接通信。 

- Controller 直接与 View 通信，通过 outlet 操作 View 中的控件；而 View 通过 action 向 Controller 传递事件，进而改变 Model，Model 变化再经由 Controller 改变 View。Controller 是作为 View 的 delegate/datasource，以同步 View 与 Controller。

- @onevcat大牛这里的解释更容易理解一点。[**UI 操作 -> 经由 Controller 进行模型变更 -> 经由 Controller 将当前模型“映射”为 UI 状态，这个数据流动方向是严格可预测的 (并且应当时刻牢记需要保持这个循环)。这大大减少了 Controller 层的负担。**](#markdown-pane).
