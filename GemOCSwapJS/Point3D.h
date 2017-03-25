//
//  Point3D.h
//  GemOCSwapJS
//
//  Created by GemShi on 2017/3/25.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol point3DExport <JSExport>
//定义要暴露给JS的属性和方法，JS就可以对其操作了
@property double x;
@property double y;
@property double z;

-(double)length;

@end

@interface Point3D : NSObject<point3DExport>
{
    JSContext *context;
}

-(id)initWithContext:(JSContext *)ctx;

@end
