//
//  ItemSelectView.m
//  Multi_TableView_Demo
//
//  Created by gonghuan on 14-4-24.
//  Copyright (c) 2014年 gonghuan. All rights reserved.
//

#import "ItemSelectView.h"

@interface ItemSelectView ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    UIView              *mainContentBG;
    UIWindow            *mainWindow;
    
    
    NSMutableArray      *datas;
    
    //
    Gh_DisplayTableType oneType;
    Gh_DisplayTableType twoType;
    Gh_DisplayTableType threeType;
    
    
    UITableView         *leftTableView;
    UITableView         *rightTableView;
}


@end

@implementation ItemSelectView

- (id)initWithFrame:(CGRect)frame Arrdatas:(NSMutableArray *)Arrdatas
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;

        
        //
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        
        
        datas               = Arrdatas;
        
        
        
        //
        [self initWithSubViews];
    }
    
    return self;
}

#pragma mark - setter

- (void)setOneClickType:(Gh_DisplayTableType)oneClickType
{
    if (oneClickType != oneType) {
        oneType = oneClickType;
    }
}

- (void)setTwoClickType:(Gh_DisplayTableType)twoClickType
{
    if (twoType != twoClickType) {
        twoType = twoClickType;
    }
}

- (void)setThreeClickType:(Gh_DisplayTableType)threeClickType
{
    if (threeType != threeClickType) {
        threeType = threeClickType;
    }
}

#pragma mark - Private Metods
- (void)initWithSubViews
{
    
    //
    UIView *SelectBG = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 40)];
    SelectBG.backgroundColor = [UIColor redColor];
    [self addSubview:SelectBG];
    
    //
    float _x = 0;
    for (int i = 0; i < 3; i++) {
        UIButton *selectItem = [[UIButton alloc] initWithFrame:CGRectMake(_x, 0, 320/3.0, 40)];
        NSString *st = [NSString stringWithFormat:@"标题%d",i];
        [selectItem setTitle:st forState:UIControlStateNormal];
        selectItem.titleLabel.font = [UIFont systemFontOfSize:12];
        selectItem.titleLabel.textAlignment  = NSTextAlignmentCenter;
        selectItem.tag = 1+i;
        [selectItem addTarget:self action:@selector(didClickAction:) forControlEvents:UIControlEventTouchUpInside];
        selectItem.backgroundColor = [UIColor orangeColor];
        [SelectBG addSubview:selectItem];
        
        _x += 107;
    }
    
    
    
    //
    if (mainWindow == nil) {
        mainContentBG = [[UIView alloc] initWithFrame:CGRectMake(0, 64+40, 320, 568-64-40)];
        mainContentBG.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        mainContentBG.hidden = YES;
        [self addSubview:mainContentBG];
        
        
        mainWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 104, 320, 200)];
        mainWindow.windowLevel = UIWindowLevelStatusBar;
        mainWindow.backgroundColor = [UIColor lightGrayColor];
        mainWindow.hidden = YES;
        
    }

}

#pragma mark - Private Methods
- (void)showOneTableView
{
    if (rightTableView == nil) {
        rightTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    }
    rightTableView.frame = CGRectMake(0, 0, 320, 220);
    rightTableView.showsVerticalScrollIndicator = NO;
    rightTableView.dataSource = self;
    rightTableView.delegate = self;
    rightTableView.tag = 102;
    [mainWindow addSubview:rightTableView];
}

- (void)showTwoTablesView
{
    if (leftTableView == nil) {
        leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 220)];
        leftTableView.showsVerticalScrollIndicator = NO;
        leftTableView.dataSource = self;
        leftTableView.delegate = self;
        leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        leftTableView.tag = 101;
        [mainWindow addSubview:leftTableView];
    }
    
    if (rightTableView == nil) {
        rightTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    }
    rightTableView.frame = CGRectMake(100, 0, 220, 220);
    rightTableView.showsVerticalScrollIndicator = NO;
    rightTableView.dataSource = self;
    rightTableView.delegate = self;
    rightTableView.tag = 102;
    [mainWindow addSubview:rightTableView];
}


#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 101) {
        return datas.count;
    }else if (tableView.tag == 102){
        return [[datas objectAtIndex:section] count];
    }
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView.tag == 101) {
        static NSString *identifior = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifior];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifior];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"标题%ld",(long)indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        return cell;
    }else if (tableView.tag == 102){
        
        static NSString *Ridentifior = @"Rcell";
        UITableViewCell *Rcell = [tableView dequeueReusableCellWithIdentifier:Ridentifior];
        
        if (Rcell == nil) {
            Rcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Ridentifior];
        }
        
        NSArray *ar = datas[indexPath.section];
        Rcell.textLabel.text = [NSString stringWithFormat:@"%@",ar[indexPath.row]];
        Rcell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        Rcell.textLabel.textAlignment = NSTextAlignmentLeft;
        
        return Rcell;
    }
    
    return cell;
    
}

static NSInteger lastClickR = -1;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101 ) {
        //
        datas           = [[[NSArray alloc] initWithObjects:
                            [NSArray arrayWithObjects:@"iOS",@"android",@"C",@"C++",@"OC",@"JAVA", nil],
                            [NSArray arrayWithObjects:@"php",@"c#",@"FMDB",@"sqlite",@"odbc",@"photoshop", nil],
                            [NSArray arrayWithObjects:@"javascript",@"xml",@"html",@"cocos2D",@"u3d",@"sjjg", nil],
                            nil] mutableCopy];
        
        NSUInteger Ri = indexPath.row;
        if (Ri == lastClickR) {
            return;
        }
        
        [datas exchangeObjectAtIndex:0 withObjectAtIndex:Ri];
        
        
        [rightTableView reloadData];
        
        
        lastClickR = indexPath.row;
    }
}


#pragma mark - Action Methods
static NSInteger lastClickIndex = 0;

- (void)didClickAction:(UIButton *)button
{
    
    if (lastClickIndex == button.tag || lastClickIndex == 0) {
        if (mainWindow.hidden) {
            mainWindow.hidden = NO;
            mainContentBG.hidden = NO;
        }else{
            mainWindow.hidden = YES;
            mainContentBG.hidden = YES;
        }
    }else{
        
        mainWindow.hidden = YES;
        mainContentBG.hidden = YES;
        
        
        mainWindow.backgroundColor = [UIColor clearColor];
        [self performSelector:@selector(show) withObject:nil afterDelay:0.2];
        
    }
    
    
    
    
    switch (button.tag) {
        case 1:
            
            if (oneType == OneTableDisPlay) {
                [self showOneTableView];
            }else{
                [self showTwoTablesView];
            }
            
            break;
        case 2:
            
            if (twoType == OneTableDisPlay) {
                [self showOneTableView];
            }else{
                [self showTwoTablesView];
            }
            break;
        case 3:
            
            if (threeType == OneTableDisPlay) {
                [self showOneTableView];
            }else{
                [self showTwoTablesView];
            }
            break;
        default:
            break;
    }
    
    //
    lastClickIndex = button.tag;
}

- (void)tapAction:(UIGestureRecognizer *)tap
{
    if ([tap.view isKindOfClass:[UIView class]] && mainWindow.hidden == NO) {
        
        
        //
        if (mainWindow.hidden == NO) {
            mainWindow.hidden = YES;
            mainContentBG.hidden = YES;
        }
    }
}



#pragma mark - Private Methods
- (void)show
{
    mainWindow.hidden = NO;
    mainContentBG.hidden = NO;
}



- (void)dealloc
{
    [mainWindow removeFromSuperview];
    mainWindow = nil;
    [mainContentBG removeFromSuperview];
    mainContentBG = nil;
}




@end
