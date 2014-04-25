//
//  MainViewController.m
//  Multi_TableView_Demo
//
//  Created by gonghuan on 14-4-24.
//  Copyright (c) 2014年 gonghuan. All rights reserved.
//

#import "MainViewController.h"
#import "ItemSelectView.h"

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *datas           = [[[NSArray alloc] initWithObjects:
                                        [NSArray arrayWithObjects:@"iOS",@"android",@"C",@"C++",@"OC",@"JAVA", nil],
                                        [NSArray arrayWithObjects:@"php",@"c#",@"FMDB",@"sqlite",@"odbc",@"photoshop", nil],
                                        [NSArray arrayWithObjects:@"javascript",@"xml",@"html",@"cocos2D",@"u3d",@"sjjg", nil],
                                        nil] mutableCopy];
    
    
    
    ItemSelectView *itemSelectView = [[ItemSelectView alloc] initWithFrame:CGRectZero Arrdatas:datas];
    itemSelectView.oneClickType = TwoTablesDisplay;
    itemSelectView.twoClickType = OneTableDisPlay;
    itemSelectView.threeClickType = TwoTablesDisplay;
    itemSelectView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:itemSelectView];
    
}



@end
