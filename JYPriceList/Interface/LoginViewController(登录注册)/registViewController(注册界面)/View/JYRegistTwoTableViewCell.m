
//
//  JYRegistTwoTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/20.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "JYRegistTwoTableViewCell.h"


//static NSString *const =;
@interface JYRegistTwoTableViewCell()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *lineCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *personCodeTextField;
@property (weak, nonatomic) IBOutlet UIView *provinceBackView;
@property (weak, nonatomic) IBOutlet UITableView *provinceTableView;
@property (weak, nonatomic) IBOutlet UIView *cityBackView;
@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
@property (weak, nonatomic) IBOutlet UIView *areaBackView;
@property (weak, nonatomic) IBOutlet UITableView *areaTableView;

@property (nonatomic, strong) NSMutableDictionary *mDic;

@end


@implementation JYRegistTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.mDic = [NSMutableDictionary dictionary];
    
}

#pragma mark - 点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            NSLog(@"省份按钮");
            sender.selected = !sender.selected;
            if (sender.selected == YES) {
                self.provinceBackView.hidden = NO;
            }else{
                self.provinceBackView.hidden = YES;
            }
            
        }
            break;
        case 2:{
            NSLog(@"市按钮");
            sender.selected = !sender.selected;
            if (sender.selected == YES) {
                self.cityBackView.hidden = NO;
            }else{
                self.cityBackView.hidden = YES;
            }
        }
            break;
        case 3:{
            NSLog(@"县按钮");
            sender.selected = !sender.selected;
            if (sender.selected == YES) {
                self.areaBackView.hidden = NO;
            }else{
                self.areaBackView.hidden = YES;
            }
        }
            break;
        case 4:{
            NSLog(@"上传营业照");
            self.registTwoTableViewCellBlock(sender.tag,nil);
        }
            break;
        case 6:{
            NSLog(@"同意注册");
            
            self.registTwoTableViewCellBlock(sender.tag,self.mDic);
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.shopNameTextField) {
        
    }else if (textField == self.companyAddressTextField){
        
    }else if (textField == self.lineCodeTextField){
        
    }else if (textField == self.personCodeTextField){
        
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.shopNameTextField) {
        [self.mDic setObject:textField.text forKey:@"company"];
    }else if (textField == self.companyAddressTextField){
        [self.mDic setObject:textField.text forKey:@"address"];
    }else if (textField == self.lineCodeTextField){
        [self.mDic setObject:textField.text forKey:@"zhizhao"];
    }else if (textField == self.personCodeTextField){
        [self.mDic setObject:textField.text forKey:@"parent_id"];
    }
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

@end
