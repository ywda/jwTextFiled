//
//  UITextField+Exten.h
//  jwTextFiled
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwTfHeader.h"
#import "AutoAttentionView.h"

typedef void(^inputingBlock)(UITextField *tf,NSString *tfStr);

@interface UITextField (Exten)

@property (nonatomic,assign) TextFiledType oneTextFiledType;
@property (nonatomic,copy)inputingBlock tempBlock;

- (void)jw_TextFiledType:(TextFiledType)tfType;

- (BOOL)jw_pollingTextFileds:(NSArray*)textFileds
                   isHaveBox:(BOOL)isHave
                   warErrors:(NSArray*)wars
                  warNoNulls:(NSArray*)nuls
                 withBoxType:(WarType)warType
              isAutoGetFocus:(BOOL)isAuto
                     keepara:(NSString*)keepar;

- (void)jw_AutoGetFocusTfAry:(NSArray*)tfs index:(int)index;

// 使用该方法，移除代理，该分类失去作用（外界必须设置代理的时候使用）
- (void)removedelegate;

@end
