# JHNumberKeyboardView
### 自定义数字键盘

## USE:
作为 ```textField``` 与 ```textView``` 的 ```inputView``` 使用。


## Logs:

### 2018-5-11:
#### 1.处理了之前的所有问题。
#### 2.选择范围删除时，会返回删除的数字。

### 2017-10-17:
#### ~~1.会保存输入的数字，及最后一位~~

#### ~~以下情况没有处理：~~
#### ~~1.移动光标再删除。（代理给出的是，从后往前删除）~~
#### ~~2.点击textField & textView 右侧的删除按钮，清空内容。（并没有删除保存的数字）~~
#### ~~3.同时有多个textField & textView 使用一个 JHNumberKeyboardView 实例时，无法区分。~~


![image](https://github.com/xjh093/JHNumberKeyboardView/blob/master/Screen%20Shot%202017-10-17%20at%2017.48.51.png)

![image](https://github.com/xjh093/JHNumberKeyboardView/blob/master/Screen%20Shot%202017-10-17%20at%2017.48.59.png)

![image](https://github.com/xjh093/JHNumberKeyboardView/blob/master/Screen%20Shot%202017-10-17%20at%2017.49.36.png)
