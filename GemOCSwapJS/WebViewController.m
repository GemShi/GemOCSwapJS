//
//  WebViewController.m
//  GemOCSwapJS
//
//  Created by GemShi on 2017/3/12.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "GemJSObject.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface WebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [btn setTitle:@"OC调用JS" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(OCCallJS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 150, 100, 50)];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickToBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //创建UIWebView并加载本地HTML
    NSURL *htmlURL = [[NSBundle mainBundle]URLForResource:@"js.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    self.webView.scrollView.bounces = NO;//设置webView的回弹效果
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;//设置webView滚动速度为正常速度
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickToBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)handleCustomAction:(NSURL *)url
{
    if ([url.host isEqualToString:@"getLocation"]) {
        [self getLocation];
    }
}

-(void)getLocation
{
    //获取位置信息，将结果返回给js
    NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')",@"北京市朝阳区XXX号"];
    [self.webView stringByEvaluatingJavaScriptFromString:jsStr];
    
    /**
     补充：在JS代码中调OC，也需要传参数到OC中，就像一个get请求一样，把参数放在后面。
     function shareClick() {
     loadURL("haleyAction://shareClick?title=测试分享的标题&content=测试分享的内容&url=http://www.baidu.com");
     }
     */
}

#pragma mark - webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //JS调OC方法一：拦截不正常URL
    if ([request.URL.absoluteString isEqualToString:@"非正常的URL头"]) {
        //调用OC的方法
        [self handleCustomAction:request.URL];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //JS调OC方法二
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
    JSContext *context1 = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context1[@"JSCallOCWithBlock"] = ^(NSString *str){
        NSLog(@"OC的Block被调用：%@",str);
    };
    
    //JS调OC方法三
    JSContext *context2 = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    GemJSObject *jsObject = [[GemJSObject alloc]init]; //创造一个对象
    context2[@"JSCallOCWithObject"] = jsObject;	//将对象注入JS运行环境
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - OC中调用JS
-(void)OCCallJS
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *jsString = [NSString stringWithFormat:@"alert('%@')",@"这是OC调用JS"];
    [context evaluateScript:jsString];
}

@end
