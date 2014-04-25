//
//  ItemSelectView.h
//  Multi_TableView_Demo
//
//  Created by gonghuan on 14-4-24.
//  Copyright (c) 2014年 gonghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Gh_DisplayTableType) {
    OneTableDisPlay,
    TwoTablesDisplay
};

@interface ItemSelectView : UIView
//
@property (nonatomic,assign) Gh_DisplayTableType oneClickType;
@property (nonatomic,assign) Gh_DisplayTableType twoClickType;
@property (nonatomic,assign) Gh_DisplayTableType threeClickType;

//
- (id)initWithFrame:(CGRect)frame Arrdatas:(NSMutableArray *)Arrdatas;

@end
