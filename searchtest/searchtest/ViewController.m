//
//  ViewController.m
//  searchtest
//
//  Created by Mrxiao on 16/8/2.
//  Copyright © 2016年 MRxiao. All rights reserved.
//

#import "ViewController.h"
#import "SearchView.h"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UISearchController *searchcontroller;
@property (weak, nonatomic) IBOutlet UITextField *searchtxt;
@property (nonatomic, strong) SearchView *searchView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _searchtxt.delegate = self;
}

-(void)textchange:(NSNotification *)dict
{
    NSLog(@"%@",dict);
    UITextField *textfield = dict.object;
    NSLog(@"%@",textfield.text);
    //NSLog(@"%@",[dict.userInfo objectForKey:@"object"].text);
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"kai shi bian ji");
    _searchView = [[SearchView alloc]init];
    _searchView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:_searchView];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
