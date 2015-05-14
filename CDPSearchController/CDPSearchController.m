//
//  CDPSearchController.m
//  searchController
//
//  Created by 柴东鹏 on 15/5/14.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "CDPSearchController.h"

@implementation CDPSearchController{
    UIViewController *_controller;//调用CDPSearchController的controller
    
    UITableViewController *_tableViewController;//显示搜索结果的tableView
    UISearchController *_searchController;//searchController
    
    NSArray *_dataArr;//总数据源
    
    NSMutableString *_predicateStr;//谓词语句
}

//初始化
-(id)initWithController:(UIViewController <UITableViewDelegate,UITableViewDataSource> *)controller dataArr:(NSArray *)dataArr prompt:(NSString *)prompt placeholder:(NSString *)placeholder parameterArr:(NSArray *)parameterArr{
    if (self=[super init]) {
        _controller=controller;
        _prompt=prompt;
        _placeholder=placeholder;
        _parameterArr=parameterArr;
        _dataArr=[[NSArray alloc] initWithArray:dataArr];
        _searchResultArr=[[NSMutableArray alloc] init];
        _predicateStr=[[NSMutableString alloc] init];

        
        _tableViewController=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
        _tableViewController.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
        _searchTableView=_tableViewController.tableView;
        _tableViewController.tableView.delegate=controller;
        _tableViewController.tableView.dataSource=controller;
        
        _searchController=[[UISearchController alloc] initWithSearchResultsController:_tableViewController];
        _searchController.searchResultsUpdater=self;
        _searchController.searchBar.prompt=_prompt;
        _searchController.searchBar.placeholder=_placeholder;
        
        [_controller presentViewController:_searchController animated:YES completion:nil];
    }
    
    return self;
}
//设置搜索标题
-(void)setPrompt:(NSString *)prompt{
    _prompt=prompt;
    _searchController.searchBar.prompt=_prompt;
}
//设置搜索栏为空时默认显示的灰色字
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder=placeholder;
    _searchController.searchBar.placeholder=_placeholder;
}
#pragma mark - UISearchResultsUpdating监听者搜索框中的值的变化

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{

    NSString *searchStr = searchController.searchBar.text;
    
    _predicateStr=[NSMutableString stringWithFormat:@""];
    
    for (NSString *parameterStr in _parameterArr) {
        [_predicateStr appendString:[NSString stringWithFormat:@"self.%@ CONTAINS [CD] '%@' OR ",parameterStr,searchStr]];
    }

    [_predicateStr deleteCharactersInRange:NSMakeRange(_predicateStr.length-4,4)];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:_predicateStr];
    
    _searchResultArr = [NSMutableArray arrayWithArray:[_dataArr filteredArrayUsingPredicate:predicate]];
    
    [_tableViewController.tableView reloadData];
}











@end
