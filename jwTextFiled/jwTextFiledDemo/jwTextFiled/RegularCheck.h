//
//  RegularCheck.h
//  jwTextFiled
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JwTfHeader.h"

@interface RegularCheck : NSObject

// 银行卡算法正则校验
+ (BOOL)regularTextFiledLengthBankCard:(UITextField*) textFiled;

// 手机号正则校验
+ (BOOL)regularTextFiledLengthPhone:(UITextField*) textFiled;

// 邮箱正则验证
+ (BOOL) regularTextFiledLengthEMail:(UITextField*) textFiled;

//用户密码验证
+ (BOOL)regularTextFiledLengthPsw:(UITextField*) textFiled;

// 用户名正则校验
+ (BOOL)regularTextFiledLengthUserName:(UITextField*) textFiled;

// 验证码正则校验（6位数字）
+ (BOOL)regularTextFiledLengthSmsCode:(UITextField*) textFiled;

//判断身份证号是否位数够 （YES 位数够  18 或 15 位）
+ (BOOL)regularTextFiledLengthIDCard15:(UITextField*) textFiled;

//身份证号 idCard_18 校验算法
+ (BOOL)regularTextFiledLengthIDCard18:(NSString*)idcardStr;

// 金额输入框的限制:第一步
+ (BOOL)regularIsPayBoxCanInputNumber:(UITextField*)textFiled;
// 金额输入框的限制:第二步
+ (BOOL)regularTextFiledLengthPayBox:(UITextField*)textFiled;

// 4位数的输入框校验
+ (BOOL)regularOfTextFiledType3Dig:(UITextField*) textFiled;

// 3位数的输入框校验
+ (BOOL)regularOfTextFiledType4Dig:(UITextField*) textFiled;


@end
