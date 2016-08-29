//
//  SearchView.h
//  searchtest
//
//  Created by Mrxiao on 16/8/2.
//  Copyright © 2016年 MRxiao. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol SearchViewDelegate <NSObject>

- (void)SearchGoClick;

@end

@interface SearchView : UIView<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UITableView *searTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableBottomContraint;

@property (nonatomic, strong) NSArray *allArry;
@property (nonatomic, strong) NSMutableArray *currentArry;
@property (nonatomic, strong) NSMutableArray *allLetterArry;
@property (nonatomic, strong) NSMutableArray *theFirstLetterArry;

@property (nonatomic, weak) id<SearchViewDelegate>delegate;

@end
