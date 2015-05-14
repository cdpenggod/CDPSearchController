//
//  CDPSearchModel.h
//  searchController
//
//  Created by 柴东鹏 on 15/5/14.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDPSearchModel : NSObject

@property (nonatomic,strong) NSString *nameStr;//姓名

@property (nonatomic,strong) NSString *phoneStr;//电话

@property (nonatomic,strong) NSString *signStr;//签名

//初始化
-(id)initWithNameStr:(NSString *)name andPhoneStr:(NSString *)phone signStr:(NSString *)sign;


@end
