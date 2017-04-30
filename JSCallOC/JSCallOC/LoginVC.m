//
//  LoginVC.m
//  JSCallOC
//
//  Created by Danny boy on 17/4/1.
//  Copyright © 2017年 Danny boy. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
  
    NSArray *btnNameArr = @[@"登录",@"退出"];
    for (int i=0; i<2; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(50, 100*i+50, 300, 40);
        btn.backgroundColor = [UIColor blueColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:btnNameArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        
    }
    

    
    
 }

-(void)btnClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
