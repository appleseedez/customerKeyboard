//
//  ZPNumberKeyboard.m
//  WGZY
//
//  Created by administrator on 16/2/24.
//  Copyright © 2016年 zp. All rights reserved.
//

#import "ZPNumberKeyboard.h"

#define KScreen_Width   [UIScreen mainScreen].bounds.size.width
#define KScreen_Height  [UIScreen mainScreen].bounds.size.height
#define keyBoardHeight 50.0 //数字键的高度
#define maxLength  100000//限制最大长度

@implementation ZPNumberKeyboard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor =  [UIColor clearColor];
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, keyBoardHeight *4);
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:
                                            CGRectMake(0.0f, 0.0f, KScreen_Width, keyBoardHeight *4)];
        backgroundImageView.image = [UIImage imageNamed:@"szjp_ct"];
        [self addSubview:backgroundImageView];
        
        [self initCustomKeyborad];
    }
    return self;
}


- (void)initCustomKeyborad
{
    for (int x = 0; x < 12; x++)
    {
        UIButton *NumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [NumBtn setFrame:CGRectMake( x%3*(KScreen_Width / 4),  x/3*keyBoardHeight , KScreen_Width / 4, keyBoardHeight)];
        
        
        if (x <= 9)
        {
            [NumBtn setTag:(x + 1)];
        }
        else if (x == 11)
        {
            NumBtn.tag = x;
        }
        else if (x == 10)
        {
            NumBtn.tag = 0;
        }
        [NumBtn setBackgroundColor:[UIColor clearColor]];
        [NumBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [NumBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"szjp_0%ld",NumBtn.tag]] forState:UIControlStateHighlighted];
        [NumBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"szjp_0%ld",NumBtn.tag]] forState:UIControlStateSelected];
        NumBtn.adjustsImageWhenHighlighted = TRUE;
        [NumBtn addTarget:self action:@selector(keyboardViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:NumBtn];
    }
    
    UIButton *resignBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initButton:resignBtn withTag:13 height:2 andHighlightImage:@"szjp_end"];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initButton:deleteBtn withTag:12 height:0 andHighlightImage:@"szjp_del"];
}

- (void)initButton:(UIButton *)btn withTag:(NSInteger)tag height:(CGFloat)height andHighlightImage:(NSString *)imgeName
{
    btn.frame = CGRectMake(3*KScreen_Width/4, keyBoardHeight*height , KScreen_Width / 4, keyBoardHeight*2);
    btn.tag = tag;
    [btn addTarget:self action:@selector(keyboardViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imgeName]] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imgeName]] forState:UIControlStateSelected];
    [self addSubview:btn];
}


- (void)keyboardViewAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;
//    NSLog(@"%ld",tag);
    switch (tag)
    {
        case 10:
        {
            [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"szjp_xsd"]] forState:UIControlStateHighlighted];
            [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"szjp_xsd"]] forState:UIControlStateSelected];

            // 小数点
            if(self.textFiled.text.length > 0 && [self.textFiled.text rangeOfString:@"." options:NSCaseInsensitiveSearch].location == NSNotFound && self.textFiled.text.length < maxLength)
                self.textFiled.text = [NSString stringWithFormat:@"%@.",self.textFiled.text];
        }
            break;
        case 11:
        {
            // 消失
            [self.textFiled resignFirstResponder];
            [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"szjp_sq"]] forState:UIControlStateHighlighted];
            [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"szjp_sq"]] forState:UIControlStateSelected];

        }
            break;
        case 12:
        {
            // 删除
            if(self.textFiled.text.length > 0)
                self.textFiled.text = [self.textFiled.text substringWithRange:NSMakeRange(0, self.textFiled.text.length - 1)];
        }
            break;
        case 13:
        {
            // 确认
            [self.textFiled resignFirstResponder];
        }
            break;
        default:
        {
            // 数字
            self.textFiled.text = [NSString stringWithFormat:@"%@%ld",self.textFiled.text,sender.tag];
            //开始输入0时，下一位不是小数点的处理
            NSString *numStr = [NSString stringWithFormat:@"0%ld",(long)sender.tag];
            if ([self.textFiled.text isEqualToString:numStr ]) {
                self.textFiled.text = [NSString stringWithFormat:@"%ld",(long)sender.tag];
            }
            if (self.textFiled.text.length > maxLength) {
                self.textFiled.text = [self.textFiled.text substringToIndex:maxLength];
            }

            
        }
            break;
    }
}



@end
