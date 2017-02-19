//
//  UITextField+Exten.m
//  jwTextFiled
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "UITextField+Exten.h"
#import <objc/runtime.h>
#import "RegularCheck.h"
#import "AutoAttentionView.h"

@implementation UITextField (Exten)

const void *key = &key;
static inputingBlock focusBlock = ^(UITextField*tf,NSString*tfStr){};

-(void)setOneTextFiledType:(TextFiledType)oneTextFiledType{
    
    objc_setAssociatedObject(self, key, [NSString stringWithFormat:@"%ld",(long)oneTextFiledType], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    objc_setAssociatedObject(self, @selector(focusBlock), focusBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TextFiledType)oneTextFiledType {
    id type = objc_getAssociatedObject(self, key);
    return (TextFiledType)[type integerValue];
}

- (inputingBlock)focusBlock{
    
    id type = objc_getAssociatedObject(self, @selector(focusBlock));
    return (inputingBlock)type;
}

-(void)setTempBlock:(inputingBlock)tempBlock{
    
    objc_setAssociatedObject(self, @selector(tempBlock), tempBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(inputingBlock)tempBlock{
    
    id type = objc_getAssociatedObject(self, @selector(tempBlock));
    return (inputingBlock)type;
}

// 外部设置任何一个tf的长度限制
- (void)jw_TextFiledType:(TextFiledType)tfType{
    
    [self setOneTextFiledType:tfType];
    [self setOneTextFiledKeyBoardType:tfType];
    [self setDelegate:(id)self];
}

- (void)setOneTextFiledKeyBoardType:(TextFiledType)oneTextFiledType{
    switch (self.oneTextFiledType) {
            
        case TextFiledTypeUserName:
             [self setKeyboardType:UIKeyboardTypeDefault];
            break;
            
        case TextFiledTypePassWord:
            [self setKeyboardType:UIKeyboardTypeASCIICapable];
            [self setSecureTextEntry:YES];
            break;
            
        case TextFiledTypeSmsCode:
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            break;
            
        case TextFiledTypePayBox:
            [self setKeyboardType:UIKeyboardTypeDecimalPad];
            break;
            
        case TextFiledTypeIDCard:
            [self setKeyboardType:UIKeyboardTypeNamePhonePad];
            break;
            
        case TextFiledTypeBankCard:
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            break;
            
        case TextFiledTypePhone:
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            break;
            
        case TextFiledTypeEMail:
            [self setKeyboardType:UIKeyboardTypeEmailAddress];
            break;
            
        case TextFiledType4Dig://信用卡有效期 4 位数字
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            break;
            
        case TextFiledType3Dig://信用卡安全码 3 位数字
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            break;
            
        case TextFiledTypeChinese:
            [self setKeyboardType:UIKeyboardTypeDefault];
            break;
            
        default:
            break;
    }
}

// 输入达到最大的输入限度,自动的获取焦点方法
- (void)jw_AutoGetFocusTfAry:(NSArray*)tfs index:(int)index{
    
    NSArray *tempTfs = tfs;
    
    BOOL isNoSafe = ((index < 0) || (index >= (int)[tfs count]))?NO:YES;
    
    if (!isNoSafe) {
        
        index = 0;
    }
    
    for (int i = index; i < [tfs count]; i++) {

        UITextField *tf = tempTfs[i];

        tf.tempBlock = ^(UITextField *TF,NSString *STR){
            
            if ( [TF getInputLimit] != [STR length] ) {
                
                [TF becomeFirstResponder];
                
            }else{
                
                [TF resignFirstResponder];

                for (int j = 0; j < i; j++) {
                    
                    UITextField *t = tempTfs[j];
                    if ( 0 == t.text.length) {
                        
                        [t becomeFirstResponder];
                        return ;
                        
                    }else{
                        
                        if ([t getInputLimit] == [t.text length]) {
                            
                            [TF jw_AutoGetFocusTfAry:tempTfs index:j];
                        }
                    }
                }
                
                for (int k = i; k < [tempTfs count]; k++) {
                    
                    UITextField *h = tempTfs[k];
                    if ( 0 == h.text.length) {
                        
                        [h becomeFirstResponder];
                        return ;
                        
                    }else{
                        
                        if ([h getInputLimit] == [h.text length]) {
                            
                            [TF jw_AutoGetFocusTfAry:tempTfs index:k];
                        }
                    }
                }
            }
        };
    }
}

// 得到输入框的长度限制
-(NSInteger)getInputLimit{

    NSInteger num = 0;
    switch (self.oneTextFiledType) {
        
        case TextFiledTypeUserName:
            num = TextFiledLengthUserName;
            break;
            
        case TextFiledTypePassWord:
            num = TextFiledLengthPsw;
            break;
            
        case TextFiledTypeSmsCode:
            num = TextFiledLengthSmsCode;
            break;
            
        case TextFiledTypePayBox:
            num = TextFiledLengthPayBox;
            break;
            
        case TextFiledTypeIDCard:
            num = TextFiledLengthIDCard;
            break;
            
        case TextFiledTypeBankCard:
            num = TextFiledLengthBankCard;
            break;
            
        case TextFiledTypePhone:
            num = TextFiledLengthPhone;
            break;
            
        case TextFiledTypeEMail:
            num = TextFiledLengthEMail;
            break;
            
        case TextFiledType4Dig:
            num = TTextFiledLength4Dig;
            break;
            
        case TextFiledType3Dig:
            num = TextFiledLength3Dig;
            break;
            
        case TextFiledTypeChinese:
            num = TextFiledLengthChinese;
            break;
            
        default:
            break;
    }
    return num;
    
}

// 重写父类的输入长度限制方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    // 监听每一个输入框
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    BOOL bChange = YES;
    NSString *txt = textField.text;
    NSInteger length = txt.length;

    NSInteger num = 0;
    num = [self getInputLimit];
    
    // 开始限制长度
    if (length >= num) {
        bChange = NO;
    }
    if (range.length == 1) {
        bChange = YES;
    }
    return bChange;
    
}

// 对输入框输入一位的监听 (内部实现)
-(void)textFieldDidChange :(UITextField *)textFiled {
    
    // 禁止输入空格
    NSString *txt = textFiled.text;
    txt =  [txt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    textFiled.text = txt;
    NSInteger length = txt.length;
    
    // 实现定制方法
    switch (textFiled.oneTextFiledType) {
            
            // 金额 输入框的限制
        case TextFiledTypePayBox:
            
            // 金额输入框定制约束（第一步）（轮循校验处为第二步）
            [RegularCheck regularIsPayBoxCanInputNumber:self];
            break;
            
            // 身份证 输入框的限制
        case TextFiledTypeIDCard:
            
            // 转化大写X
            if (length == TextFiledLengthIDCard) {
                NSString *temp = [txt substringFromIndex:length-1];
                if ([temp isEqualToString:@"x"]) {
                    txt = [txt stringByReplacingOccurrencesOfString:@"x" withString:@"X"];
                    textFiled.text = txt;
                }
            }
    
            break;
            
        default:
            break;
    }
    
    
    // 切换焦点专用 block <预防与外部block回调的时候冲突>
    if (!focusBlock) {
        focusBlock = [textFiled focusBlock];
    }
    
    focusBlock(textFiled,textFiled.text);
    
    // 为回调赋值
    if (!self.tempBlock) {
        
        self.tempBlock = ^(UITextField *TF,NSString * TF_STR){
            
            TF = textFiled;
            TF_STR = textFiled.text;
        };
    }
    
    self.tempBlock(textFiled,textFiled.text);
    
}

- (BOOL)jw_pollingTextFileds:(NSArray*)textFileds
                   isHaveBox:(BOOL)isHave
                   warErrors:(NSArray*)wars
                  warNoNulls:(NSArray*)nuls
                 withBoxType:(WarType)warType
                     keepara:(NSString*)keepar{
    
    if ( 0 == [textFileds count]) {
        
        // 既然无 TF，就禁止下一步操作
        return NO;
    }
    
    // 挨个轮询
    for (int i = 0; i < [textFileds count]; i++) {
        
        UITextField *textFiled = textFileds[i];
        
        // 注意：这类一定要是 textFiled 对象去调用，切文案一一对应
        BOOL is_ok = [textFiled CheckOneTextFiled:textFiled isHaveBox:isHave warError:wars[i] warNoNull:nuls[i] withWarBoxType:warType keepara:keepar];
        
        if (!is_ok) {
            
            return NO;
        }
        
    }
    
    // 回收键盘
    for (UITextField *tf in textFileds) {
        [tf resignFirstResponder];
    }
    
    // 轮询结束，可以继续
    return YES;

}

// 提示函数
-(BOOL)checkedValue:(BOOL)isTrue isHaveBox:(BOOL)isHave warType:(WarType)warType warError:(NSString*)warError warNull:(NSString*)warNoNul keepara:(NSString*)keepar{
    
    UIWindow *keyWindow = ([UIApplication sharedApplication].delegate).window;
   
    // 提示 + noNull
    if (isHave && (0 == [self.text length])) {
        
        [AutoAttentionView autoShowAttentionWith:warNoNul andWith:keyWindow];
        [self becomeFirstResponder];
    }
    
    // 提示 + warError
    if (!isTrue && (0 != [self.text length])) {
        
        [AutoAttentionView autoShowAttentionWith:warError andWith:keyWindow];
        [self becomeFirstResponder];
    }
    
    return isTrue;
}

// 校验函数 (入口)
- (BOOL)CheckOneTextFiled:(UITextField *)textFiled isHaveBox:(BOOL) isHave warError:(NSString*)warError warNoNull:(NSString*)warNoNul withWarBoxType:(WarType)warType keepara:(NSString*) keepar{
    
    BOOL isTrue = NO;
    switch (textFiled.oneTextFiledType) {
        
            // 用户名输入框
        case TextFiledTypeUserName:
            
            isTrue = [RegularCheck regularTextFiledLengthUserName:textFiled];
            break;
            
            // 用户登录密码框
        case TextFiledTypePassWord:
            
            isTrue = [RegularCheck regularTextFiledLengthPsw:textFiled];
            break;
            
            // 验证码
        case TextFiledTypeSmsCode:
        
            isTrue = [RegularCheck regularTextFiledLengthSmsCode:textFiled];
            break;
            
            // 金额
        case TextFiledTypePayBox:
            
            isTrue = [RegularCheck regularTextFiledLengthPayBox:textFiled];
            break;
            
            // 身份证
        case TextFiledTypeIDCard:
            
            isTrue = [RegularCheck regularTextFiledLengthIDCard15:textFiled];
            break;
            
            // 银行卡
        case TextFiledTypeBankCard:
            
            isTrue = [RegularCheck regularTextFiledLengthBankCard:textFiled];
            break;
            
            // 手机号
        case TextFiledTypePhone:
            
            isTrue = [RegularCheck regularTextFiledLengthPhone:textFiled];
            break;
            
            // 邮箱
        case TextFiledTypeEMail:
            
            isTrue = [RegularCheck regularTextFiledLengthEMail:textFiled];
            break;

            // 信用卡有效期
        case TextFiledType4Dig:
            
            isTrue = [RegularCheck regularOfTextFiledType4Dig:textFiled];
            break;
            
            // 信用卡安全码
        case TextFiledType3Dig:
            
            isTrue = [RegularCheck regularOfTextFiledType3Dig:textFiled];
            break;
            
            // 汉字不做处理
        case TextFiledTypeChinese:
            break;
            
        default:
            break;
    }
    
    return [textFiled checkedValue:isTrue isHaveBox:isHave warType:warType warError:warError warNull:warNoNul keepara:keepar];;
}


- (void)removedelegate{

    if (self.delegate) {
        self.delegate = nil;
    }
}

@end
