# JHNumberKeyboardView
nubmer keyboard view
- 自定义数字键盘

---

# What

![image](https://github.com/xjh093/JHNumberKeyboardView/blob/master/Image/Screen%20Shot%202017-10-17%20at%2017.48.51.png)

![image](https://github.com/xjh093/JHNumberKeyboardView/blob/master/Image/Screen%20Shot%202017-10-17%20at%2017.48.59.png)

![image](https://github.com/xjh093/JHNumberKeyboardView/blob/master/Image/Screen%20Shot%202017-10-17%20at%2017.49.36.png)

---

# Usage
作为 ```textField``` 与 ```textView``` 的 ```inputView``` 使用。

example:
```
    JHNumberKeyboardView *keyboard = [[JHNumberKeyboardView alloc] initWithFrame:CGRectMake(0, kScreenHeight-216, kScreenWidth, 216)];
    keyboard.delegate = self; // no need to set delegate if you use as 'inputView'
    _keyboard = keyboard;
    textField.inputView = keyboard;

    #pragma mark - JHNumberKeyboardViewDelegate

    - (void)keyboardView:(JHNumberKeyboardView *)keyboard firstResponder:(id)firstResponder textDidChange:(NSString *)text lsatNumber:(NSString *)number{
    
      NSLog(@"text:%@,number:%@",text,number);
      
      if (firstResponder == nameTextField) {
         // code goes here.
      }else if (firstResponder == phoneTextField) {
         // code goes here.
      }
      
}

```

---

# Logs:

### 2018-12-11
- add Demo and fix bugs.

### 2018-10-11
- iPhoneX bug fix.

### 2018-6-22:
- 适配横坚屏.

### 2018-5-11:
- 处理了之前的所有问题.
- 选择范围删除时，会返回删除的数字.

---

### 2017-10-17:
- ~~会保存输入的数字，及最后一位~~

- ~~以下情况没有处理：~~
    - ~~1.移动光标再删除。（代理给出的是，从后往前删除）~~
    - ~~2.点击textField & textView 右侧的删除按钮，清空内容。（并没有删除保存的数字）~~
    - ~~3.同时有多个textField & textView 使用一个 JHNumberKeyboardView 实例时，无法区分。~~

---


