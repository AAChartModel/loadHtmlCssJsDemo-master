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
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
 
    
    NSString *urlstring=@"https://www.apple.com/cn/";
    //抓取网页中 网释义内容
    NSString * encodedString1 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlstring, NULL, NULL,  kCFStringEncodingUTF8 ));
    
    NSURL *url1 = [NSURL URLWithString:encodedString1];
    NSString *retStr = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];//[[NSString alloc] initWithData:data encoding:];
    NSLog(@" html = %@",retStr);
    
    NSMutableString *mutableString = (NSMutableString *)retStr;
    //2.【字符串覆盖】
//    NSRange range={0,mutableString.length-1};//字符串覆盖另一个字符串（覆盖范围可以设定）
//   [mutableString  replaceCharactersInRange:range withString:htmlCont];
    
//   mutableString= @"<a href=\"http\">这是要截取的内容</a>";
    NSRange startRange = [mutableString rangeOfString:@"<!DOCTYPE html>"];
    NSRange endRange = [mutableString rangeOfString:@"</html>"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [mutableString substringWithRange:range];
    
    
    NSString * string=(NSString *)mutableString;
    string=[string stringByReplacingOccurrencesOfString:result withString:htmlCont];

    
    [self.webView loadHTMLString:string baseURL:baseURL];
    
    
//    NSString *string = @"<a href=\"http\">这是要截取的内容</a>";
//    NSRange startRange = [string rangeOfString:@"\">"];
//    NSRange endRange = [string rangeOfString:@"</"];
//    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
//    NSString *result = [string substringWithRange:range];
//    NSLog(@"%@",result);
    
    
//    NSString * string=@"2011-11-29";
//    string=[string stringByReplacingOccurrencesOfString:@"-"withString:@"/"];
    
    
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
