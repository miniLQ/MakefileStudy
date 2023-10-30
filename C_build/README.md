# command

## 一、可执行程序
### 1.1 预处理
```
gcc -E hello.c -o hello.i
```

### 1.2 汇编
```
gcc -S hello.i -o hello.s
```

### 1.3 目标文件
```
gcc -c hello.s -o hello.o
```

### 1.4 生成可执行文件
```
gcc hello.o -o hello
```

## 二、静态库
### 2.1 编成目标文件
```
gcc -c hello.c -o hello.o
```

### 2.2 编静态库
```
ar -r libhello.a hello.o
```

### 2.3 链接静态库
```
gcc *.c -o 自定义程序名 -lhello -L路径
```