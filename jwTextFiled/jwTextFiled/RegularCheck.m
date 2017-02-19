//
//  RegularCheck.m
//  jwTextFiled
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#define K_BANINPUT  @"限制金额的最后一位非小数点"

#import "RegularCheck.h"

@implementation RegularCheck

// 银行卡算法正则校验
+ (BOOL) regularTextFiledLengthBankCard:(UITextField*) textFiled {
    
    NSString *cardNo = textFiled.text;
    
    // 为空检测
    if ( 0 == [cardNo length]) {
        
        return NO;
    }
    
    int oddsum = 0;
    int evensum = 0;
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    
    for (int i = cardNoLength -1 ; i>=1;i--) {
        
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        
        int tmpVal = [tmpString intValue];
        
        if (cardNoLength % 2 ==1 ) {
            
            if((i % 2) == 0){
                
                tmpVal *= 2;
                
                if(tmpVal>=10)
                    
                    tmpVal -= 9;
                
                evensum += tmpVal;
                
            }else{
                
                oddsum += tmpVal;
            }
        }else{
            
            if((i % 2) == 1){
                
                tmpVal *= 2;
                
                if(tmpVal>=10)
                    
                    tmpVal -= 9;
                
                evensum += tmpVal;
                
            }else{
                
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    
    allsum += lastNum;
    
    if((allsum % 10) == 0)
        
        return YES;
    
    else
        
        return NO;
}

// 手机号正则校验
+ (BOOL)regularTextFiledLengthPhone:(UITextField*) textFiled {
    
    NSString *phoneNo = textFiled.text;
    
    if (nil == phoneNo) {
        
        return NO;
    }
    
// 说明：为什么不用下面的实现呢？因为客户端不能跟上通讯运营商的更新号段的步伐，导致可能的客户流失（除非使用了热更新代码后，可以考虑使用下面的方法）
//    /* 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";//增加了一个3
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//
//    if (([regextestmobile evaluateWithObject:phoneNo] == YES)
//        || ([regextestcm evaluateWithObject:phoneNo] == YES)
//        || ([regextestct evaluateWithObject:phoneNo] == YES)
//        || ([regextestcu evaluateWithObject:phoneNo] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        //2016年06月30日，修正功能，对手机号不做号段判定、仅作手机号位数是11位的判定
//        //这里强制将原来对手机号进行格式判断，舍弃
////        return NO;
//        return YES;
//    }
    
    //2016年06月30日，修正功能，对手机号不做号段判定、仅作手机号首位是1、其余位数是数字的判定
    NSString *newRegular = @"^1\\d{10}$";
    
    NSPredicate *regularMobile =  [NSPredicate predicateWithFormat:@"SELF MATCHES %@", newRegular];
    
    if ([regularMobile evaluateWithObject:phoneNo] == YES) {
        
        return  YES;
        
    }else{
        
        return NO;
    }
}

// 邮箱正则验证
+ (BOOL) regularTextFiledLengthEMail:(UITextField*) textFiled {
    
    NSString *e_mail = textFiled.text;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:e_mail];
    
}

//用户密码验证
+ (BOOL)regularTextFiledLengthPsw:(UITextField*) textFiled {
    
    NSString* passWord = textFiled.text;
    
    BOOL result = false;
    
    if ([passWord length] >= 6){
        
        //下面是按照标准的ASCII符号特殊字符集（保证任何手机都有）
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,24}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:passWord];
        
        // 此处暂不返回提示信息
        return result;
    }
    
    NSMutableArray *unSafeStr = [NSMutableArray array];
    if (!result) {
        
        //如果某一个不存在的话，单独调处来
        for(int i =0; i < [passWord length]; i++)
        {
            NSString *temp = [passWord substringWithRange:NSMakeRange(i, 1)];
            BOOL isOk;
            NSString * regex = @"^(?![0-9]+$)|(?![a-zA-Z]+$)|[0-9A-Za-z-\\[\\]~`!@#$%^&*()_+=|}{:;'/?<>,.\"\\\\]{1,16}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            isOk = [pred evaluateWithObject:temp];
            
            if (!isOk) {
                
                if ([temp isEqualToString:@" "]) {
                    
                    temp = @"空格";
                }
                
                [unSafeStr addObject:temp];
                //NSLog(@"——找到的错误是%@",unSafeStr);
            }
        }
    }
    
    if (0!=unSafeStr.count) {
        
        NSSet *set = [NSSet setWithArray:unSafeStr];
        [unSafeStr removeAllObjects];
        
        for (NSString *obj in set) {
            
            [unSafeStr addObject:obj];
        }
        
        // NSLog(@"数组是 %@",unSafeStr);
        NSString *tishi = @"检测密码不能包含非法字符：";
        
        for (int i = 0; i<unSafeStr.count; i++) {
            
            NSString *temp = unSafeStr[i];
            temp =  [temp stringByAppendingString:@"、"];
            tishi = [tishi stringByAppendingString:temp];
        }
        
        tishi = [tishi substringWithRange:NSMakeRange(0, tishi.length - 1)];
        
        //全局的提示框提示内容...这里可是显示一下
        NSLog(@"注意，这里实现了对不符合要求的字符进行页面的提示，提示如下————————————%@",tishi);
    }
    
    return result;
    
}


// 用户名正则校验
+ (BOOL)regularTextFiledLengthUserName:(UITextField*) textFiled {
    
    NSString *userName = textFiled.text;
    
    BOOL result = false;
    
    if ([userName length] >= 6){
        
        // 判断长度不小于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)|(?![a-zA-Z]+$)|[0-9A-Za-z]{6,16}$";
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        result = [pred evaluateWithObject:userName];
    }
    
    return result;
}

// 验证码正则校验（6位数字）
+ (BOOL)regularTextFiledLengthSmsCode:(UITextField*) textFiled {
    
    NSString *smsCodeStr  = textFiled.text;
    
    BOOL result = false;
    
    if ( 6 == [smsCodeStr length]){
        
        //判断是不是6位数的验证码（0-9数字）
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(\\d){6}$";
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        result = [pred evaluateWithObject:smsCodeStr];
    }
    
    return result;
}

//判断身份证号是否位数够 （YES 位数够  18 或 15 位）
+ (BOOL)regularTextFiledLengthIDCard15:(UITextField*) textFiled {
    
    NSString*idCardNum = textFiled.text;
    
    BOOL result = false;
    
    NSString *regex = @"^(\\d){14}[0-9z-zA-Z]|(\\d){17}[0-9a-zA-Z]$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    result = [pred evaluateWithObject:idCardNum];
    
    //如果是18位身份证号，就要验证其合法性
    if (idCardNum.length == 18) {
        
        result = [self regularTextFiledLengthIDCard18:idCardNum];
        
    }
    
    if (idCardNum.length == 15) {
        
        //暂无算法
    }
    
    return result;
}

//idCard_18 校验算法
+ (BOOL)regularTextFiledLengthIDCard18:(NSString*)idcardStr{
    
    BOOL isYes;
    isYes = NO;
    
    //分别得到身份证的各个位数，存入数组中
    int s = 0;//加权求和值
    int y = 0;//计算模值
    
    int wi[17] = {7 ,9 ,10 ,5 ,8 ,4 ,2 ,1 ,6 ,3 ,7 ,9 ,10 ,5 ,8 ,4 ,2 };//加权因子
    
    NSString *l = [idcardStr substringWithRange:NSMakeRange(idcardStr.length - 1, 1)];
    
    //加权和
    for (int i = 0; i < idcardStr.length - 1; i++) {
        
        NSString *num = [idcardStr substringWithRange:NSMakeRange(i, 1)];
        
        //转化为数字
        int b = [num intValue];
        
        s += b*wi[i];
    }
    
    //计算模
    y = s%11;
    
    //匹配校验码数组
    int Y[11] = {0 ,1 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10 };
    
    char YY[11] = {'1','0', 'X', '9','8', '7', '6', '5', '4', '3', '2'};
    
    //匹配方法
    for (int k = 0; k < 11; k++) {
        
        if (y == Y[k]) {
            
            if ([[NSString stringWithFormat:@"%c",YY[k]] isEqualToString:l]) {
                
                isYes = YES;
            }
        }
    }
    return isYes;
}

// 金额输入框的限制:第一步
+ (BOOL)regularIsPayBoxCanInputNumber:(UITextField*)textFiled {
    
    //只能2位小数
    NSString *tempstr = textFiled.text;
    
    size_t length = [tempstr length];
    
    int count_point = 0;//小数点的个数
    
    BOOL isPoint_ok = YES ;//小数点的检测
    
    for (size_t i=0; i < length; i++) {
        
        unichar c = [tempstr characterAtIndex:i];
        
        //是否是小数
        if (c == 0x2E ) {
            
            // 自动补0
            if ( 0 == i) {
                
                NSString *tempzero = @"0";
                textFiled.text = [tempzero stringByAppendingString:textFiled.text];
            }
            
            count_point++;
            
            //小数点后禁止输入小数点
            if ( 2 == count_point) {
                
                textFiled.text = [tempstr substringWithRange:NSMakeRange(0, length - 1)];
                isPoint_ok = NO;//禁止输入第二个小数点
                
            }else{
                
                isPoint_ok = YES;//只有一个小数点的时候，可以输入
                
            }
            
            //小数位多于2位禁止输入
            if ( 2 <= (length-1 -i)) {
                
                isPoint_ok = NO;
                textFiled.text = [tempstr substringWithRange:NSMakeRange(0, i+ 3)];
                
            }else{
                
                isPoint_ok = YES;
                
            }
            
            //最后一位禁止输入小数点
            if ( i == (TextFiledLengthPayBox -1)) {
                
//                // 非iphone4s手机使用黑框提示
//                if (K_IS_IPHONE_4) {
//                    ALT_SHOW(K_TILTLE, K_BANINPUT, K_SURE)
//                }else{
//                    [AutoAttentionView autoShowAttentionWith:K_BANINPUT andWith:AX_KEY_WINDOW];
//                }
                
                textFiled.text = [tempstr substringToIndex:i];
                
            }
            
            //在输入框是否能输入的设置地方，只有 isPoint_ok = yes,才能输入否则禁止输入
            
        }
        
        //0后面只能输入小数点，如果不是小数点，就禁止输入
        if ([tempstr characterAtIndex:0] == 48) {
            
            if ([tempstr length] > 1) {//对第二个字符开始判断
                
                if ([tempstr characterAtIndex:1] >= 48) {
                    
                    textFiled.text = [textFiled.text substringWithRange:NSMakeRange(0, length - 1)];
                    isPoint_ok = NO;//两个0，不可以输入
                }
            }
        }
    }
    if (isPoint_ok) {
        
        NSLog(@" \n\n【金额输入框小数点限制】 （当前可以输入）您已经输入了 %@\n",textFiled.text);
        
    }else{
        
        NSLog(@" \n\n【金额输入框小数点限制】 （当前禁止输入）您已经输入了 %@\n",textFiled.text);
        
    }
    
    return  isPoint_ok;
}
// 金额输入框的限制:第二步
+ (BOOL)regularTextFiledLengthPayBox:(UITextField*)textFiled {
    
    NSString *money = textFiled.text;
    BOOL result = false;
    
    if ([money length] > 0){
        
        // 判断是否是整数或者有不超过两位的小数
        NSString * regex = @"^(([0-9]|([1-9][0-9]{0,9}))((\\.[0-9]{1,2})?))$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:money];
        
    }
    
    return result;
}

// 4位数的输入框校验
+ (BOOL)regularOfTextFiledType4Dig:(UITextField*) textFiled {
    
    NSString *timeNum = textFiled.text;
    BOOL result = false;
    
    if ([timeNum length] == 4) {
        
        // 0-9 的三位纯数字
        NSString *regex =@"^[0-9]{4}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        result = [pred evaluateWithObject:timeNum];
    }
    
    return result;
}

// 3位数的输入框校验
+ (BOOL)regularOfTextFiledType3Dig:(UITextField*) textFiled {
    
    NSString*safeCodeNum = textFiled.text;
    BOOL result = false;
    
    if ([safeCodeNum length] == 3) {
        
        // 0-9 的三位纯数字
        NSString *regex = @"^[0-9]{3}$";
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        result = [pred evaluateWithObject:safeCodeNum];
    }
    
    return result;
}


@end
