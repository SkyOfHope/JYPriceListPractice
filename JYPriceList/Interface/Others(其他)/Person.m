



//
//  Person.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/30.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "Person.h"

@interface Person ()

@property (nonatomic, strong) NSString *textOne;

@end

//默认方法都有两个隐式参数
void countenance (id self, SEL sel){
    
    NSLog(@"%@,%@", self, NSStringFromSelector(sel));
}

@implementation Person



// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(countenance)) {
        // 动态添加countenance方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(countenance), countenance, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}

-(void)eat{
    
    NSLog(@"吃吃吃吃吃");
    
}

+(void)action{
    NSLog(@"跑跑跑跑跑");
}


- (void)rogueEat {
    NSLog(@"流氓抢吃的流氓抢吃的");
}

- (void)rogueLie {
    NSLog(@"流氓撒谎流氓撒谎流氓撒谎");
}

- (void)gentleFight {
    NSLog(@"君子动口不动手");
}

- (void)gentleLoveMony {
    NSLog(@"君子爱财取之有道");
}

@end
