
//
//  GlassHomeViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "GlassHomeViewController.h"

#import "GlassBrandNameCollectionViewCell.h"
#import "GlassFromeSectionHeadView.h"
#import "SearchResultTableViewCell.h"

#import "GlassShopViewController.h"
#import "BrandListModel.h"
#import "BrandListSort.h"

#import "ShowLogoutView.h"

#import "MyThread.h"

#import <libkern/OSAtomic.h>

#import <objc/message.h>

#import "Person.h"
#import "Animal.h"
#import "Person+Property.h"

#import <UserNotifications/UserNotifications.h>

#import <CoreLocation/CoreLocation.h>


static NSString *const SearchResultTableViewCellId = @"SearchResultTableViewCellIdentifier";
static NSString *const GlassFromeSectionHeadViewID = @"GlassFromeSectionHeadViewIDHeader";
static NSString *const GlassBrandNameCellID = @"GlassBrandNameCollectionViewCellIdentifier";
@interface GlassHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *searchBackView;
@property (weak, nonatomic) IBOutlet UIView *searchResultBackView;
@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;
@property (weak, nonatomic) IBOutlet UIView *yinYingBackView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (nonatomic, strong) ShowLogoutView *showLogoutView;

@property (nonatomic, strong) NSMutableArray *homeGrownDataSourceArr;
@property (nonatomic, strong) NSMutableArray *enterDataSourceArr;
@property (nonatomic, strong) NSMutableArray *searchResultDataSourceArr;

@property (nonatomic, strong) NSString *keyWord;

@property (nonatomic, strong) MyThread *subThread;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSString *recId;

@property (nonatomic, strong) NSString *strongStr;

@property (nonatomic, copy) NSString *copyyStr;

@property (nonatomic, strong) CLCircularRegion *circularRegion;

/** 位置管理者 */
@property(nonatomic,strong) CLLocationManager *loactionManager;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@end

@implementation GlassHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.homeGrownDataSourceArr = [NSMutableArray array];
    self.enterDataSourceArr = [NSMutableArray array];
    self.searchResultDataSourceArr = [NSMutableArray array];
    
    
    if (![CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
        return;
    }
    
    
    
    //判断定位功能是否开启
    if([CLLocationManager locationServicesEnabled]){
        self.loactionManager = [[CLLocationManager alloc] init];
        self.loactionManager.delegate = self;
        // 定义一个CLLocationCoordinate2D作为区域的圆心
//        CLLocationCoordinate2D companyCenter;
//        companyCenter.latitude = 22;
//        companyCenter.longitude = 11;
//        // 使用CLCircularRegion创建一个圆形区域，半径为50米
//        //不要使用CLRegion
//        CLRegion *clr = [[CLCircularRegion alloc] initWithCenter:companyCenter radius:50 identifier:@"car"];
//
//        // 开始监听fkit区域
//        [self.loactionManager startMonitoringForRegion:clr];
        
        // 0.给定一个区域
        // 0.1 区域的中点坐标
        CLLocationCoordinate2D regionCenter = CLLocationCoordinate2DMake(39.92, 116.46);
        // 0.2区域半径
        CLLocationDistance distance = 1000.0;
        // ###细节一:半径有限制
        if (distance > self.loactionManager.maximumRegionMonitoringDistance) {
            distance = self.loactionManager.maximumRegionMonitoringDistance;
        }
        _circularRegion = [[CLCircularRegion alloc]  initWithCenter:regionCenter radius:distance identifier:@"BeiJing"];
        // 1.开启区域监听 代理中操作 -- 该方法只有用户位置发生了移动才会触发
        //        [self.loactionManager startMonitoringForRegion:circularRegion];
        // 1.根据指定区域请求一下监听到的状态 代理中操作 -- 该方法在程序启动就会监听一下用户的位置
        // 同样当用户位置发生变化时,也会触发相应的代理方法
        [self.loactionManager requestStateForRegion:_circularRegion];
        
    }else{
        
        //提醒用户开启定位功能
        [[[UIAlertView alloc] initWithTitle:@"当前无定位功能" message:@"开启定位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
    }
    
    //首页列表
//    [self requestBrandList];
    //首页搜索结果
//    [self requestBrandListSort];
    
    [self setUPUI];

    
    NSLog(@"%@----开辟子线程",[NSThread currentThread]);
    self.subThread = [[MyThread alloc] initWithTarget:self selector:@selector(subThreadTodo) object:nil];
    self.subThread.name = @"subThread";
    [self.subThread start];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.searchResultBackView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUPUI{
    
    self.title = @"镜片商城";
    
//    [self navigationLeftBarButtonImageNames:@[@"logo"] click:^(NSInteger buttonTag) {
//
//    }];
    
    
    UIButton *leftNavButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavButton.frame = CGRectMake(0, 0, 0, 0);
    [leftNavButton setImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
    [leftNavButton setImage:[UIImage imageNamed:@"logo"] forState:UIControlStateSelected];
    [leftNavButton setAdjustsImageWhenHighlighted:NO];
//    [leftNavButton addTarget:self action:@selector(leftNavButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //模拟器展示
//    UIBarButtonItem *leftBarButon = [[UIBarButtonItem alloc]initWithCustomView:leftNavButton];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace            target:nil action:nil];
//    negativeSpacer.width = -60;//这个数值可以根据情况自由变化
//    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarButon];
    
    UIButton *rightNavButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavButton.frame = CGRectMake(0, 0, 34, 30);
    [rightNavButton setImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    [rightNavButton setImage:[UIImage imageNamed:@"logout"] forState:UIControlStateSelected];
    [rightNavButton setAdjustsImageWhenHighlighted:NO];
    [rightNavButton addTarget:self action:@selector(rightNavButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    self.searchBackView.layer.cornerRadius = 55/2;
//    self.searchBackView.layer.masksToBounds = YES;
    
    self.searchBackView.layer.cornerRadius = 25;
    self.searchBackView.clipsToBounds = YES;
    self.yinYingBackView.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影的偏移量，默认是（0， -3）
    self.yinYingBackView.layer.shadowOffset = CGSizeMake(2, 2);
    // 设置阴影不透明度，默认是0
    self.yinYingBackView.layer.shadowOpacity = 0.7;
    // 设置阴影的半径，默认是3
    self.yinYingBackView.layer.shadowRadius = 5;
    self.yinYingBackView.layer.cornerRadius = 25.0;
    self.yinYingBackView.clipsToBounds = NO;
    
    self.inputTextField.delegate = self;
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"GlassBrandNameCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:GlassBrandNameCellID];
    [self.searchResultTableView registerNib:[UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:SearchResultTableViewCellId];
    
    //注册头
    [self.collectionView registerNib:[UINib nibWithNibName:@"GlassFromeSectionHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GlassFromeSectionHeadViewID];

    //去掉分割线
    self.searchResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - TextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
    self.keyWord = textField.text;
//    [self requestBrandList];
}






#pragma mark - 点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    NSLog(@"点击事件点击事件点击事件点击事件");
//    [self.inputTextField resignFirstResponder];
//    [self requestBrandList];
    
//    [self registerNotification:5.0];
    
    Person *p = [[Person alloc] init];
    [p rogueEat];
    [p rogueLie];
    [p gentleFight];
    [p gentleLoveMony];
    
    Animal *a = [[Animal alloc] init];
    [a rogueLie];
    [a rogueEat];
    [a gentleFight];
    [a gentleLoveMony];
}




//子线程执行的内容
- (void)subThreadTodo
{
    NSLog(@"%@----开始执行子线程任务",[NSThread currentThread]);
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
    [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    NSLog(@"%@----执行子线程任务结束",[NSThread currentThread]);
}
//我们希望放在子线程中执行的任务
- (void)wantTodo{
    //断点2
    NSLog(@"当前线程:%@执行任务处理数据", [NSThread currentThread]);
    
}

//屏幕点击事件
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    //断点1
  
    //在子线程中去响应wantTodo方法
    [self performSelector:@selector(wantTodo) onThread:self.subThread withObject:nil waitUntilDone:NO];
}






-(void)rightNavButton:(UIButton *)sender{
    NSLog(@"点击导航栏右侧按钮");
    self.showLogoutView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.showLogoutView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    [[[UIApplication sharedApplication] delegate].window addSubview:self.showLogoutView];
    
//    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.showLogoutView];
    
}


#pragma mark -  UITableViewDataSource && UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.searchResultDataSourceArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat H_distance = 15.0f;//间距——高
    CGFloat W_distance = 13.0f;//间距——宽
    
    CGFloat sum_w = 0;//总宽
    CGFloat sum_h = H_distance+30;//总高
    CGFloat one_width = 300/2/10.0f;//一个字符所占宽度
    
    BrandListSort *model1 = self.searchResultDataSourceArr[indexPath.row];
    for (int i = 0; i < model1.list.count; i++) {
        BrandListModel *model = model1.list[i];
        NSString *str = model.brand_name;
        NSInteger numberOfStr = str.length;
        sum_w+=W_distance + numberOfStr*one_width;//累加后的宽为了判断是否折行。
        
        if (sum_w>300) {//如果宽度超过了屏幕宽 则折行
            sum_w = W_distance;
            sum_w += W_distance + numberOfStr*one_width;
            sum_h+= H_distance+30;
            
        }

    }
    
    sum_h+=H_distance;
    
    return sum_h;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultTableViewCell *cell = [self.searchResultTableView dequeueReusableCellWithIdentifier:SearchResultTableViewCellId forIndexPath:indexPath];
    
    BrandListSort *model = self.searchResultDataSourceArr[indexPath.row];
    cell.zimuLab.text = model.zimu;

    [cell setCellWithArr:model.list];
    
    cell.searchResultTableViewCellBlock = ^(NSInteger tag) {
        self.searchResultBackView.hidden = YES;
        GlassShopViewController *VC = [[GlassShopViewController alloc] initWithNibName:@"GlassShopViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
    };
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - CollectionViewDelegate && CollectionViewDataSource
// 设置CollectionView的组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.homeGrownDataSourceArr.count>0 && self.enterDataSourceArr.count>0) {
        return 2;
    }else if(self.homeGrownDataSourceArr.count>0 && self.enterDataSourceArr.count<=0){
        return 1;
    }else if(self.homeGrownDataSourceArr.count<=0 && self.enterDataSourceArr.count>1){
        return 1;
    }
    return 0;
}



//设置CollectionView每组所包含的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    if (self.homeGrownDataSourceArr.count>0 && self.enterDataSourceArr.count>0) {
        if (section == 0) {
            return self.enterDataSourceArr.count;
            
        }else if (section == 1){
            return self.homeGrownDataSourceArr.count;
        }
    }else if(self.homeGrownDataSourceArr.count>0 && self.enterDataSourceArr.count<=0){
        return self.homeGrownDataSourceArr.count;
    }else if(self.homeGrownDataSourceArr.count<=0 && self.enterDataSourceArr.count>1){
        return self.enterDataSourceArr.count;
    }
    
    return 0;
}
//设置CollectionCell的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    GlassBrandNameCollectionViewCell *item = [self.collectionView dequeueReusableCellWithReuseIdentifier:GlassBrandNameCellID forIndexPath:indexPath];
    
    if (self.homeGrownDataSourceArr.count>0 && self.enterDataSourceArr.count>0) {
        if (indexPath.section == 1) {
            BrandListModel *model = self.homeGrownDataSourceArr[indexPath.row];
            [item buildingWithModel:model];
        }else if (indexPath.section == 0){
            BrandListModel *model = self.enterDataSourceArr[indexPath.row];
            [item buildingWithModel:model];
        }
    }else if(self.homeGrownDataSourceArr.count>0 && self.enterDataSourceArr.count<=0){
        BrandListModel *model = self.homeGrownDataSourceArr[indexPath.row];
        [item buildingWithModel:model];
    }else if(self.homeGrownDataSourceArr.count<=0 && self.enterDataSourceArr.count>1){
        BrandListModel *model = self.enterDataSourceArr[indexPath.row];
        [item buildingWithModel:model];
    }
    
    return item;
}

//定义每个UICollectionViewItem 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((ScreenWidth - 70)/5, 160);
}



//定义每个UICollectionViewItem 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
        return UIEdgeInsetsMake(0, 10, 0, 10);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    GlassFromeSectionHeadView *header = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GlassFromeSectionHeadViewID forIndexPath:indexPath];
    
    if (self.homeGrownDataSourceArr.count>0 && self.enterDataSourceArr.count>0) {
        if (indexPath.section ==1) {
            header.nameLab.text = @"国产";
        }else{
            header.nameLab.text = @"进口";
        }
    }else if(self.homeGrownDataSourceArr.count>0 && self.enterDataSourceArr.count<=0){
        header.nameLab.text = @"国产";
    }else if(self.homeGrownDataSourceArr.count<=0 && self.enterDataSourceArr.count>1){
        header.nameLab.text = @"进口";
    }
    
    return header;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, 80);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@" 点击第 %ld 个",(long)indexPath.row);
//    GlassShopViewController *glassVC = [[GlassShopViewController alloc] initWithNibName:@"GlassShopViewController" bundle:nil];
//
//    [self.navigationController pushViewController:glassVC animated:NO];
//
    
    NSLog(@" 点击第 %ld 个",(long)indexPath.row);
    GlassShopViewController *glassVC = [[GlassShopViewController alloc] initWithNibName:@"GlassShopViewController" bundle:nil];
    
    if (self.homeGrownDataSourceArr.count>0 && self.enterDataSourceArr.count>0) {
        if (indexPath.section == 1) {
            BrandListModel *model = self.homeGrownDataSourceArr[indexPath.row];
            glassVC.brand_id = model.brand_id;
        }else if (indexPath.section == 0){
            BrandListModel *model = self.enterDataSourceArr[indexPath.row];
            glassVC.brand_id = model.brand_id;
        }
        [self.navigationController pushViewController:glassVC animated:NO];
    }else if(self.homeGrownDataSourceArr.count>0 && self.enterDataSourceArr.count<=0){
        BrandListModel *model = self.homeGrownDataSourceArr[indexPath.row];
        glassVC.brand_id = model.brand_id;
        [self.navigationController pushViewController:glassVC animated:NO];
    }else if(self.homeGrownDataSourceArr.count<=0 && self.enterDataSourceArr.count>1){
        BrandListModel *model = self.enterDataSourceArr[indexPath.row];
        glassVC.brand_id = model.brand_id;
        [self.navigationController pushViewController:glassVC animated:NO];
    }
    
}


#pragma mark - 数据请求
//首页列表
-(void)requestBrandList{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (self.keyWord.length>0) {
        [para setObject:self.keyWord forKey:@"keyword"];
    }
    
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    NSString *token = [defualts objectForKey:@"token"];
    
    [self.homeGrownDataSourceArr removeAllObjects];
    [self.enterDataSourceArr removeAllObjects];
    [[HRRequestManager manager] POST_PATH:Post_BrandList WithToken:token para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"网络请求成功");
            for (NSDictionary *dic in responseObject[@"data"][@"guochan"]) {
                BrandListModel *model = [[BrandListModel alloc] initWithDictionary:dic];
                [self.homeGrownDataSourceArr addObject:model];
            }
            
            for (NSDictionary *dic in responseObject[@"data"][@"jinkou"]) {
                BrandListModel *model1 = [[BrandListModel alloc] initWithDictionary:dic];
                [self.enterDataSourceArr addObject:model1];
            }
            
            if (self.homeGrownDataSourceArr.count<=0 && self.enterDataSourceArr.count<=0) {
                [MBProgressHUD showInfoMessage:@"搜索结果为空"];
            }
            
            
            
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    /*
    [[HRRequestManager manager] POST_PATH:Post_BrandList para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"网络请求成功");
            for (NSDictionary *dic in responseObject[@"data"][@"guochan"]) {
                BrandListModel *model = [[BrandListModel alloc] initWithDictionary:dic];
                [self.homeGrownDataSourceArr addObject:model];
            }
            
            for (NSDictionary *dic in responseObject[@"data"][@"jinkou"]) {
                BrandListModel *model1 = [[BrandListModel alloc] initWithDictionary:dic];
                [self.enterDataSourceArr addObject:model1];
            }
            
            if (self.homeGrownDataSourceArr.count<=0 && self.enterDataSourceArr.count<=0) {
                [MBProgressHUD showInfoMessage:@"搜索结果为空"];
            }
            
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
     */
    
}

//首页搜索结果
-(void)requestBrandListSort{
    
    [self.searchResultDataSourceArr removeAllObjects];
    [[HRRequestManager manager] POST_PATH:Post_BrandListSort para:nil success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成");
            for (NSDictionary *dic in responseObject[@"data"]) {
                BrandListSort *model = [[BrandListSort alloc]  initWithDictionary:dic];
                [self.searchResultDataSourceArr addObject:model];
            }
            
            [self.searchResultTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 懒加载
-(ShowLogoutView *)showLogoutView{
    if (!_showLogoutView) {
        _showLogoutView = [[ShowLogoutView alloc] init];
    }
    
    return _showLogoutView;
}

//-(CLLocationManager *)loactionManager{
//    if (!_loactionManager) {
//        _loactionManager = [[CLLocationManager alloc] init];
//        _loactionManager.delegate = self;
//        //区域监听,监听的是用户,所以应该让用户授权获取当前位置
//        if ([_loactionManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//            [_loactionManager requestAlwaysAuthorization];
//        }
//
//    }
//
//    return _loactionManager;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
