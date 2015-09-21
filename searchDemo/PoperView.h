//
//  PoperView.h
//  searchDemo
//
//  Created by 牟亚诚 on 15/9/21.
//  Copyright © 2015年 牟亚诚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoperView : UIView



- (instancetype)initWithSuperViewFrame:(CGRect)frame andData:(NSArray *)dataArray;

- (void)dismissView;

- (void)showView;

- (void)reloadTableViewData;

@end
