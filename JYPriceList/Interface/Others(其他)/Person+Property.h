//
//  Person+Property.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/30.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (Property)

@property (nonatomic, copy) NSString *textTwo;

+(void)action;

-(void)eat;

/*
 KVC：把字典中所有值给模型的属性赋值。这个是要求字典中的Key,必须要在模型里能找到相应的值，如果找不到就会报错。基本原理如：
 */

@end

NS_ASSUME_NONNULL_END
