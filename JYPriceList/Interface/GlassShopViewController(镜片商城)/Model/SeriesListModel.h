//
//  SeriesListModel.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/5.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "BaseModel.h"

@interface SeriesListModel : BaseModel

@property (nonatomic, assign) NSInteger brand_id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) BOOL  is_on_shelf;
@property (nonatomic, copy) NSString *series_name;
@property (nonatomic, assign) NSInteger sort_order;

@end
