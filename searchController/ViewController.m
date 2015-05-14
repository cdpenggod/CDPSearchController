//
//  ViewController.m
//  searchController
//
//  Created by 柴东鹏 on 15/5/14.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "ViewController.h"

#import "CDPSearchModel.h"

#import "CDPSearchController.h"//引入头文件

//CDPSearchController适用于iOS8.0及以上

//调用CDPSearchController的controller需要遵守以下tableView的协议

@interface ViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_dataArr;//数据源
    UITableView *_tableView;
    
    CDPSearchController *_searchController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    [self creatData];
    
    [self creatUI];
    
}
#pragma mark 创建Data和UI
//创建Data
-(void)creatData{
    CDPSearchModel *model1=[[CDPSearchModel alloc] initWithNameStr:@"王二货" andPhoneStr:@"13119491824" signStr:@"我只是个二货"];
    
    CDPSearchModel *model2=[[CDPSearchModel alloc] initWithNameStr:@"李四" andPhoneStr:@"13119412312" signStr:@"李四就是我"];
    
    CDPSearchModel *model3=[[CDPSearchModel alloc] initWithNameStr:@"菲菲" andPhoneStr:@"13119493421" signStr:@"额。。。"];
    
    CDPSearchModel *model4=[[CDPSearchModel alloc] initWithNameStr:@"女神经" andPhoneStr:@"13217491814" signStr:@"女汉子"];
    
    CDPSearchModel *model5=[[CDPSearchModel alloc] initWithNameStr:@"王小二" andPhoneStr:@"13115137224" signStr:@"小二哥"];
    
    CDPSearchModel *model6=[[CDPSearchModel alloc] initWithNameStr:@"ccToday" andPhoneStr:@"13819444824" signStr:@"gogoggo"];
    
    CDPSearchModel *model7=[[CDPSearchModel alloc] initWithNameStr:@"美美" andPhoneStr:@"13222491824" signStr:@"我去"];
    
    CDPSearchModel *model8=[[CDPSearchModel alloc] initWithNameStr:@"疯子d" andPhoneStr:@"13937182412" signStr:@"疯疯疯"];
    
    CDPSearchModel *model9=[[CDPSearchModel alloc] initWithNameStr:@"LEO" andPhoneStr:@"18231255123" signStr:@"LLLLL"];
    
    CDPSearchModel *model10=[[CDPSearchModel alloc] initWithNameStr:@"女" andPhoneStr:@"18431266123" signStr:@"女L"];

    CDPSearchModel *model11=[[CDPSearchModel alloc] initWithNameStr:@"男" andPhoneStr:@"18928171241" signStr:@"男男"];
    
    
    //创建数据源
    _dataArr=[[NSMutableArray alloc] initWithObjects:model1,model2,model3,model4,model5,model6,model7,model8,model9,model10,model11,nil];
    

}
//创建UI
-(void)creatUI{
    //搜索按钮
    UIButton *searchButton=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-20,20,40,27)];
    searchButton.backgroundColor=[UIColor whiteColor];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    //tableView
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,50,self.view.bounds.size.width,self.view.bounds.size.height-50) style:UITableViewStylePlain];
    _tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}
#pragma mark tableViewDelegate
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //判断是否搜索tableView
    return (tableView==_tableView?_dataArr.count:_searchController.searchResultArr.count);

}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cdpSearchCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cdpSearchCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.font=[UIFont systemFontOfSize:15];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    }
    //判断是否搜索tableView
    CDPSearchModel *model=(tableView==_tableView?[_dataArr objectAtIndex:indexPath.row]:[_searchController.searchResultArr objectAtIndex:indexPath.row]);
    
    cell.textLabel.text=[NSString stringWithFormat:@"姓名:%@",model.nameStr];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"电话:%@  签名:%@",model.phoneStr,model.signStr];
    
    return cell;
}
//cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tableView) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"不是搜索点击" message:[NSString stringWithFormat:@"点击了第%ld行",(long)indexPath.row] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"搜索点击" message:[NSString stringWithFormat:@"点击了第%ld行",(long)indexPath.row] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
}

//点击搜索
-(void)searchClick{
    //设置需要搜索的参数名数组,本demo根据CDPSearchModel中的nameStr和phoneStr这两个参数搜索,即姓名和电话
    //parameterArr里的参数名必须和model里的参数名一样，否则出错
    NSArray *parameterArr=@[@"nameStr",@"phoneStr"];
    
    //初始化并设置CDPSearchController
    _searchController=[[CDPSearchController alloc] initWithController:self dataArr:_dataArr prompt:@"搜索栏标题" placeholder:@"搜索为空时默认灰色字" parameterArr:parameterArr];
    
}






















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
