//
//  Point3D.m
//  GemOCSwapJS
//
//  Created by GemShi on 2017/3/25.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "Point3D.h"

@implementation Point3D

@synthesize x;
@synthesize y;
@synthesize z;

-(id)initWithContext:(JSContext *)ctx
{
    if (self = [super init]) {
        context = ctx;
        context[@"point3D"] = [Point3D class];
    }
    return self;
}

-(double)length
{
    return sqrt(self.x * self.x + self.y * self.y + self.z * self.z);
}

@end
