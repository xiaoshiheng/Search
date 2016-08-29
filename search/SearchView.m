//
//  SearchView.m
//  searchtest
//
//  Created by Mrxiao on 16/8/2.
//  Copyright © 2016年 MRxiao. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:nil options:nil] lastObject];
        
       // _searchText.delegate = self;
        _searTable.delegate = self;
        _searTable.dataSource = self;
        _allArry = [NSArray arrayWithObjects:@"asssssss",@"oooooo",@"好看",@"奥迪",@"系一个",@"iiiiii",@"胡锦涛一行",@"88888",@"11111111",@"234325",nil];
        //_currentArry = [[NSMutableArray alloc]initWithArray:_allArry];
        _currentArry = [[NSMutableArray alloc]initWithCapacity:0];
        _allLetterArry = [[NSMutableArray alloc]initWithCapacity:0];
        _theFirstLetterArry = [[NSMutableArray alloc]initWithCapacity:0];
        for (NSString *thestr in _allArry) {
            NSString *endstr = [self makeLetterStr:thestr];
            [_theFirstLetterArry addObject:endstr];
            
        }
        NSLog(@"%@",_theFirstLetterArry);
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchange:) name:UITextFieldTextDidChangeNotification object:nil];

        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_currentArry count]>0) {
        return [_currentArry count];
    }
    return [_allArry count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if ([_currentArry count]>0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[_currentArry objectAtIndex:indexPath.row]];
    }else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[_allArry objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

-(void)textchange:(NSNotification *)dict
{
  //  NSLog(@"%@",dict);
   // [_currentArry removeAllObjects];
    UITextField *textfield = dict.object;
    NSString *searStr = textfield.text;
    NSLog(@"%@",textfield.text);
    //_currentArry = [NSMutableArray arrayWithArray:_allArry];
//    [_currentArry insertObject:textfield.text atIndex:0];
//    if ([_currentArry count]>5) {
//        [_currentArry removeObjectsInRange:NSMakeRange(5, [_currentArry count]-5)];
//    }
    NSLog(@"%@",_currentArry);
//    for (NSString *str in _theFirstLetterArry) {
//        if ([str rangeOfString:textfield.text].location != NSNotFound) {
//            [_currentArry addObject:str];
//        }
//    }
    for(int i=0; i< [searStr length];i++){
        NSString *hanzistr = [searStr substringWithRange:NSMakeRange(i, 1)];
        int a = [searStr characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
           // if ([str rangeOfString:textfield.text].location != NSNotFound)
            [self removestr:hanzistr index:i];
        }else
        {
            [self addletter:hanzistr index:i];
        }
    }
    NSLog(@"%@",_currentArry);
    
    [_searTable reloadData];
    //NSLog(@"%@",[dict.userInfo objectForKey:@"object"].text);
    
}
-(void)removestr:(NSString *)thestr index:(int)thedex
{
    BOOL ishas = NO;
    if (thedex==0) {
        for (NSString *str in _allArry) {
            if ([str rangeOfString:thestr].location != NSNotFound)
            {
                for (NSString *thestrfirst in _currentArry) {
                    if ([thestrfirst isEqualToString:str]){
                        ishas = YES;
                        break;
                    }
                }
                if (!ishas) {
                    [_currentArry addObject:str];
                }
                
                
            }
        }
    }else
    {
        NSString *str = @"";
        for (NSString *thestrfirst in _currentArry) {
            str = thestrfirst;
            if ([thestrfirst rangeOfString:thestr].location != NSNotFound){
                ishas = YES;
                break;
            }
        }
        if (ishas) {
            [_currentArry addObject:str];
        }

    }

    
}

-(void)addletter:(NSString *)thele index:(int)thedex
{
    BOOL ishas = NO;
    if (thedex == 0) {
        for (int i = 0 ;i<[_theFirstLetterArry count]; i++) {
            NSString *str = [_theFirstLetterArry objectAtIndex:i];
            if ([str rangeOfString:thele].location != NSNotFound || [str rangeOfString:thele.uppercaseString].location != NSNotFound)
            {
                str = [_allArry objectAtIndex:i];
                for (NSString *thestrfirst in _currentArry) {
                    if ([thestrfirst isEqualToString:str]){
                        // [_currentArry addObject:str];
                        ishas = YES;
                        break;
                    }
                }
                if (!ishas) {
                    [_currentArry addObject:str];
                }
                
            }
        }
    }else
    {
        
    }


}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"kai shi bian ji");
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"－－－－－－－－－－－－%@",textField.text);
    NSLog(@"－－－＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝%@",string);
    NSLog(@"range.location=================%lu",(unsigned long)range.location);
     NSLog(@"range.length====================%lu",(unsigned long)range.length);
    if (range.length>0) {
        if ([_allLetterArry count]>range.length) {
            [_allLetterArry removeObjectAtIndex:range.location];
        }
        
    }else
    {
        [_allLetterArry addObject:string];
    }
    NSLog(@"_allLetterArry===============%@",_allLetterArry);
    [_currentArry removeAllObjects];
    for (NSString *str in _allLetterArry) {
        [self checkStr:str];
    }
    
    return YES;
}

-(void)checkStr:(NSString *)thestr
{
    BOOL iscontent = NO;
    for (NSString *str in _allArry) {
        NSArray *thearry = [self IsChinese:str];
        if ([self isContentStr:thearry theCheckStr:thestr]) {
            NSLog(@"bao han le");
            if ([_currentArry count]>0) {
                for (NSString *ishasstr in _currentArry) {
                    if ([ishasstr isEqualToString:str]) {
                        iscontent = YES;
                        break;
                    }
                }
                if (!iscontent) {
                    [_currentArry addObject:str];
                }

            }else
            {
                [_currentArry addObject:str];
            }
        }
    }
    NSLog(@"%@",_currentArry);
    [_searTable reloadData];
}
- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

-(NSArray *)IsChinese:(NSString *)str
{
    NSMutableArray *firstLetterArry = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i=0; i< [str length];i++){
        NSString *hanzistr = [str substringWithRange:NSMakeRange(i, 1)];
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            NSString *firstLetterStr = [self firstCharactor:hanzistr];
            [firstLetterArry addObject:firstLetterStr];
        }
    }
    return firstLetterArry;
}

-(NSString *)makeLetterStr:(NSString *)str
{
    NSString *letterStr = @"";
    for(int i=0; i< [str length];i++){
        NSString *hanzistr = [str substringWithRange:NSMakeRange(i, 1)];
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            NSString *firstLetterStr = [self firstCharactor:hanzistr];
           // [firstLetterArry addObject:firstLetterStr];
            letterStr = [letterStr stringByAppendingString:firstLetterStr];
        }else
        {
            letterStr = [letterStr stringByAppendingString:hanzistr];
        }
        
    }

    
    return letterStr;
}

-(BOOL)isContentStr:(NSArray *)arry theCheckStr:(NSString *)checkstr
{
    for (NSString *str in arry) {
        if ([str isEqualToString:checkstr.uppercaseString]) {
            return YES;
        }
    }
    return NO;
}

@end
