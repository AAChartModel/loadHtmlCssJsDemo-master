//
//  ViewController.m
//  JSCallOC
//
//  Created by Danny boy on 15/11/17.
//  Copyright © 2015年 Danny boy. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "LoginVC.h"

@interface ViewController ()
@property (nonatomic,strong) UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 300)];
    _webview.backgroundColor = [UIColor cyanColor];
    _webview.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:_webview];

    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *localUrl = [[NSURL alloc] initFileURLWithPath:htmlPath];
    [_webview loadRequest:[NSURLRequest requestWithURL:localUrl]];
    
    
    JSContext *context = [_webview  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
     context[@"print"] = ^() {
        [self presentLoginVC];
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        
    };
    context[@"打印"] = ^() {
        [self presentLoginVC];
         NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
  
        
    };
    

}


-(void)presentLoginVC{
    LoginVC *vc = [[LoginVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
