//
//  ViewController.m
//  TestLanguageChange
//
//  Created by Hepburn on 2018/8/17.
//  Copyright © 2018年 Hepburn. All rights reserved.
//

#import "ViewController.h"
#import "LanguageManager.h"

@interface ViewController () {
    UILabel *mlbHelp;
    UILabel *mlbAbout;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mlbHelp = [[UILabel alloc] initWithFrame:CGRectMake(40, 80, 100, 20)];
    mlbHelp.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:mlbHelp];
    
    mlbAbout = [[UILabel alloc] initWithFrame:CGRectMake(40, 120, 100, 20)];
    mlbAbout.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:mlbAbout];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(40, 160, 100, 40);
    btn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [btn addTarget:self action:@selector(OnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self RefreshText];
}

- (void)OnButtonClick {
    [[LanguageManager sharedInstance] changeNowLanguage];
    [self RefreshText];
}

- (void)RefreshText {
    mlbHelp.text = LL(@"Me.Help");
    mlbAbout.text = LL(@"Me.About");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
