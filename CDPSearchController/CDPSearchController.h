//
//  CDPSearchController.h
//  searchController
//
//  Created by 柴东鹏 on 15/5/14.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CDPSearchController : NSObject <UISearchResultsUpdating>

//搜索标题
@property (nonatomic,copy) NSString *prompt;

//搜索栏为空时默认显示的灰色字
@property (nonatomic,copy) NSString *placeholder;

//搜索结果数组,用来刷新显示搜索结果
@property (nonatomic,strong) NSMutableArray *searchResultArr;

//搜索参数数组
@property (nonatomic,strong) NSArray *parameterArr;

//搜索时的tableView
@property (nonatomic,strong) UITableView *searchTableView;

//初始化
//第一个参数填写调用CDPSearchController的controller,且需要遵守tableView的协议
//第二个参数填写总数据源
//第三个参数填写搜索标题
//第四个参数填写搜索栏为空时默认显示的灰色字
//第五个参数填写model中所要搜索的相关参数名数组
-(id)initWithController:(UIViewController <UITableViewDelegate,UITableViewDataSource> *)controller dataArr:(NSArray *)dataArr prompt:(NSString *)prompt placeholder:(NSString *)placeholder parameterArr:(NSArray *)parameterArr;



@end
