//
//  ViewController.m
//  ios-loadHtml
//
//  Created by An An on 15-4-22.
//  Copyright (c) 2017年 An An. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Load HTML";
    [self loadHTMLFile];
}

//Load
-(void)loadHTMLFile{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"htmlSourceCodeString"
                                                          ofType:@"txt"];
//  得到本地文件名为htmlSourceCodeString的 txt 文件中的字符串内容htmlCont
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
 
    
    NSString *urlstring=@"https://www.apple.com/cn/";
    NSString * encodedString1 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlstring, NULL, NULL,  kCFStringEncodingUTF8 ));
    
    NSURL *url1 = [NSURL URLWithString:encodedString1];
    //苹果官网中的 html 文本标签🏷内容
    NSString *retStr = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSLog(@" html = %@",retStr);
    
    NSMutableString *mutableString = (NSMutableString *)retStr;

    NSRange startRange = [mutableString rangeOfString:@"<!DOCTYPE html>"];
    NSRange endRange = [mutableString rangeOfString:@"</html>"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [mutableString substringWithRange:range];
    
    
    NSString * string=(NSString *)mutableString;
    
//将苹果官网首页的文本内容中的<!DOCTYPE html> 和</html>之间的字符串替换成htmlCont(本地文件名为htmlSourceCodeString的 txt 文件中的字符串)
    string=[string stringByReplacingOccurrencesOfString:result withString:htmlCont];
    
    [self.webView loadHTMLString:string baseURL:baseURL];
    
 
    
    
}
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType{
    
    NSURL* url = [request URL];
    NSString* urlstring = [NSString stringWithFormat:@"%@",url];
//    if ([urlstring isEqualToString:@"http://baidu.com/"]) {
//        return NO;
//    }
    NSLog(@"url = >%@",url);
    
    return YES;
}


















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
