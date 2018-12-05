//
//  GentleDelegate.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/6.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 君子协议
 **/

@protocol GentleDelegate <NSObject>

/*
 协议内容只能有方法不能有属性
 */
//协议方法
//动口不动手
-(void)gentleFight;

//爱财取之有道
-(void)gentleLoveMony;


@end


@interface GentleDelegate : NSObject

@end

NS_ASSUME_NONNULL_END
