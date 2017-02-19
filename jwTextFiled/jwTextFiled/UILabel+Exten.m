//
//  UILabel+Exten.m
//  jwTextFiled
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "UILabel+Exten.h"

@implementation UILabel (Exten)

- (CGSize)jw_getLableCGsize:(CGSize)orignSize attributes:(NSDictionary*)dic{
    
    [self setLineBreakMode:NSLineBreakByCharWrapping];
    [self setNumberOfLines:0];
    
    return [self.text boundingRectWithSize:orignSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

- (BOOL)is_NoNuLL_really:(NSString*)tempStr{
    
    return ((nil != tempStr)&&
            (![tempStr isEqualToString:@""]))?YES:NO;
    
}

@end
