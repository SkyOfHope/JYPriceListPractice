//
//  Person.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/30.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RogueDelegate.h"
#import "GentleDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<RogueaAndDelegate, GentleDelegate>

+(void)action;

-(void)eat;

@end

NS_ASSUME_NONNULL_END
