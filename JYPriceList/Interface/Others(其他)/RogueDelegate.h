//
//  RogueDelegate.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/6.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 
 **/
@protocol RogueaAndDelegate <NSObject>

//必须实现的方法
@required
//吃
-(void)rogueEat;

//骗
-(void)rogueLie;

//可选实现的方法
@optional
-(void)rogueDrink;


@end


@interface RogueDelegate : NSObject

@end

NS_ASSUME_NONNULL_END
