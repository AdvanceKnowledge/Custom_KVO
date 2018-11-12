//
//  ViewController.m
//  Custom_KVO
//
//  Created by 王延磊 on 2018/11/8.
//  Copyright © 2018 追@寻. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

#import "NSObject+NSObject_KVO.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showName_Lab;
/** gou */


@property (nonatomic, strong) Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *p = [[Person alloc]init];
    [p custom_KVO:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil block:^(id  _Nullable objc1, NSDictionary * _Nullable objc2) {
        self.showName_Lab.text = objc2[@"key"];
    }];
    _person = p;
}

- (IBAction)change_Name:(UIButton *)sender {
    self.person.name = [NSString stringWithFormat:@"姓名%d",arc4random_uniform(1000)];
}

@end
