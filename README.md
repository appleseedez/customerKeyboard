# customerKeyboard
高仿支付宝数字键盘

这是一款高仿支付宝数字键盘的demo，你只需一行代码就可以调用数字键盘
import "UITextField+ZPNumberKeyboard.h"


UITextField *moneyField = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 20)];

moneyField.font = [UIFont systemFontOfSize:15];

moneyField.layer.borderWidth = 1;

moneyField.layer.borderColor = [UIColor redColor].CGColor;

moneyField.KeyBoardStyle = TextFiledKeyBoardStyleMoney;//要用到支付宝的数字键盘只需加上这句话就可以了

[self.view addSubview:moneyField];


使用起来简单方便，谢谢大家阅读，demo中有纰漏之处烦请大家指出！
