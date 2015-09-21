//
//  ViewController.m
//  searchDemo
//
//  Created by 牟亚诚 on 15/9/21.
//  Copyright © 2015年 牟亚诚. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "PoperView.h"
@interface ViewController ()

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) AFHTTPRequestOperation *operation;
@property (strong, nonatomic) PoperView *poperView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 30)];
    self.textField.placeholder = @"开始输入";
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification object:nil];
}


- (void)textFieldChanged{
    if (_operation) {
        [_operation cancel];
    }
    [self getSearchData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField endEditing:YES];
}

- (void)getSearchData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *apikey = @"1344a966accdd811c13c3b35e01f8405";
    AFHTTPRequestSerializer *serializer = [[AFHTTPRequestSerializer alloc]init];
    [serializer setValue:apikey forHTTPHeaderField: @"apikey"];
    manager.requestSerializer = serializer;
    NSString *s = _textField.text;
    
    AFHTTPRequestOperation *op = [manager GET:@"http://apis.baidu.com/geekery/music/query" parameters:@{@"s":s} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (_operation.isCancelled) {
            NSLog(@"operation is canceled");
        }else{
            NSLog(@"%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *array = dic[@"data"][@"data"][@"list"];
            NSMutableArray *dataArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                [dataArray addObject:dic[@"songName"]];
            }
            _poperView = [[PoperView alloc]initWithSuperViewFrame:self.view.bounds andData:dataArray];
            [self.view addSubview:_poperView];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", _operation.description);
        [_poperView dismissView];
    }];
    _operation = op;
}

@end
