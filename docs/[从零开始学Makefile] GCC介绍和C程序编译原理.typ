#import "./template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "[从零开始学Makefile] GCC介绍和C程序编译原理",
  authors: (
    (name: "刘琦", email: "liuqi@longcheer.com", phone: "18015419589"),
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  abstract:"本章作为该系列的第一章，主要介绍GCC的概念以及C语言程序编译的原理，通过GCC指令将这个原理具象化。",
  date: "October 25, 2023",
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

= 一、GNU
== 1.1 GNU的简介
```
```
在了解GCC的前，我们需要了解GNU这个概念。我们可以查看以下百度百科上的介绍：
#image("images/GNU.png")

== 1.2 GNU的历史
```
```
1. 1985年Richard Stallman又创立了自由软件基金会（Free Software Foundation）来为GNU计划提供技术、法律以及财政支持
2. 到了1990年，GNU计划已经开发出的软件包括了一个功能强大的文字编辑器Emacs。GCC（GNU Compiler Collection，GNU编译器集合），是一套由 GNU 开发的编程语言编译器。以及大部分UNIX系统的程序库和工具。唯一依然没有完成的重要组件就是操作系统的内核(称为HURD)。
3. 1991年[Linus Torvalds](https://baike.baidu.com/item/Linus%20Torvalds?fromModule=lemma_inlink)编写出了与UNIX兼容的Linux操作系统内核并在GPL条款下发布。
4. 1992年Linux与其他GNU软件结合，完全自由的操作系统正式诞生。该操作系统往往被称为“GNU/Linux”或简称Linux。

== 1.3 GNU包含协议条款
```
```
GNU 包含3个协议条款，

GPL：GNU通用公共许可证（GNU General Public License）

LGPL：GNU较宽松公共许可证 (GNU Lesser General Public License）, ) ，旧称 GNU Library General Public License (GNU 库通用公共许可证)；

GFDL ： GNU自由文档许可证（GNU Free Documentation License ）的缩写形式。

这里指的自由，并不是价格免费，这和价格无关而是使用软件对所有的用户来说是自由的。GPL通过如下途径实现这一目标：

1. 它要求软件以源代码的形式发布，并规定任何用户能够以源代码的形式将软件复制或发布给别的用户。

2. 如果用户的软件使用了受 GPL 保护的任何软件的一部分，那么该软件就继承了 GPL 软件，并因此而成为 GPL 软件，也就是说必须随应用程序一起发布源代码。

3. GPL 并不排斥对自由软件进行商业性质的包装和发行，也不限制在自由软件的基础上打包发行其他非自由软件。

由于GPL很难被商业软件所应用，它要求调用它的库的代码也得GPL，全部开放，并且一同发布，不能直接连接。所以后来GNU推出了LGPL许可证

在GPL与LGPL许可证保护下发布源代码的结果很相似，对旧代码所做的任何修改对于想知道这些代码的人必须是公开的，唯一真正的不同之处在于私人版权代码是否可以与开放源代码相互连接，LGPL允许实体连接私人代码到开放源代码，并可以在任何形式下发布这些合成的二进制代码。只要这些代码是动态连接的就没有限制。（使用动态链接时，即使是程序在运行中调用函数库中的函数时，应用程序本身和函数库也是不同的实体）

== 1.4 GNU软件包列表
```
```
该系统的基本组成包括GNU编译器套装（GCC）、GNU的C库（glibc）、以及GNU核心工具组（coreutils），另外也是GNU除错器（GDB）、GNU二进制实用程序（binutils）的GNU Cashshell中和GNOME桌面环境。GNU开发人员已经向GNU应用程序和工具的Linux移植，也广泛应用在其它操作系统中使用，如BSD变体的Solaris，和OS X作出了贡献。

许多GNU程序已经被移植到其他操作系统，包括专有软件，如Microsoft Windows和OS X.GNU计划已经被证明是比他们的专有Unix更为可靠。截至2015年11月，全国共有466 GNU软件包（包括退役，但不包括383 ）主办的官方GNU开发的网站。

= 二、GCC
```
```
GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言编译器。GNU编译器套件包括C、C++、 Objective-C、 Fortran、Java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等。）

GCC的初衷是为GNU操作系统专门编写的一款编译器。GNU系统是彻底的自由软件。此处，“自由”的含义是它尊重用户的自由。

[GCC百度百科] https://baike.baidu.com/item/gcc/17570

GCC（GNU Compiler Collection，GNU编译程序集合）是最重要的开放源码软件。其他所有开放源码软件都在某种层次上依赖于它。甚至其他语言，例如 Python，都是由 C 语言开发的，由 GNU 编译程序编译的。

这个软件对于整个自由软件运动而言具有根本性的意义。如果没有它或类似的软件，就不可能有自由软件运动。GCC 为 Linux 的出现提供了可能性。

GCC 是由许多组件组成的，但它们也并不总是出现的。有些部分是和语言相关的，所以如果没有安装某种特定语言，系统中就不会出现相关的文件。

== 2.1 GCC常见的组成部分
```
```
- **c++：** gcc 的一个版本，默认语言设置为 C++，而且在链接的时候自动包含标准 C++ 库。这和 g++ 一样
- **configure：** GCC 源代码树根目录中的一个脚本。用于设置配置值和创建 GCC 编译程序必需的 make 程序文件
- **g++：** gcc 的一个版本，默认语言设置为 C++，而且在链接的时候自动包含标准 C++库。这和 c++ 一样
- **gcc：** 该驱动程序等同于执行编译程序和连接程序以产生需要的输出
- **libgcc：** 该库包含的例程被作为编译程序的一部分，是因为它们可被链接到实际的可执行程序中。它们是特殊的例程，链接到可执行程序，来执行基本的任务，例如浮点运算。这些库中的例程通常都是平台相关的
- **libstdc++：** 运行时库，包括定义为标准语言一部分的所有的 C++类和函数

== 2.2 GCC常用的软件

- **ar：** 这是一个程序，可通过从文档中增加、删除和析取文件来维护库文件。通常使用该工具是为了创建和管理连接程序使用的目标库文档。该程序是 binutils 包的一部分
- **as：** GNU 汇编器。实际上它是一族汇编器，因为它可以被编译或能够在各种不同平台上工作。该程序是 binutjls 包的一部分 autoconf：产生的 shell 脚本自动配置源代码包去编译某个特定版本的 UNIX
- **gdb：** GNU 调试器，可用于检查程序运行时的值和行为 GNATS：GNU 的调试跟踪系统（GNU Bug Tracking System）。一个跟踪 GCC和其他 GNU 软件问题的在线系统
- **gprof：** 该程序会监督编译程序的执行过程，并报告程序中各个函数的运行时间，可以根据所提供的配置文件来优化程序。该程序是 binutils 包的一部分
- **ld：** GNU 连接程序。该程序将目标文件的集合组合成可执行程序。该程序是 binutils 包的一部分
- **libtool：** 一个基本库，支持 make 程序的描述文件使用的简化共享库用法的脚本
- **make：** 一个工具程序，它会读 makefile 脚本来确定程序中的哪个部分需要编译和连接，然后发布必要的命令。它读出的脚本（叫做 makefile 或 Makefile）定义了文件关系和依赖关系

== 2.3 GCC默认的头文件路径
#image("images/gcc_includes.png")


= 三、C语言编译过程
```
```
程序的生命周期是从一个源程序（或者说源文件）开始的，即程序员通过编辑器创建并保存的文本文件。源程序实际上就是一个由值 0 和 1组成的位（又称为比特）序列，8 个位被组织成一组，称为字节。每个字节表示程序中的某些文本字符

大部分计算机使用 ASCII 标准来表示文本字符

- 用一个唯一的单字节大小的整数值息来表示每个字符
- 程序是以字节序列的方式储存在文件中的

源文件表示方法说明了一个基本思想∶ 系统中所有的信息——包括磁盘文件、内存中的程序、内存中存放的用户数据以及网络上传送的数据，都是由一串比特表示的。
```
```
```
```
```
```
```
```
```
```
== 3.1 整体流程介绍
```
```
首先及其是无法识别C语言这样的高级语言的语法的，所以每一条C语句都必须被一个解析器转化为低端的机器语言。然后这些指令按照一种称为可执行目标程序的格式打好包，并以二进制磁盘文件的形式存放起来。

而GCC就是扮演着解析器的工作，GCC 编译器读取源程序文件 xxx.c，并把它翻译成一个可执行目标文件xxx。这个翻译过程可分为四个阶段完成，如下图所示

执行这四个阶段的程序（预处理器、编译器、汇编器和链接器）一起构成了编译系统（compilation system）
#image("images/c_build_process.png")

== 3.2 预处理阶段
```
```
熟悉C语言的应该知道，在每个c代码开头会使用 `#include`头文件。而预处理阶段就是对这部分进行处理。`预处理器（cpp）`根据以字符`#`开头的命令，修改原始的C程序。比如`#include <stdio.h>` 命令告诉预处理器读取系统头文件stdio.h的内容，并把它直接插入程序文本中。结果就得到了另一个C程序，通常是以.i作为文件扩展名。

下面以一个hello.c的源码进行演示

    ```c
    #include <stdio.h>
    
    int main()
    {
    		printf("hello world.\n");
    }
    ```

```
```
使用如下指令将hello.c代码进行预处理，转成hello.i

    ```shell-unix-generic
    gcc -E hello.c -o hello.i
    ```
```
```
#image("images/3.2_1.png")
```
```
我们打开这个文件，发现里面增加了很多代码
#image("images/3.2_2.png")
#image("images/3.2_3.png")

== 3.3 编译阶段
`编译器（ccl）`将文本文件hello.i翻译成文本文件hello.s，它包含一个汇编语言程序。

使用如下指令将hello.i转成hello.s
```shell-unix-generic
gcc -S hello.i -o hello.s
```

#image("images/3.3_1.png")
#image("images/3.3_2.png")

== 3.4 汇编阶段
```
```
这部分就是将汇编文件转换成目标文件xxx.o，`汇编器（as）`将xxx.s翻译成机器语言指令，把这些指令打包成一种叫做可重定位目标程序（relocatable object program）的格式，并将结果保存在目标文件hello.o中。

使用如下的指令将hello.s转成hello.o
```shell-unix-generic
gcc -c hello.s -o hello.o
```

#image("images/3.4_1.png")

== 3.5 链接阶段

我们在源码中调用的一些函数，比如printf，这个是C编译器提供的标准C库中的一个函数。printf函数的源码实现存在于一个名为printf.o的单独文件中，所以我们在编译我们自己程序的时候使用到这个printf函数，我们就需要将printf.o以某一种形式合并到我们自己的程序中。

而链接器就负责这个工作，他的执行结果就是一个可执行程序，是可以被加载到内存中，被系统运行。

使用如下指令将hello.o转成hello
```shell-unix-generic
gcc hello.o -o hello
```

#image("images/3.5_1.png")

= 四、GCC编译C语言

上一章节主要介绍C语言编译的几个阶段，并用hello.c做了演示。本章节完全从指令角度来处理C语言的编译，分为可执行程序/动态库/静态库的编译。

首先介绍以下C语言文件相关的后缀以及编译参数
#align(center, table(
columns: (1fr, 1fr),
inset: 9pt,
align: horizon,
fill: (col, num) => if num == 0 {
  color.luma(200)
},
[*Suffix*], [*File Contains*],
[.a], [静态库文件],
[.c], [C语言源代码，也有.cc],
[.h], [C语言头文件],
[.i], [预处理文件],
[.o], [目标文件],
[.s], [汇编代码],
[.so], [动态库文件]
))

#align(center, table(
columns: (1fr, 1fr),
inset: 9pt,
align: horizon,
fill: (col, num) => if num == 0 {
  color.luma(200)
},
[*Parameter*], [*解释*],
[-g], [告诉编译器只进行预处理操作],
[-o], [把处理的结果输出到指定文件],
[-s], [告诉编译器进行预处理和编译成汇编操作],
[-c], [生成目标文件.o],
))

```
```
== 4.1 可执行程序的编译
```
```
=== 4.1.1 预处理
```
```
```bash
# 不会生成.i文件，内容打印在终端
gcc -E xxx.c
gcc -E xxx.c -o xxx.i
```

=== 4.1.2 汇编

```bash

# 不会生成.s文件，内容打印在终端
gcc -S xxx.c

gcc -S xxx.i -o xxx.s  # 此指令将预处理文件转成汇编
gcc -S xxx.c -o xxx.s  # 此指令同时完成预处理以及汇编
```

=== 4.1.3 生成目标文件
```
```
```bash
# 不会生成.o文件
gcc -c xxx.c

gcc -c xxx.c -o xxx.o
```

=== 4.1.4 生成可执行程序
```
```
```bash
gcc xxx.o -o xxx

# 多个文件编成一个可执行程序
gcc xxx1.o xxx2.o xxx3.o -o xxx

# 直接源文件编译成可执行程序，此指令同时完成4个步骤
gcc xxx1.c xxx2.c xxx3.c -o xxx
```
```
```
== 4.2 静态库
```
```
=== 4.2.1 编译成.o
```
```
```bash
gcc -c [*.c] -o [自定义文件名]
gcc -c [*.c] [*.c] ...
```

=== 4.2.2 编静态库
```
```
```bash
ar -r [lib自定义库名.a] [*.o] [*.o]
```

=== 4.2.3 链接可执行文件
```
```
```bash
gcc [*.c] [*.a] -o [自定义输出文件名]

# 如果出现报错，则有可能是动态库的路径文件
gcc [*.c] -o [自定义文件名] -l[库名] -L[库所在路径]
```

=== 4.2.4 实例

以下面这个例子为例，将两个helloworld.c hellolinux.c编译成libhello.a，然后在main程序中调用编译。

helloworld.c

```c
int helloworld()
{
    printf("hello world.\n");
    return 0;
}
```

hellolinux.c

```c
int hellolinux()
{
    printf("hello linux.\n");
    return 0;
}
```

main.c

```c
#include <stdio.h>

int helloworld();
int hellolinux();

int main()
{
    helloworld();
    hellolinux();
    return 0;
}
```
```
```
编译产物：
```
```
#image("images/4.2_1.png")
```
```
输出结果：
#image("images/4.2_2.png")
如果我们在编译时不将此libhello.a带入编译，则会出现
#image("images/4.2_3.png")

== 4.3 动态库
=== 4.3.1 编译二进制.o文件

```bash
gcc -c -fpic [*.c] [*.c] ...
```

=== 4.3.2 编动态库

```bash
gcc --shared [*.o] [*.o] ... -o [lib自定义库名.so]
```

=== 4.3.3 链接库到可执行文件

```bash
gcc [*.c] -o [自定义可执行文件名] -l[库名] -L[库路径] -Wl,-rpath=[库路径]
```

=== 4.3.4 实例

以下面这个例子为例，将两个helloworld.c hellolinux.c编译成libhello.so，然后在main程序中调用编译。

helloworld.c、hellolinux.c和main.c的源码与上一章一致
#image("images/4.3_1.png")

= 五、C++的编译
```
```
首先介绍以下C++语言文件相关的后缀以及编译参数
#align(center, table(
columns: (1fr, 1fr),
inset: 9pt,
align: horizon,
fill: (col, num) => if num == 0 {
  color.luma(200)
},
[*Suffix*], [*File Contains*],
[.a], [静态库文件],
[.c, .cpp, .c++, .cp, .cpp, .cxx], [C++源代码文件],
[.h], [C++头文件],
[.i, .ii], [预处理文件],
[.o], [目标文件],
[.s], [汇编代码],
[.so], [动态库文件]
))

#align(center, table(
columns: (1fr, 1fr),
inset: 9pt,
align: horizon,
fill: (col, num) => if num == 0 {
  color.luma(200)
},
[*Parameter*], [*解释*],
[-E], [告诉编译器只进行预处理操作],
[-o], [把处理的结果输出到指定文件],
[-S], [告诉编译器进行预处理和编译成汇编操作],
[-c], [生成目标文件.o],
))

```
```
💡 C++的编译与C语言的编译几乎完全一致，只需要将gcc改成g++。
g++工具向下兼容gcc

= 六、GCC其他重要参数

- -g
    
    编译带调试信息的可执行文件（gdb）
    
    ```bash
    gcc -g xxx.c
    ```
    #image("images/6.1_1.png")    

- -O[n]
    
    优化源代码
    
    ```bash
    ## 所谓优化，例如省略掉代码中从未使用过的变量、直接将常量表达式用结果值代替等等，这些操作会缩减目标文件所包含的代码量，提高最终生成的可执行文件的运行效率。
    # -O 选项告诉 g++ 对源代码进行基本优化。这些优化在大多数情况下都会使程序执行的更快。 -O2 选项告诉 g++ 产生尽可能小和尽可能快的代码。 如-O2，-O3，-On（n 常为0–3）
    # -O 同时减小代码的长度和执行时间，其效果等价于-O1
    # -O0 表示不做优化
    # -O1 为默认优化
    # -O2 除了完成-O1的优化之外，还进行一些额外的调整工作，如指令调整等。
    # -O3 则包括循环展开和其他一些与处理特性相关的优化工作。
    # 选项将使编译的速度比使用 -O 时慢， 但通常产生的代码执行速度会更快。
    # 使用 -O2优化源代码，并输出可执行文件
    gcc -O2 xxx.c
    
    ```
    
- -l和-L
    
    指定库文件|指定库文件路径
    
    ```bash
    # -l参数(小写)就是用来指定程序要链接的库，-l参数紧接着就是库名
    # 在/lib和/usr/lib和/usr/local/lib里的库直接用-l参数就能链接
    # 链接glog库
    gcc -lglog xxx.c
    # 如果库文件没放在上面三个目录里，需要使用-L参数(大写)指定库文件所在目录
    # -L参数跟着的是库文件所在的目录名
    # 链接mytest库，libmytest.so在/home/bing/mytestlibfolder目录下
    gcc -L/home/bing/mytestlibfolder -lmytest xxx.c
    ```
    

- -I
    
    指定头文件搜索目录
    
    ```bash
    # -I 
    # /usr/include目录一般是不用指定的，gcc知道去那里找，但 是如果头文件不在/usr/include里
    # 我们就要用-I参数指定了，比如头文件放在/myinclude目录里，那编译命令行就要加上-I/myinclude 参数了，
    # 如果不加你会得到一个”xxxx.h: No such file or directory”的错误。-I参数可以用相对路径，
    # 比如头文件在当前 目录，可以用-I.来指定。上面我们提到的–cflags参数就是用来生成-I参数的。
    gcc -I/myinclude xxx.c
    ```
    

- -Wall
    
    打印警告信息
    
    ```bash
    gcc -Wall xxx.c
    ```
    

- -w
    
    关闭警告信息
    
    ```bash
    # 关闭所有警告信息
    gcc -w xxx.c
    ```
    

- -werror
    
    把所有的告警信息转化为错误信息，并在告警发生时终止编译过程
    

- std=c++11
    
    ```bash
    # 使用 c++11 标准编译 xxx.cpp
    g++ -std=c++11 xxx.cpp
    ```
    
- -o
    
    ```bash
    # 指定即将产生的文件名
    # 指定输出可执行文件名为xxx
    gcc xxx.cpp -o xxx
    ```
    

- -D
    
    ```bash
    # 在使用gcc/g++编译的时候定义宏
    # 常用场景：
    # -DDEBUG 定义DEBUG宏，可能文件中有DEBUG宏部分的相关信息，用个DDEBUG来选择开启或关闭DEBUG
    ```
    

例子：

test.c

```c
// -Dname 定义宏name,默认定义内容为字符串“1”
 
#include <stdio.h>
 
int main()
{
#ifdef DEBUG
    printf("DEBUG LOG\n");
#endif
    printf("in\n");
}
 
// 1. 在编译的时候，使用gcc -DDEBUG main.cpp
// 2. 第七行代码可以被执行
```

输出结果：

#image("images/6.1_2.png")

- -v
    
    打印出编译器内部编译各过程的命令行信息和编译器的版本




```















































```
#align(center)[TO BE CONTINUED ...]