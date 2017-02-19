//
//  ViewController.m
//  jwTextFiled
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+Exten.h"

@interface ViewController ()
{
    NSArray *_tfs;
    NSArray *_errors;
    NSArray *_noulls;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tfs = @[_userNameTF,
                _idCardTF,
                _bankCardTF,
                _phoneTF,
                _smsCodeTF,
                _dateTF,
                _safeCodeTF];
    
    _errors = @[@"用户名不符合规则",
                @"身份证不符合规则",
                @"银行卡号不符合规则",
                @"手机号不符合规则",
                @"短信验证码不符合规则",
                @"有效期不符合规则",
                @"安全码不符合规则"];
    
    _noulls =  @[@"用户名不能为空",
                 @"身份证不能为空",
                 @"银行卡号不能为空",
                 @"手机号不能为空",
                 @"短信验证码不能为空",
                 @"有效期不能为空",
                 @"安全码不能为空"];
    
    // 设置对应的输入框类型
    [_userNameTF jw_TextFiledType:TextFiledTypeUserName];
    [_idCardTF jw_TextFiledType:TextFiledTypeIDCard];
    [_bankCardTF jw_TextFiledType:TextFiledTypeBankCard],
    [_phoneTF jw_TextFiledType:TextFiledTypePhone],
    [_smsCodeTF jw_TextFiledType:TextFiledTypeSmsCode],
    [_dateTF jw_TextFiledType:TextFiledType4Dig],
    [_safeCodeTF jw_TextFiledType:TextFiledType3Dig];
    
    // 自动获取焦点
    [_userNameTF jw_AutoGetFocusTfAry:_tfs index:0];
    
}

- (IBAction)clickBtn:(id)sender {
    
    BOOL isok = [_userNameTF jw_pollingTextFileds:_tfs
                                        isHaveBox:YES
                                        warErrors:_errors
                                       warNoNulls:_noulls
                                      withBoxType:WarTypeBlack
                                   isAutoGetFocus:YES
                                          keepara:nil];
    
    if (isok) {
        
        NSLog(@"执行下面逻辑");
    }else {
        NSLog(@"不能执行下面的逻辑");
    }
    
}

// 清除错误
- (IBAction)clearTfsBtn:(id)sender {
    
    for (UITextField *obj in _tfs) {
        obj.text = @"";
    }
}

// 回收键盘
- (IBAction)recycKeyBoard:(id)sender {
    [self.view endEditing:YES];
}

// 一键填写
- (IBAction)onceFillIn:(id)sender {
    
    NSString *warToyouStr = @"你可在代码中去，修改任何一个输入框的填写值，点击按钮去运行效果";
    
    [AutoAttentionView autoShowAttentionWith:warToyouStr andWith:self.view hScale:-0.8f];
    
    [_userNameTF setText:@"5454rwecss"];
    [_idCardTF setText:@"123123121231"];
    [_bankCardTF setText:@"6228480402564890018"],
    [_phoneTF setText:@"000000000"],
    [_smsCodeTF setText:@"000000000"],
    [_dateTF setText:@"0000"],
    [_safeCodeTF setText:@"000"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
