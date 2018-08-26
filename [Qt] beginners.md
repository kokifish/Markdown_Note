[TOC]



```cpp
//snippet
qDebug() << "qDebug only";
```





# Overview

Qt 是一个跨平台的框架。跨平台 GUI 通常有三种实现策略

1.  **API 映射**：API 映射是说，界面库使用同一套 API，将其映射到不同的底层平台上面。大体相当于将不同平台的 API 提取公共部分。比如说，将 Windows 平台上的按钮控件和 Mac OS 上的按钮组件都取名为 Button。当你使用 Button 时，如果在 Windows 平台上，则编译成按钮控件；如果在 Mac OS 上，则编译成按钮组件。这么做的好处是，所有组件都是原始平台自有的，外观和原生平台一致；缺点是，编写库代码的时候需要大量工作用于适配不同平台，并且，只能提取相同部分的 API。比如 Mac OS 的文本框自带拼写检测，但是 Windows 上面没有，则不能提供该功能。这种策略的典型代表是 wxWidgets。这也是一个标准的 C++ 库，和 Qt 一样庞大。它的语法看上去和 MFC 类似，有大量的宏。据说，一个 MFC 程序员可以很容易的转换到 wxWidgets 上面来
2.  **API 模拟**：前面提到，API 映射会“缺失”不同平台的特定功能，而 API 模拟则是解决这一问题。不同平台的有差异 API，将使用工具库自己的代码用于模拟出来。按照前面的例子，Mac OS 上的文本框有拼写检测，但是 Windows 的没有。那么，工具库自己提供一个拼写检测算法，让 Windows 的文本框也有相同的功能。API 模拟的典型代表是 wine —— 一个 Linux 上面的 Windows 模拟器。它将大部分 Win32 API 在 Linux 上面模拟了出来，让 Linux 可以通过 wine 运行 Windows 程序。由此可以看出，API 模拟最大优点是，应用程序无需重新编译，即可运行到特定平台上。另外一个例子是微软提供的 DirectX，这个开发库将屏蔽掉不同显卡硬件所提供的具体功能。使用这个库，你无需担心硬件之间的差异，如果有的显卡没有提供该种功能，SDK 会使用软件的方式加以实现
3.  **GUI 模拟**：任何平台都提供了图形绘制函数，例如画点、画线、画面等。有些工具库利用这些基本函数，在不同绘制出自己的组件，这就是 GUI 模拟。GUI 模拟的工作量无疑是很大的，因为需要使用最基本的绘图函数将所有组件画出来；并且这种绘制很难保证和原生组件一模一样。但是，这一代价带来的优势是，可以很方便的修改组件的外观——只要修改组件绘制函数即可。很多跨平台的 GUI 库都是使用的这种策略，例如 gtk+（这是一个 C 语言的图形界面库。使用 C 语言很优雅地实现了面向对象程序设计。不过，这也同样带来了一个问题——使用大量的类型转换的宏来模拟多态，并且它的函数名一般都比较长，使用下划线分割单词，看上去和 Linux 如出一辙。gtk+ 并不是模拟的原生界面，而有它自己的风格，所以有时候就会和操作系统的界面格格不入。），Swing 以及我们的 Qt



Qt 和 wxWidgets 一样，也是一个标准的 C++ 库。但是它的语法类似于 Java 的 Swing，十分清晰，而且使用信号槽（signal/slot）机制

现在 Qt 的开源版本使用的是 GPLv3 以及 LGPL 协议。这意味着，你可以将 Qt 作为一个库连接到一个闭源软件里面。可以说，Qt 协议的争议已经不存在了



```cpp
#include <QApplication>//main.cpp
#include <QLabel>
 
int main(int argc, char *argv[]){
    QApplication app(argc, argv);//创建一个QApplication类的实例

    QLabel label("Hello, world");
    label.show();

    return app.exec();
}//运行效果
一个小label显示Hello, world
```

>   Qt程序一般以创建QApplication对象开始//GUI 程序是QApplication，非 GUI 程序是QCoreApplication。QApplication实际上是QCoreApplication的子类
>
>   后面才是实际业务的代码
>
>   而这个QApplication对象管理Qt程序的生命周期，开启事件循环
>
>   不建议使用指针 因为用指针形式可能导致内存泄漏//当`exec()`退出时，label无法delete, 但这在早期版本的Qt可能存在

Qt基础模块分为:

-   **Qt Core**，提供核心的非 GUI 功能，所有模块都需要这个模块。这个模块的类包括了动画框架、定时器、各个容器类、时间日期类、事件、IO、JSON、插件机制、智能指针、图形（矩形、路径等）、线程、XML 等。所有这些类都可以通过 <QtCore> 头文件引入。
-   **Qt Gui**，提供 GUI 程序的基本功能，包括与窗口系统的集成、事件处理、OpenGL 和 OpenGL ES 集成、2D 图像、字体、拖放等。这些类一般由 Qt 用户界面类内部使用，当然也可以用于访问底层的 OpenGL ES 图像 API。Qt Gui 模块提供的是所有图形用户界面程序都需要的通用功能。
-   **Qt Multimedia**，提供视频、音频、收音机以及摄像头等功能。这些类可以通过 <QtMultimedia> 引入，而且需要在 pro 文件中添加 QT += multimedia。
-   **Qt Network**，提供跨平台的网络功能。这些类可以通过 <QtNetwork> 引入，而且需要在 pro 文件中添加 QT += network。
-   **Qt Qml**，提供供 QML（一种脚本语言，也提供 JavaScript 的交互机制） 使用的 C++ API。这些类可以通过 <QtQml> 引入，而且需要在 pro 文件中添加 QT += qml。
-   **Qt Quick**，允许在 Qt/C++ 程序中嵌入 Qt Quick（一种基于 Qt 的高度动画的用户界面，适合于移动平台开发）。这些类可以通过 <QtQuick> 引入，而且需要在 pro 文件中添加 QT += quick。
-   **Qt SQL**，允许使用 SQL 访问数据库。这些类可以通过 <QtSql> 引入，而且需要在 pro 文件中添加 QT += sql。
-   **Qt Test**，提供 Qt 程序的单元测试功能。这些类可以通过 <QtTest> 引入，而且需要在 pro 文件中添加 QT += testlib。
-   **Qt Webkit**，基于 WebKit2 的实现以及一套全新的 QML API（顺便说一下，Qt 4.8 附带的是 QtWebkit 2.2）

Qt扩展模块:

-   **Qt 3D**，提供声明式语法，在 Qt 程序中可以简单地嵌入 3D 图像。Qt 3D 为 Qt Quick 添加了 3D 内容渲染。Qt 3D 提供了 QML 和 C++ 两套 API，用于开发 3D 程序。
-   **Qt Bluetooth**，提供用于访问蓝牙无线设备的 C++ 和 QML API。
-   **Qt Contacts**，用于访问地址簿或者联系人数据库的 C++ 和 QML API。
-   **Qt Concurrent**，封装了底层线程技术的类库，方便开发多线程程序。
-   **Qt D-Bus**，这是一个仅供 Unix 平台使用的类库，用于利用 D-Bus 协议进行进程间交互。
-   **Qt Graphical Effects**，提供一系列用于实现图像特效的类，比如模糊、锐化等。
-   **Qt Image Formats**，支持图片格式的一系列插件，包括 TIFF、MNG、TGA 和 WBMP。
-   **Qt JS Backend**，该模块没有公开的 API，是 V8 JavaScript 引擎的一个移植。这个模块仅供 QtQml 模块内部使用。
-   **Qt Location**，提供定位机制、地图和导航技术、位置搜索等功能的 QML 和 C++ API。
-   **Qt OpenGL**，方便在 Qt 应用程序中使用 OpenGL。该模块仅仅为了程序从 Qt 4 移植到 Qt 5 的方便才保留下来，如果你需要在新的 Qt 5 程序中使用 OpenGL 相关技术，需要使用的是 QtGui 模块中的 QOpenGL。
-   **Qt Organizer**，使用 QML 和 C++ API 访问组织事件（organizer event）。organizer API 是 Personal Information Management API 的一部分，用于访问 Calendar 信息。通过 Organizer API 可以实现：从日历数据库访问日历时间、导入 iCalendar 事件或者将自己的事件导出到 iCalendar。
-   **Qt Print Support**，提供对打印功能的支持。
-   **Qt Publish and Subscribe**，为应用程序提供对项目值的读取、导航、订阅等的功能。
-   **Qt Quick 1**，从 Qt 4 移植过来的 QtDeclarative 模块，用于提供与 Qt 4 的兼容。如果你需要开发新的程序，需要使用 QtQuick 模块。
-   **Qt Script**，提供脚本化机制。这也是为提供与 Qt 4 的兼容性，如果要使用脚本化支持，请使用 QtQml 模块的 QJS* 类。
-   **Qt Script Tools**，为使用了 Qt Script 模块的应用程序提供的额外的组件。
-   **Qt Sensors**，提供访问各类传感器的 QML 和 C++ 接口。
-   **Qt Service Framework**，提供客户端发现其他设备的服务。Qt Service Framework 为在不同平台上发现、实现和访问服务定义了一套统一的机制。
-   **Qt SVG**，提供渲染和创建 SVG 文件的功能。
-   **Qt System Info**，提供一套 API，用于发现系统相关的信息，比如电池使用量、锁屏、硬件特性等。
-   **Qt Tools**，提供了 Qt 开发的方便工具，包括 Qt CLucene、Qt Designer、Qt Help 以及 Qt UI Tools 。
-   **Qt Versit**，提供了对 Versit API 的支持。Versit API 是 Personal Information Management API 的一部分，用于 QContacts 和 vCard 以及 QOrganizerItems 和 iCalendar 之间的相互转换。
-   **Qt Wayland**，仅用于 Linux 平台，用于替代 QWS，包括 Qt Compositor API（server）和 Wayland 平台插件（clients）。
-   **Qt WebKit**，从 Qt 4 移植来的基于 WebKit1 和 QWidget 的 API。
-   **Qt Widgets**，使用 C++ 扩展的 Qt Gui 模块，提供了一些界面组件，比如按钮、单选框等。
-   **Qt XML**，SAX 和 DOM 的 C++ 实现。该模块已经废除，请使用 QXmlStreamReader/Writer。
-   **Qt XML Patterns**，提供对 XPath、XQuery、XSLT 和 XML Schema 验证的支持

由于 Qt 的扩展模块并不是 Qt 必须安装的部分，因此 Qt 在未来版本中可能会提供更多的扩展模块



### signal & slot

-   观察者模式
-   比如，按钮检测到自己被点击了一下，它就会发出一个信号（signal）。这种发出是没有目的的，类似广播。如果有对象对这个信号感兴趣，它就会使用连接（connect）函数，意思是，用自己的一个函数（称为槽 slot ）来处理这个信号。也就是说，当信号发出时，被连接的槽函数slot会自动被回调。这就类似观察者模式：当发生了感兴趣的事件，某一个操作就会被自动触发
-   Qt 的信号槽使用了额外的处理来实现，并不是 GoF 经典的观察者模式的实现方式
-   slot 可以自己设计 //Qt 框架的设计思路之一
-   slot 不是GUI module提供，而是Qt 核心特性之一，因此可在控制台使用信号槽



```cpp
#include <QApplication>
#include <QPushButton>
 
int main(int argc, char *argv[]){
    QApplication app(argc, argv);
 
    QPushButton button("Quit");
//QMetaObject::Connection connect(const QObject *, PointerToMemberFunction, Functor);
    QObject::connect(&button, &QPushButton::clicked, &QApplication::quit);
    button.show();

    return app.exec();
}
```

-   connect()参数



1.  发出信号的对象 sender

2.  发送对象发出的信号 signal

3.  接收信号的对象 receiver

4.  接收对象在接收到信号之后所需要调用的函数 slot//原义: 插槽 位置 水沟 硬币投币口

也就是说，当 sender 发出了 signal 信号之后，会自动调用 receiver 的 slot 函数

```cpp
//connect常用形式
connect(sender,   signal,
        receiver, slot);

QMetaObject::Connection connect(const QObject *, const char *,
                                const QObject *, const char *,
                                Qt::ConnectionType);
 
QMetaObject::Connection connect(const QObject *, const QMetaMethod &,
                                const QObject *, const QMetaMethod &,
                                Qt::ConnectionType);
 
QMetaObject::Connection connect(const QObject *, const char *,
                                const char *,
                                Qt::ConnectionType) const;
 
QMetaObject::Connection connect(const QObject *, PointerToMemberFunction,
                                const QObject *, PointerToMemberFunction,
                                Qt::ConnectionType)
//Functor: 可以接受 static 函数、全局函数以及 Lambda 表达式
QMetaObject::Connection connect(const QObject *, PointerToMemberFunction,
                                Functor);
```





##### 自定义信号槽

-   只有继承自QObject类才具有signals信号slot槽能力
-   凡是QObject类，不论直接子类还是间接子类，都应在类声明中首先添加Q_OBJECT macro
-   Q_OBJECT macro的展开能够提供信号槽机制、国际化机制以及不基于 C++ RTTI 的反射能力
-   sender and receiver都必须是QObject的子类//槽函数是全局函数、Lambda 表达式等无需接收者的时候除外
-   ​



**moc **

-   Q_OBJECT macro由moc做特殊处理，实际上不仅是宏展开这么简单
-   moc读取标记了Q_OBJECT 的**头文件**，生成以 moc_ 为前缀的文件，比如 a.h 将生成 moc_a.cpp

**signals **

-   signals blocks所列出的，就是该类的信号
-   信号是函数声明，返回void，不需要实现//无法获得信号的返回值，所以无需任何值
-   参数是该类需要让外界知道的数据
-   signals需要在类的外面连接，因此需要在public中
-   信号作为函数名，不需要在cpp中添加任何实现//Qt 程序能够使用普通的 make 进行编译，没有实现的函数名通过编译原因在moc会帮我们实现信号函数所需要的函数体

**emit keyword**

-   emit:  发出 放射 发行 发表
-   使用emit发送信号

##### slot

-   Qt5 中，任何成员函数、static 函数、全局函数和 Lambda 表达式都可以作为槽函数
-   slot函数必须有实现//signals函数不需要
-   槽函数就是普通的成员函数，因此会受到 public、private 等访问控制符的影响
-   slot函数的参数可以比signals的多

```cpp
//基于Qt的信号槽机制，不需要观察者的容器，不需要注册对象，实现观察者模式

////////// newspaper.h//moc处理后生成moc_newspaper.h//在C++预处理器之前
#include <QObject>
class Newspaper : public QObject {//inheritance from QObject
	Q_OBJECT//必须在第一行(此处)添加
public:
	Newspaper(const QString & name) :m_name(name) {}
	void send() {//发出newPaper()信号(in signals blocks)
		emit newPaper(m_name);//emit keyword/macro: Qt对C++的扩展
	}//emit发送信号

signals://列出该类的信号
	void newPaper(const QString &name);//signal无需实现
      
private:
	QString m_name;
};

////////// reader.h//moc处理后生成moc_reader.h//在C++预处理器之前
#include <QObject>
#include <QDebug>

class Reader : public QObject {//inheritance from QObject
	Q_OBJECT//必须在第一行(此处)添加
public:
	Reader() {}
	//将被connect来作为slot function
	void receiveNewspaper(const QString & name) {
		qDebug() << "Receives Newspaper: " << name;
	}
};

////////// main.cpp
#include <QCoreApplication>
#include "newspaper.h"
#include "reader.h"

int main(int argc, char *argv[]) {
	QCoreApplication app(argc, argv);
	//创建Newspaper和Reader的两个对象
	Newspaper newspaper("Newspaper A");
	Reader reader;
	QObject::connect(&newspaper, &Newspaper::newPaper, &reader, &Reader::receiveNewspaper);
	newspaper.send();//发出信号，由于connect，emit信号newPaper后，自动调用reader的slot: receiveNewspaper 打印出语句
	return app.exec();//exec()开始 Qt 的事件循环
}
```

>   我们提到了“槽函数是普通的成员函数，作为成员函数，会受到 public、private、protected 的影响”，public、private 这些修饰符是供编译器在编译期检查的，因此其影响在于编译期。对于 Qt4 的信号槽连接语法，其连接是在运行时完成的，因此即便是 private 的槽函数也是可以作为槽进行连接的。但是，如果你使用了 Qt5 的新语法，新语法提供了编译期检查（取函数指针），因此取 private 函数的指针是不能通过编译的

>   https://www.devbean.net/2012/09/qt-study-road-2-deep-qt5-signals-slots-syntax/



### pro文件





```cpp
QT += core gui//定义QT,需要使用那些module
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets//Qt主版本号QT_MAJOR_VERSION大于4，即Qt 5，则需要另外添加widgets//Qt5中，所有组件都在widgets module定义
 
TARGET    = ProName//生成的程序的名字
TEMPLATE  = app//生成 makefile 所使用的模板
 //比如 app 编译成一个可执行程序，而 lib 编译成一个链接库（默认是dll）
SOURCES  += main.cpp \ //项目所需的cpp文件
        mainwindow.cpp
 
HEADERS  += mainwindow.h //项目所需的header
```



![](http://op4fcrj8y.bkt.clouddn.com/18-1-27/89692293.jpg)





`menuBar()`、`toolBar()`和`statusBar()`三个是`QMainWindow`的函数，用于创建并返回菜单栏、工具栏和状态栏





-   QSpinBox 只能输入数字的输入框，带有上下箭头的步进按钮
-   QSlider 带有滑块的滑竿



-   `QHBoxLayout`：按照水平方向从左到右布局；
-   `QVBoxLayout`：按照竖直方向从上到下布局；
-   `QGridLayout`：在一个网格中进行布局，类似于 HTML 的 table；
-   `QFormLayout`：按照表格布局，每一行前面是一段文本，文本后面跟随一个组件（通常是输入框），类似 HTML 的 form；
-   `QStackedLayout`：层叠的布局，允许我们将几个组件按照 Z 轴方向堆叠，可以形成向导那种一页一页的效果




### 窗口 & 部件

-   窗口：相对独立的，有子窗口和父窗口之分，主要特点就是窗口有完整的边框，把没有嵌入到其他部件中的部件称为窗口，一般的窗口都有边框和标题栏
-   部件：必须依赖于父窗口而存在，依赖性较强，出现在父窗体的界面内部，它们嵌入在别的窗口中

```cpp
//QWidget constructor
QWidget(QWidget *parent=0,Qt::WindowFlags f=0);
```



判断一个控件是否是窗体先根据参数parent的指定，要是值为0那么就可以判断其是一个窗口。否则需要根据Qt::WindowFlags枚举类型的值才可以判断其是否为窗口还是部件



---


# QAction

-   用QAction作为动作，这个类代表窗口的一个"动作"




---


# QEvent 事件

-   event drive 事件驱动
-   Qt使用事件队列对所有发出的event进行维护，新event会被追加到event队列尾部
-   必要时，Qt事件可以不进入event队列，直接处理
-   信号一旦发出，对应的slot一定会被执行，但可以用事件过滤器进行过滤
-   Qt的event都是protected的





```cpp
//EventLabel继承QLabel 覆盖mousePressEvent() mouseMoveEvent() MouseReleaseEvent()
//展示了setText的两种不同方法
#include <QApplication>
#include <QLabel>
#include <QMouseEvent>
#include "mainwindow.h"
class EventLabel : public QLabel{
protected:
    void mouseMoveEvent(QMouseEvent *event);
    void mousePressEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
};
 
void EventLabel::mouseMoveEvent(QMouseEvent *event){
    this->setText(QString("<center><h1>Move: (%1, %2)</h1></center>").arg(QString::number(event->x()),QString::number(event->y())));
}
 
void EventLabel::mousePressEvent(QMouseEvent *event){
    this->setText(QString("<center><h1>Press: (%1, %2)</h1></center>").arg(QString::number(event->x()),QString::number(event->y())));
}

void EventLabel::mouseReleaseEvent(QMouseEvent *event){
    QString msg;
    msg.sprintf("<center><h1>Release: (%d, %d)</h1></center>",
                event->x(), event->y());
    this->setText(msg);
}
 
int main(int argc, char *argv[]){
    QApplication a(argc, argv);
 
    EventLabel *label = new EventLabel;
    label->setWindowTitle("MouseEvent Demo");
    label->resize(300, 200);
	label->setMouseTracking(true);//true:追踪鼠标，一开始就追踪 false:一开始不追踪
    label->show();
 
    return a.exec();
}
```

-   QLabel支持HTML代码



warning:

-   **重写事件回调函数时，注意是否需要通过调用父类的同名函数来确保原有实现仍能进行**
-   **事件的传播是在组件层次上面的，而不是依靠类继承机制**





```cpp
class CustomButton : public QPushButton{
    Q_OBJECT
public:
    CustomButton(QWidget *parent) : QPushButton(parent){
    }
protected:
    void mousePressEvent(QMouseEvent *event){
        qDebug() << "CustomButton";
    }
};

class CustomButtonEx : public CustomButton{
    Q_OBJECT
public:
    CustomButtonEx(QWidget *parent) : CustomButton(parent){ }
protected:
    void mousePressEvent(QMouseEvent *event){
		event->ignore();//让event继续传播，父组件CustomWidget也收到这个事件
        qDebug() << "CustomButtonEx";
    }
};
 
class CustomWidget : public QWidget{
    Q_OBJECT
public:
    CustomWidget(QWidget *parent) : QWidget(parent){}
protected:
    void mousePressEvent(QMouseEvent *event){
        qDebug() << "CustomWidget";
    }
};
////////////////////////////////////
class MainWindow : public QMainWindow{
    Q_OBJECT
public:
    MainWindow(QWidget *parent = 0) : QMainWindow(parent){
        CustomWidget *widget = new CustomWidget(this);
        CustomButton *cbex = new CustomButton(widget);
        cbex->setText(tr("CustomButton"));
        CustomButtonEx *cb = new CustomButtonEx(widget);
        cb->setText(tr("CustomButtonEx"));
        QVBoxLayout *widgetLayout = new QVBoxLayout(widget);
        widgetLayout->addWidget(cbex);
        widgetLayout->addWidget(cb);
        this->setCentralWidget(widget);
    }
protected:
    void mousePressEvent(QMouseEvent *event){
        qDebug() << "MainWindow";
    }
};
在一个MainWindow中添加了一个CustomWidget，里面有两个按钮对象：CustomButton和CustomButtonEx。每一个类都重写了mousePressEvent()函数。运行程序点击 CustomButtonEx，结果是 CustomButtonEx
因为重写了鼠标按下的事件，但是并没有调用父类函数或者显式设置accept()或ignore()
在CustomButtonEx的mousePressEvent()第一行增加一句event->ignore() 结果是:
CustomButtonEx
CustomWidget
```

>   `CustomButtonEx`的事件传播给了父组件`CustomWidget`，而不是它的父类`CustomButton`。**事件的传播是在组件层次上面的，而不是依靠类继承机制**





### event()

```cpp
//snippet
bool CustomWidget::event(QEvent *e){
    if (e->type() == QEvent::KeyPress) {
        QKeyEvent *keyEvent = static_cast<QKeyEvent *>(e);
        if (keyEvent->key() == Qt::Key_Tab) {
            qDebug() << "You press tab.";
            return true;
        }
    }
    return QWidget::event(e);
}
```

-   `CustomWidget`是普通的`QWidget`子类
-   重写`event()`函数，有一个`QEvent`对象作为参数，也就是需要转发的事件对象
-   返回值是 bool 。如果传入的事件已被识别并且处理，则返回 true，否则 false。如果返回值是 true，并且，该事件对象设置了`accept()`， Qt 会认为这个事件已经处理完毕，不会再将这个事件发送给其它对象，而是会继续处理事件队列中的下一事件
-   在`event()`函数中，调用事件对象的`accept()`和`ignore()`没有作用，不会影响到事件的传播

QEvent::type() 检查事件的实际类型，返回`QEvent::Type`类型的enum

>   事件过滤器 https://www.devbean.net/2012/10/qt-study-road-2-event-filter/





```cpp
class Label : public QWidget{
public:
    Label(){
        installEventFilter(this);
    }

    bool eventFilter(QObject *watched, QEvent *event){
        if (watched == this) {
            if (event->type() == QEvent::MouseButtonPress) {
                qDebug() << "eventFilter";
            }
        }
        return false;
    }

protected:
    void mousePressEvent(QMouseEvent *){
        qDebug() << "mousePressEvent";
    }

    bool event(QEvent *e){
        if (e->type() == QEvent::MouseButtonPress) {
            qDebug() << "event";
        }
        return QWidget::event(e);
    }
};

class EventFilter : public QObject{
public:
    EventFilter(QObject *watched, QObject *parent = 0) :
        QObject(parent),
        m_watched(watched){}

    bool eventFilter(QObject *watched, QEvent *event){
        if (watched == m_watched) {
            if (event->type() == QEvent::MouseButtonPress) {
                qDebug() << "QApplication::eventFilter";
            }
        }
        return false;
    }

private:
    QObject *m_watched;
};

int main(int argc, char *argv[]){
    QApplication app(argc, argv);
    Label label;
    app.installEventFilter(new EventFilter(&label, &label));//m_watched = label
    label.show();
    return app.exec();
}//Output:点击后
QApplication::eventFilter
eventFilter
event
mousePressEvent
```

调用顺序:

1.  全局事件过滤器
2.  该对象上面的事件过滤器
3.  `event()`函数
4.  特定的事件handler





# QString

-   arg()可以自动替换掉QString中出现的占位符，%号后是占位符的位置



```cpp
//snippet
std::wstring wStr = L"C:\windows\system32\hao123\tianCai\";
QString qStr = QString::fromStdWString(wStr);
qStr.replace("/","\\\\");
wStr = qStr.toStdWString();
```





### QString convert



```cpp
//snippet
#include <string>

using namespace std;

QString qstr;
string str;
wstring wstr;
int int_type;
//convert c++ type to QString 
qstr = QString::fromStdWString(wstr);
qstr = QString::number(int_type);

//convert QString to c++ type
wstr = qstr.toStdWString();
str = qstr.toStdString();

```

---

# QObject

-   The QObject class is the base class of all Qt objects.
-   QObject是QT中所有类的基类

>   http://doc.qt.io/qt-5/qobject.html#details



---

# QWidget

-   #include <QWidget>
-   Inherits: QObject and QPaintDevice



>   http://doc.qt.io/qt-5/widget-classes.html





### Properties 属性

-   Qt文档中，使用 Properties 来表明 class data member

>   http://doc.qt.io/qt-5/qwidget.html
>
>   Properties n. 性能；道具，内容(property的复数形式)



#### WindowFlags

-   windowFlags : Qt::WindowFlags // data type: Qt::WindowFlags, data name: windowFlags
-   窗口标识由两部分组成分别是窗口类型type和窗口提示hint，一个窗口只有一个窗口type
-   A window flag is either a type or a hint.(windowFlags是type或者hint) A type is used to specify various window-system properties for the widget. A widget can only have one type, and the default is Qt::Widget.(type用于指定部件的窗口系统属性，部件只有一种type一般为Qt::Widget) However, a widget can have zero or more hints. The hints are used to customize the appearance of top-level windows.(部件可以有0或多个hint，用于自定义顶层窗口的外观)


>   http://doc.qt.io/qt-5/qt.html#WindowType-enum
>
>   http://doc.qt.io/qt-5/qtwidgets-widgets-windowflags-example.html


```cpp
Qt::Widget               //是一个窗口或部件，有父窗口就是部件，没有就是窗口
Qt::Window               //是一个窗口，有窗口边框和标题
Qt::Dialog               //是一个对话框窗口
Qt::Sheet                //是一个窗口或部件Macintosh表单
Qt::Drawer               //是一个窗口或部件Macintosh抽屉
Qt::Popup                //是一个弹出式顶层窗口
Qt::Tool                 //是一个工具窗口
Qt::ToolTip              //是一个提示窗口，没有标题栏和窗口边框
Qt::SplashScreen         //是一个欢迎窗口，是QSplashScreen构造函数的默认值
Qt::Desktop              //是一个桌面窗口或部件
Qt::SubWindow            //是一个子窗口

//为窗口添加一些功能 Hint
Qt::CustomizeWindowHint          //关闭默认窗口标题提示
Qt::WindowTitleHint              //为窗口修饰一个标题栏
Qt::WindowSystemMenuHint         //为窗口修饰一个窗口菜单系统
Qt::WindowMinimizeButtonHint     //为窗口添加最小化按钮
Qt::WindowMaximizeButtonHint     //为窗口添加最大化按钮
Qt::WindowMinMaxButtonsHint      //为窗口添加最大化和最小化按钮
Qt::WindowCloseButtonHint
Qt::WindowContextHelpButtonHint//为窗口添加一个“上下文帮助”按钮
Qt::MacWindowToolBarButtonHint
Qt::WindowFullscreenButtonHint
Qt::BypassGraphicsProxyWidget
Qt::WindowShadeButtonHint
Qt::WindowStaysOnTopHint//告知窗口系统，该窗口应该停留在所有其他窗口的上面
Qt::WindowStaysOnBottomHint
Qt::WindowOkButtonHint
Qt::WindowCancelButtonHint
Qt::WindowTransparentForInput

Qt::MSWindowsFixedSizeDialogHint//Gives the window a thin dialog border on Windows. This style is traditionally used for fixed-size dialogs.
```



**Access functions:** 

1.  Qt::WindowFlags **windowFlags**() const;
2.  void **setWindowFlags**(Qt::WindowFlags *type*)

###### setWindowFlags

-   Sets the window flag *flag* on this widget if *on* is true; otherwise clears the flag.

```cpp
void QWidget::setWindowFlag(Qt::WindowType flag, bool on = true);
```

```cpp
//snippet: make the Qt Window stay on top
Qt::WindowFlags flags = windowFlags();//获取该窗口的windowFlags
setWindowFlags(flags | Qt::WindowStaysOnTopHint);//设置该窗口的windowFlags
show();//显示该窗口

//禁用最大化按钮
setWindowFlags(windowFlags()& ~Qt::WindowMaximizeButtonHint);
//禁止调节窗口大小
setFixedSize(this->width(), this->height());

//禁用最小化 最大化 关闭button, 并窗口置顶
setWindowFlags((windowFlags()& ~Qt::WindowMinMaxButtonsHint & ~Qt::WindowCloseButtonHint) | Qt::WindowStaysOnTopHint );
```



```cpp
/////////////////start//qtwindowflagstest.h////////////////////////////
#ifndef QTWINDOWFLAGSTEST_H
#define QTWINDOWFLAGSTEST_H
#include <QMessageBox>
#include "mainwindow.h"
class QtWindowFlagsTest:public MainWindow{
};
#endif // QTWINDOWFLAGSTEST_H
/////////////////end//qtwindowflagstest.h////////////////////////////

/////////////////start//main.cpp////////////////////////////
#include "qtwindowflagstest.h"
#include <QtWidgets/QApplication>
#include <QStatusBar>
#include <QObject>

int main(int argc, char *argv[]){
    QApplication a(argc, argv);//创建主进程

    QtWindowFlagsTest w;
    w.setGeometry(10, 30, 200, 200);
    w.statusBar()->showMessage(QObject::tr("w Normal"));
    w.show();

    //只有一个关闭按钮
    QtWindowFlagsTest w2;
    w2.setGeometry(225, 30, 200, 200);
    w2.setWindowFlags(Qt::WindowCloseButtonHint);
    w2.statusBar()->showMessage("w2 Qt::WindowCloseButtonHint");
    w2.show();

    //像对话框一样，有个问号和关闭按钮
    QtWindowFlagsTest w3;
    w3.setGeometry(440, 30, 200, 200);
    w3.setWindowFlags(Qt::WindowContextHelpButtonHint);
    w3.statusBar()->showMessage("w3 Qt::WindowContextHelpButtonHint");
    w3.show();

    //标题栏也没有 按钮也没有 在那里出现就站在那里不到，也不能移动和拖到，任务栏右击什么也没有，任务栏窗口名也没有，但是可以从任务管理器里关闭
    QtWindowFlagsTest w4;
    w4.setGeometry(655, 30, 200, 200);
    w4.setWindowFlags(Qt::CustomizeWindowHint);
    w4.statusBar()->showMessage("w4 Qt::CustomizeWindowHint");
    w4.show();

    //窗口只有一个关闭按钮
    QtWindowFlagsTest w5;
    w5.setGeometry(870, 30, 200, 200);
    w5.setWindowFlags(Qt::WindowTitleHint);
    w5.statusBar()->showMessage("w5 Qt::WindowTitleHint");
    w5.show();

    //只有一个关闭按钮
    QtWindowFlagsTest w6;
    w6.setGeometry(1085, 30, 200, 200);
    w6.setWindowFlags(Qt::WindowSystemMenuHint);
    w6.statusBar()->showMessage("w6 Qt::WindowSystemMenuHint");
    w6.show();

    //最小化按钮不可用
    QtWindowFlagsTest w7;
    w7.setGeometry(1300, 30, 200, 200);
    w7.setWindowFlags(Qt::WindowMaximizeButtonHint);
    w7.statusBar()->showMessage("w7 Qt::WindowMaximizeButtonHint");
    w7.show();

    //还原按钮不可用
    QtWindowFlagsTest w8;
    w8.setGeometry(1515, 30, 200, 200);
    w8.setWindowFlags(Qt::WindowMinimizeButtonHint);
    w8.statusBar()->showMessage("w8 Qt::WindowMinimizeButtonHint");
    w8.show();

    //窗口没有按钮但是有标题栏 任务里什么也看不到
    QtWindowFlagsTest w9;
    w9.setGeometry(2, 238, 200, 200);
    w9.setWindowFlags(Qt::SubWindow);
    w9.statusBar()->showMessage("w9 Qt::SubWindow");
    w9.show();

    //没有显示在桌面也没在任务。但是任务管里器里还有
    QtWindowFlagsTest w10;
    w10.setGeometry(217, 238, 200, 200);
    w10.setWindowFlags(Qt::Desktop);
    w10.statusBar()->showMessage("w10 Qt::Desktop");
    w10.show();

    //标题栏也没有 按钮也没有 在那里出现就站在那里不到，也不能移动和拖到，任务栏右击什么也没有，任务栏窗口名也没有， 但是可以从任务管理器里关闭
    QtWindowFlagsTest w11;
    w11.setGeometry(432, 238, 200, 200);
    w11.setWindowFlags(Qt::SplashScreen);
    w11.statusBar()->showMessage("w11 Qt::SplashScreen");
    w11.show();

    //标题栏也没有 按钮也没有 在那里出现就站在那里不到，也不能移动和拖到，任务栏右击什么也没有，任务栏窗口名也没有， 但是可以从任务管理器里关闭 顶层窗口 一直都是在最上面
    QtWindowFlagsTest w12;
    w12.setGeometry(647, 238, 200, 200);
    w12.setWindowFlags(Qt::ToolTip);
    w12.statusBar()->showMessage("w12 Qt::ToolTip");
    w12.show();

    //有一个小小的关闭按钮，但是好像不能真正的关闭
    QtWindowFlagsTest w13;
    w13.setGeometry(862, 238, 200, 200);
    w13.setWindowFlags(Qt::Tool);
    w13.statusBar()->showMessage("w13 Qt::Tool");
    w13.show();

    return a.exec();
}
/////////////////end//main.cpp////////////////////////////
```





---

## Basic Widget Classes





### QDateTimeEdit



```cpp
//signals
dateChanged();//日期change
dateTimeChanged();//日期时间change
timeChanged();//时间change
```



```cpp
QDateTimeEdit *dateTimeEdit = new QDateTimeEdit(this);//constructor
//设置日期时间格式
dateTimeEdit->setDisplayFormat("yyyy-MM-dd HH:mm:ss");
dateTimeEdit->setDisplayFormat("yyyy/MM/dd HH-mm-ss");
dateTimeEdit->setDisplayFormat("yyyy.M.d");
dateTimeEdit->setDisplayFormat("H:mm");
//设置有效日期范围
dateTimeEdit->setMinimumDate(QDate::currentDate().addDays(-365));// -365天
dateTimeEdit->setMaximumDate(QDate::currentDate().addDays(365));// +365天
//其他同功能的有用函数：setDateTimeRange() setDateRange() setTimeRange() setMaximumDateTime() setMinimumDateTime() setMinimumTime() setMaximumTime()
dateTimeEdit->setCalendarPopup(true);//设置日历弹出
```



### QToolBox





---

## Advanced Widget Classes



### QTreeView



### QCalendarWidget





---

## Abstract Widget Classes

-   抽象


---

### QDialog

| Header       | #include <QDialog>                       |
| ------------ | ---------------------------------------- |
| qmake        | QT += widgets                            |
| Inherits     | QWidget                                  |
| Inherited By | [QAbstractPrintDialog](http://doc.qt.io/qt-5/qabstractprintdialog.html), [QAxSelect](http://doc.qt.io/qt-5/qaxselect.html), [QColorDialog](http://doc.qt.io/qt-5/qcolordialog.html), [QErrorMessage](http://doc.qt.io/qt-5/qerrormessage.html), [QFileDialog](http://doc.qt.io/qt-5/qfiledialog.html), [QFontDialog](http://doc.qt.io/qt-5/qfontdialog.html), [QInputDialog](http://doc.qt.io/qt-5/qinputdialog.html), [QMessageBox](http://doc.qt.io/qt-5/qmessagebox.html), [QPageSetupDialog](http://doc.qt.io/qt-5/qpagesetupdialog.html), [QPrintPreviewDialog](http://doc.qt.io/qt-5/qprintpreviewdialog.html), [QProgressDialog](http://doc.qt.io/qt-5/qprogressdialog.html), [QWizard](http://doc.qt.io/qt-5/qwizard.html) |

-   Qt 中使用QDialog类实现对话框，通常设计一个类继承QDialog

>   http://doc.qt.io/qt-5/qdialog.html

######  top-level widget

-   A dialog is always a top-level widget, but if it has a parent, its default location is centered on top of the parent. It will also share the parent's taskbar entry.

    The widget flags *f* are passed on to the QWidget constructor. If, for example, you don't want a What's This button in the title bar of the dialog, pass [Qt::WindowTitleHint](http://doc.qt.io/qt-5/qt.html#WindowType-enum) | [Qt::WindowSystemMenuHint](http://doc.qt.io/qt-5/qt.html#WindowType-enum) in *f*.

-   **QDialog的parent指针为NULL，对话框作为顶层窗口，否则作为其父组件的子对话框//默认出现位置为parent的中心**

-   **顶层窗口在任务栏会有自己的位置，而非顶层窗口则会共享其父组件的位置**





###### Modal & Modeless

-   对话框分为模态对话框和非模态对话框
1. **模态对话框**: **阻塞同一应用程序中其它窗口的输入**。模态对话框很常见，e.g. “打开文件”功能。你可以尝试一下记事本的打开文件，当打开文件对话框出现时，我们是不能对除此对话框之外的窗口部分进行操作的
2. **非模态对话框**: **可以同时操作同一应用程序的其他窗口**。e.g. 查找对话框，我们可以在显示着查找对话框的同时，继续对记事本的内容进行编辑
-   Qt 有两种级别的模态对话框：应用程序级别的模态和窗口级别的模态
1. 应用程序级别的模态 **application modal** :  \[默认\]对话框出现时，用户必须首先对对话框进行交互，直到关闭对话框，然后才能访问程序中其他的窗口
2. 窗口级别的模态 **window modal dialog** : 该仅仅阻塞与对话框关联的窗口，但是依然允许用户与程序中其它窗口交互。窗口级别的模态尤其适用于多窗口模式
-   QDialog::exec()应用程序级别的模态对话框//`exec()`真正含义是开启一个新的事件循环
-   QDialog::open()实现窗口级别的模态对话框// window modal dialog, returning immediately.
-   QDialog::show()实现非模态对话框 //void QWidget::show()

```cpp
int QDialog::exec(); //[virtual slot]
//使用了exec()显示的模态对话框，可以在exec()函数之后直接从对话框的对象获取到数据值
```

-   Shows the dialog as a modal dialog, blocking until the user closes it. The function returns a DialogCode result.
-   If the dialog is **application modal,** users cannot interact with any other window in the same application until they close the dialog.(若对话框为应用程序级别的模态，在关掉该对话框前，阻塞同一app下的其他窗口的交互)
-   If the dialog is window modal, only interaction with the parent window is blocked while the dialog is open. **By default, the dialog is application modal.**



>   Qt 学习之路 2（13）：对话框简介
>
>   https://www.devbean.net/2012/09/qt-study-road-2-dialogs-intro/ 



-   `QColorDialog`：选择颜色
-   `QFileDialog`：选择文件或者目录
-   `QFontDialog`：选择字体
-   `QInputDialog`：允许用户输入一个值，并将其值返回
-   `QMessageBox`：模态对话框，用于显示信息、询问问题等
-   `QPageSetupDialog`：为打印机提供纸张相关的选项；
-   `QPrintDialog`：打印机配置
-   `QPrintPreviewDialog`：打印预览
-   `QProgressDialog`：显示操作过程


---


#### QMessageBox

| Header   | #include <QMessageBox> |
| -------- | ---------------------- |
| qmake    | QT += widgets          |
| Inherits | QDialog                |

>   http://doc.qt.io/qt-5/qmessagebox.html
>
>   https://blog.csdn.net/liang19890820/article/details/50586031 //自定义界面

-   The QMessageBox class provides a modal dialog for informing the user or for asking the user a question and receiving an answer. 通知用户或询问问题并接收答案

-   A message box displays a primary text(主文本) to alert the user to a situation(提醒用户一个情况), an informative text(信息文本) to further explain the alert or to ask the user a question, and an optional detailed text(可选的详细信息文本) to provide even more data if the user requests it(用于请求显示则显示). A message box can also display an icon and standard buttons for accepting a user response.(message box可以显示图标和标准button用于接受用户回答)

    Two APIs for using QMessageBox are provided, the property-based API, and the static functions.(为使用QMessageBox提供两组API，基于属性的API和静态函数) Calling one of the static functions is the simpler approach, but it is less flexible than using the property-based API, and the result is less informative.(调用静态函数比较简单但是比使用基于属性的API灵活性较小导致不那么有用) Using the property-based API is recommended.(建议使用基于属性的API)




```cpp
void MainWindow::closeEvent(QCloseEvent *event){
    QMessageBox exit_message(QMessageBox::NoIcon, QString::fromStdWString(std::wstring(L"Title")), QString::fromStdWString(std::wstring(L"MainText")), QMessageBox::NoButton);
    exit_message.setFont(QFont("新宋体", 11, QFont::Normal));
    QPixmap sherry_pic(":/pic/sherry.jpg");
    sherry_pic = sherry_pic.scaled(QSize(100, 100), Qt::KeepAspectRatio);
    exit_message.setIconPixmap(sherry_pic);
    exit_message.setWindowIcon(QIcon(":/pic/annms.jpg"));
    exit_message.setWindowFlags((exit_message.windowFlags()& ~Qt::WindowMinMaxButtonsHint) | Qt::WindowStaysOnTopHint);
    exit_message.setMaximumSize(160, 100);
    exit_message.exec();
    event->ignore();
}
```




##### Properties

-   **detailedText** : QString
-   **icon** : Icon //在Icon中选择一个Icon显示
-   **iconPixmap** : QPixmap //用图片作为icon，默认显示在窗口主体的左侧
-   **informativeText** : QString
-   **standardButtons** : StandardButtons
-   **text** : QString
-   **textFormat** : Qt::TextFormat
-   **textInteractionFlags** : Qt::TextInteractionFlags




##### Static Public Members



```cpp
//static function e.g.QMessageBox::information static function
StandardButton QMessageBox::information(QWidget *parent, const QString &title, const QString &text, StandardButtons buttons = Ok, StandardButton defaultButton = NoButton);
QMessageBox::information(NULL, "Title", "Content", QMessageBox::Yes | QMessageBox::No, QMessageBox::Yes);
```





---

### QAbstractButton

| Header       | #include <QAbstractButton>               |
| ------------ | ---------------------------------------- |
| qmake        | QT += widgets                            |
| Inherits     | QWidget                                  |
| Inherited By | QCheckBox, QPushButton, QRadioButton, QToolButton |

-   The QAbstractButton class is the abstract base class of button widgets, providing functionality common to buttons.//button widgets的抽象基类，提供button常见的功能

>   http://doc.qt.io/qt-5/qabstractbutton.html



#### QPushButton

>   http://doc.qt.io/qt-5/qpushbutton.html



---

## Organizer Widget Classes



### QGroupBox





---

## Graphics View Classes



### QGraphicsView 

---

## Model/View Classes



### QListWidget

-   简单的列表组件，可以添加`QListWidgetItem`类型作为列表项



```cpp
//snippet
label = new QLabel(this);
label->setFixedWidth(70);
 
listWidget = new QListWidget(this);

//指定一个QListWidget对象，添加QListWidgetItem
new QListWidgetItem(QIcon(":/Chrome.png"), tr("Chrome"), listWidget);
new QListWidgetItem(QIcon(":/Firefox.png"), tr("Firefox"), listWidget);

//调用QListWidget对象的函数addItem添加添加QListWidgetItem
listWidget->addItem(new QListWidgetItem(QIcon(":/IE.png"), tr("IE")));
listWidget->addItem(new QListWidgetItem(QIcon(":/Netscape.png"), tr("Netscape")));
listWidget->addItem(new QListWidgetItem(QIcon(":/Opera.png"), tr("Opera")));
listWidget->addItem(new QListWidgetItem(QIcon(":/Safari.png"), tr("Safari")));
listWidget->addItem(new QListWidgetItem(QIcon(":/TheWorld.png"), tr("TheWorld")));
listWidget->addItem(new QListWidgetItem(QIcon(":/Traveler.png"), tr("Traveler")));

//先new一个QListWidgetItem对象，后更改QListWidgetItem对象的属性后，调用QListWidgetItem对象的函数insertItem来添加QListWidgetItem
QListWidgetItem *newItem = new QListWidgetItem;
newItem->setIcon(QIcon(":/Maxthon.png"));
newItem->setText(tr("Maxthon"));
listWidget->insertItem(3, newItem);

QHBoxLayout *layout = new QHBoxLayout;
layout->addWidget(label);
layout->addWidget(listWidget);
 
setLayout(layout);

connect(listWidget, SIGNAL(currentTextChanged(QString)), label, SLOT(setText(QString)));
```



### QTreeWidget

-   树形结构，层次结构
-   不需要使用复杂的`QTreeView`特性的时候，我们可以直接使用`QTreeWidget`代替

```cpp
//https://www.devbean.net/2013/02/qt-study-road-2-qlistwidget-qtreewidget-qtablewidget/
QTreeWidget treeWidget;
treeWidget.setColumnCount(1);
 
QTreeWidgetItem *root = new QTreeWidgetItem(&treeWidget,
                                            QStringList(QString("Root")));
new QTreeWidgetItem(root, QStringList(QString("Leaf 1")));
QTreeWidgetItem *leaf2 = new QTreeWidgetItem(root, QStringList(QString("Leaf 2")));
leaf2->setCheckState(0, Qt::Checked);
 
QList<QTreeWidgetItem *> rootList;
rootList << root;
treeWidget.insertTopLevelItems(0, rootList);
 
treeWidget.show();
```





### QTableWidget

-   ​

```cpp
QTableWidget tableWidget;
//设置QTableWidget的行列数
tableWidget.setColumnCount(3);
tableWidget.setRowCount(5);
 
QStringList headers;
headers << "ID" << "Name" << "Age" << "Sex";
tableWidget.setHorizontalHeaderLabels(headers);
 
tableWidget.setItem(0, 0, new QTableWidgetItem(QString("0001")));
tableWidget.setItem(1, 0, new QTableWidgetItem(QString("0002")));
tableWidget.setItem(2, 0, new QTableWidgetItem(QString("0003")));
tableWidget.setItem(3, 0, new QTableWidgetItem(QString("0004")));
tableWidget.setItem(4, 0, new QTableWidgetItem(QString("0005")));
tableWidget.setItem(0, 1, new QTableWidgetItem(QString("20100112")));
 
tableWidget.show();
```







---

## Main Window and Related Classes

### QAction



### QMainWindow





### QToolBar







---

## Widget Appearance and Style-Related Classes



### QStyle





---

## Layout Classes



### QGridLayout







---

# Release

-   windeployqt 在 <Qt安装目录>\5.10.0\mingw53_32\bin

```
windeployqt name.exe
```













