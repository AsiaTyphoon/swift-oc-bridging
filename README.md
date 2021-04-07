# swift-oc-bridging
在 swift framework 中引用c、Objective-C、c++ 文件

在 swift 项目工程，不可避免的要与c、Objective-C、c++ 文件进行混合编译

在app项目中使用桥接文件：

1. 在项目中添加 SwiftBridging-Bridging-Header.h 文件，在 Build Settings -> Swift Compiler - General -> Objective-C Bridging Header 设置路径
    SwiftBridging/SwiftBridging-Bridging-Header.h （相对路径）
    
2. 直接新建Objective-C文件，Xcode会自动生成桥接文件，例如SwiftBridging-Bridging-Header.h, 路径也会自动填充


新建 Objective-C 文件 testoc，在 SwiftBridging-Bridging-Header.h 导入  #import "testoc.h" 即可在项目中使用 testoc 类



在 framework 项目中使用桥接文件：不同于app项目，无法使用桥接文件，使用modulemap文件替代

(此方法会暴露全部头文件)
1. 新建modulemap文件，新建空文件，修改后缀为.modulemap即可, 例如 public.modulemap
    新建对外暴露头文件, 例如 publicheader.h

    在 public.modulemap 文件中写入
    framework module oclib {
    umbrella header "publicheader.h"
    }

    新建 River 类，新建Objective-C类 Bridge，在 publicheader.h 导入 #import "Bridge.h"
    在 Build Settings -> Packaging -> Module Map File 中设置 路径 oclib/public/public.modulemap  （相对路径）
    在 Build Settings -> Apple Clang - Language - Modules -> Allow Non-modular Includes In Framework Modules 设置为 Yes
    在 Build Phases -> Header 中将 publicheader.h、Bridge.h 添加移动至public
    编译后即可在项目中使用 Bridge 类，也可以在项目外部使用


(此方法不会暴露头文件，只能在项目内使用)
1. 新建module.modulemap文件（名称只能是 module.modulemap 或者 Module.modulemap , 原因不详，未深究）
    
    新建头文件, 例如 privateheader.h

    在 module.modulemap 文件中写入
    module oclibsub {
        header "../public/privateheader.h"
        export *
    }
    注意：此处的privateheader需要设置相对路径
    
    新建Objective-C类 BridgePrivate，在 privateheader.h 导入 #import "BridgePrivate.h"

    在 Build Settings -> Swift Compiler - Search Paths -> import Paths 中设置 路径 $(SRCROOT)/oclib/private  （modulemap文件绝对路径）
    编译后 import oclibsub 即可使用 BridgePrivate 类



