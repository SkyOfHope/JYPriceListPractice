//
//  Person+Property.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/30.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "Person+Property.h"


// 定义关联的key
static const char *key = "textTwo";
@implementation Person (Property)

-(NSString *)textTwo{
    
    //根据关联的key,获取关联的值
    return objc_getAssociatedObject(self, key);
}

-(void)setTextTwo:(NSString *)textTwo{
    
    //第一个参数:给哪个对象添加关联
    //第二个参数:关联的key,通过这个key获取
    //第三个参数:关联的value
    //第四个参数:关联的策略
    objc_setAssociatedObject(self, key, textTwo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
// your override#pragma clang diagnostic pop

+(void)action{
    NSLog(@"跳跳跳跳跳");
}
-(void)eat{
    NSLog(@"喝喝喝喝喝");
}

@end
