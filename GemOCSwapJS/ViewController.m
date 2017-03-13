//
//  ViewController.m
//  GemOCSwapJS
//
//  Created by GemShi on 2017/3/12.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickToJS
{
    WebViewController *webView = [[WebViewController alloc]init];
    [self presentViewController:webView animated:YES completion:nil];
}

@end
