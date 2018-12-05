//
//  ShowQrcodeView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "ShowQrcodeView.h"


@interface ShowQrcodeView ()

@end

@implementation ShowQrcodeView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ShowQrcodeView" owner:self options:nil].lastObject;
        
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressSave)];
//        longPress.minimumPressDuration = 2;
        UITapGestureRecognizer *tapPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressSave)];
        
        [self.qrcodeImg addGestureRecognizer:tapPress];
        
    }
    
    return self;
}

//隐藏界面
-(void)hideControl{
    [UIView animateWithDuration:.3 animations:^{
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - 点击事件

-(void)tapPressSave{
    NSLog(@"长安点击下载图片");
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgUrlStr]];
        UIImage *image = [UIImage imageWithData:data]; // 取得图片
        [self saveImageToPhotos:image];
        //        [s];
    });
    
    
}

//将图片保存到相册
- (void)saveImageToPhotos:(UIImage*)savedImage{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self hideControl];
}

- (IBAction)buttonClickAction:(UIButton *)sender {
    [self hideControl];
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([event touchesForView:self]) {
        [self hideControl];
    }
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
