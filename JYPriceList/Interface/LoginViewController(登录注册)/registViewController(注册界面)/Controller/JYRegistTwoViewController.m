
//
//  JYRegistTwoViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/20.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "JYRegistTwoViewController.h"
#import "JYRegistTwoTableViewCell.h"

#import "JYBaseNavigationController.h"
//#import "GlassShopViewController.h"
#import "GlassHomeViewController.h"

static NSString *const JYRegistTwoTableViewCellID = @"JYRegistTwoTableViewCellIdentifier";
@interface JYRegistTwoViewController ()<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIImage *img;

@end

@implementation JYRegistTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpUI{
    
    //隐藏纵向滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"JYRegistTwoTableViewCell" bundle:nil] forCellReuseIdentifier:JYRegistTwoTableViewCellID];
    
}

#pragma mark - 私有方法
-(void)transferPhoneImage{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    actionSheet.popoverPresentationController.sourceView = self.tableView;
    actionSheet.popoverPresentationController.sourceRect = self.view.frame;
    
    // 判断系统是否支持相机
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self; //设置代理
    //允许裁剪
    imagePickerController.allowsEditing = YES;
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了按钮1，进入按钮1的事件");
        //相册
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //拍照
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    //把action添加到actionSheet里
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    //相当于之前的[actionSheet show];
    [self.navigationController presentViewController:actionSheet animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    self.img = image;
//    _iconImage.image = image;  //给UIimageView赋值已经选择的相片
    //上传图片到服务器--在这里进行图片上传的网络请求，这里不再介绍
    //    [self requestpostIconImage:image];
    [self.tableView reloadData];
    
}


//取消选择图片（拍照）
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 点击事件





#pragma mark - UITableViewDataSource && UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 755;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYRegistTwoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:JYRegistTwoTableViewCellID forIndexPath:indexPath];
//    [cell.imgBtn setImage:self.img forState:UIControlStateNormal];
    [cell.imgBtn setBackgroundImage:self.img forState:UIControlStateNormal];
    
    weakSelf(weakSelf);
    cell.registTwoTableViewCellBlock = ^(NSInteger tag, NSMutableDictionary *pDic) {
        switch (tag) {
            case 4:{
                [weakSelf transferPhoneImage];
            }
                break;
            case 6:{
                NSLog(@"注册");
//                GlassHomeViewController *glassHomeVC = [[GlassHomeViewController alloc] initWithNibName:@"GlassHomeViewController" bundle:nil];
//                JYBaseNavigationController *nav = [[JYBaseNavigationController alloc] initWithRootViewController:glassHomeVC];
//                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            }
                break;
                
            default:
                break;
        }
    };
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - 数据请求
-(void)request{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [para setObject:@"" forKey:@"user_id"];
    [para setObject:@"" forKey:@"province"];
    [para setObject:@"" forKey:@"city"];
    [para setObject:@"" forKey:@"district"];
    [para setObject:@"" forKey:@"address"];
    [para setObject:@"" forKey:@"parent_id"];
    [para setObject:@"" forKey:@"zz_number"];
    [para setObject:@"" forKey:@"zhizhao"];
    [para setObject:@"" forKey:@"email"];
    [para setObject:@"" forKey:@"company"];
    
    [[HRRequestManager manager] POST_PATH:Post_LoginRegisterTypeCompany para:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
        
    }];
    
}


//上传头像
-(void)requestpostIconImage:(UIImage *)image {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 60;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", @"text/json", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:@"http://cnopc.jingkoo.net%@", Post_EditPersonInfo];
    //    NSDictionary *dic = @{@"id":@"0"};
    //根据当前系统时间生成图片名称
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    
    [manager POST:urlStr parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",dateStr];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        float size = imageData.length/1024.0/1024.0;
        if (size>=1) {
            imageData = UIImageJPEGRepresentation(image, 0.3);
        }else{
            imageData = UIImageJPEGRepresentation(image, 0.5);
        }
        [formData appendPartWithFileData:imageData name:@"avatar" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功");
        //解析二进制
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"------%@",returnDic);
        if ([[returnDic objectForKey:@"ac"] isEqualToString:@"success"]) {
            NSDictionary *photoDic = [NSDictionary dictionaryWithDictionary:[returnDic objectForKey:@"photos"]];
            NSLog(@"这里将你得到的图片地址拿到, 做接下来上传图片的步骤");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败");
    }];
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
