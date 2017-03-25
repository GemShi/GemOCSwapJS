//
//  GemJSObject.h
//  GemOCSwapJS
//
//  Created by GemShi on 2017/3/13.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol GemJSObjectExport <JSExport>

@property int x;

-(void)nslog:(NSString *)str;

@end

@interface GemJSObject : NSObject<GemJSObjectExport>

-(void)nslog:(NSString *)str;

@end
