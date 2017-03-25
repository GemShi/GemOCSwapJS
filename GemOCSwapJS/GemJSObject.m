//
//  GemJSObject.m
//  GemOCSwapJS
//
//  Created by GemShi on 2017/3/13.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "GemJSObject.h"

@implementation GemJSObject

@synthesize x;

-(void)nslog:(NSString *)str
{
    NSLog(@"%d",self.x * self.x);
    NSLog(@"OC的nslog方法被调用：%@",str);
}

@end
