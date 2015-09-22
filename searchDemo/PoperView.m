//
//  PoperView.m
//  searchDemo
//
//  Created by 牟亚诚 on 15/9/21.
//  Copyright © 2015年 牟亚诚. All rights reserved.
//

#import "PoperView.h"
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface PoperView()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSArray *dataArray;

@end

static NSString *cellID = @"cellID";
@implementation PoperView


- (instancetype)initWithSuperViewFrame:(CGRect)frame andData:(NSArray *)dataArray{
    self = [super init];
    if (self != nil) {
        _dataArray = [dataArray copy];
        self.frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, SCREEN_HEIGHT - frame.origin.y - frame.size.height);
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_tableView];
        
        
    }
    return self;
}

- (void)showView{
    
}

- (void)dismissView{
    [self removeFromSuperview];
}

- (void)reloadTableViewDataWith:(NSMutableArray *)array{
    _dataArray = [array copy];
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArray != nil) {
        return _dataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}


@end
