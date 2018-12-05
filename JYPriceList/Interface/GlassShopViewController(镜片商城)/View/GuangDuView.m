//
//  GuangDuView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "GuangDuView.h"

#import "CatListModel.h"

@interface GuangDuView ()

@property (weak, nonatomic) IBOutlet UIImageView *guangDuImgView;



@end

@implementation GuangDuView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"GuangDuView" owner:self options:nil].lastObject;
    }
    
    return self;
}

-(void)buildNowGuangDuModel:(CatListModel *)model{
    
    [self.guangDuImgView sd_setImageWithURL:[NSURL URLWithString:model.now_guangdu]];
    
}

-(void)buildSpecifGuangDuModel:(CatListModel *)model{
    [self.guangDuImgView sd_setImageWithURL:[NSURL URLWithString:model.custom_guangdu]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
