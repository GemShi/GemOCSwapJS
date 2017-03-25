//
//  ViewController.m
//  GemOCSwapJS
//
//  Created by GemShi on 2017/3/12.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "Point3D.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [btn setTitle:@"jumpToJS" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickToJS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //JSCore的一些用法
    [self JSCore];
    
    //JSExport
    [self point3D];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 跳转到JS页面
-(void)clickToJS
{
    WebViewController *webView = [[WebViewController alloc]init];
    [self presentViewController:webView animated:YES completion:nil];
}

#pragma mark - JSCore
-(void)JSCore
{
    //JSContext上下文，提供运行环境
    JSContext *context = [[JSContext alloc]init];
    //从JS环境里取函数或者变量
    JSValue *value = [context evaluateScript:@"1 + 2"];
    double result = [value toDouble];
    NSLog(@"%f",result);
}

#pragma mark - JSExport
-(void)point3D
{
    JSContext *context = [[JSContext alloc]init];
    Point3D *point3D = [[Point3D alloc]initWithContext:context];
    point3D.x = 1;
    point3D.y = 2;
    point3D.z = 3;
    context[@"point3D"] = point3D;
    NSString *script = @"point3D.length()";
    JSValue *value = [context evaluateScript:script];
    NSLog(@"%@  %f",script,[value toDouble]);
}

#pragma mark - 加载本地.js文件
-(void)loadScriptWithContext:(JSContext *)context AndFileName:(NSString *)fileName
{
    NSString *filePath = [NSString stringWithFormat:@"%@/JS/%@",[[NSBundle mainBundle] resourcePath],fileName];
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [context evaluateScript:script];
}

@end
