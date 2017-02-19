//
//  JwTfHeader.h
//  jwTextFiled
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#ifndef JwTfHeader_h
#define JwTfHeader_h

#define TextFiledLengthUserName  16
#define TextFiledLengthPsw       16
#define TextFiledLengthSmsCode    6
#define TextFiledLengthPayBox    12
#define TextFiledLengthIDCard    18
#define TextFiledLengthBankCard  20
#define TextFiledLengthPhone     11
#define TextFiledLengthEMail     30
#define TTextFiledLength4Dig      4
#define TextFiledLength3Dig       3
#define TextFiledLengthChinese   30  // 汉字输入，暂不支持！


typedef NS_ENUM(NSInteger,TextFiledType) {
    
    TextFiledTypeUserName,
    TextFiledTypePassWord,
    TextFiledTypeSmsCode,
    TextFiledTypePayBox,
    TextFiledTypeIDCard,
    TextFiledTypeBankCard,
    TextFiledTypePhone,
    TextFiledTypeEMail,
    TextFiledType4Dig,
    TextFiledType3Dig,
    TextFiledTypeChinese,
};

typedef NS_ENUM(NSInteger,WarType) {
    WarTypeDefault,
    WarTypeBlack,
};

#endif /* JwTfHeader_h */
