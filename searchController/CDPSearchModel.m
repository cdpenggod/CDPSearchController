//
//  CDPSearchModel.m
//  searchController
//
//  Created by 柴东鹏 on 15/5/14.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "CDPSearchModel.h"

@implementation CDPSearchModel

//初始化
-(id)initWithNameStr:(NSString *)name andPhoneStr:(NSString *)phone signStr:(NSString *)sign{
    if (self=[super init]) {
        _nameStr=name;
        _phoneStr=phone;
        _signStr=sign;
        
    }
    return self;
}

@end
