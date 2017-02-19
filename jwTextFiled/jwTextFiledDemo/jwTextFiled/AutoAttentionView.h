//
//  AutoAttentionView.h
//  jwTextFiled
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoAttentionView : UIView

/* 提示文字(str) 到 父视图上 (view) */
+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view;

/* 提示文字(str) 到 父视图上 (view) 设置提示框（偏上、中、下部位 def = 1.0f 中间<-0.80f~0.80f>）*/
+ (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view hScale:(CGFloat)scale;

@end
