/*================================
||    @param name   URL          ||
||    @param author muyingbo     ||
||    @param date   2016-04-06   ||
=================================*/

#ifndef LMURLConstant_h
#define LMURLConstant_h
#import <Foundation/Foundation.h>


#pragma mark - ||=================== 协议 ===================||

#if DEBUG
#define URLProtocol @"http://"
#else
#define URLProtocol @"http://"
#endif

#pragma mark - ||=================== 地址 ===================||

//#if DEBUG
//#define URLHost @"price.jingkoo.net"
//#else
//#define URLHost @"price.jingkoo.net"
//#endif

#if DEBUG
#define URLHost @"price.jingku.cn"
#else
#define URLHost @"price.jingku.cn"
#endif


#pragma mark - ||=================== 端口 ===================||

#if DEBUG
#define URLPort @""
#else
#define URLPort @""
#endif


#pragma mark - ||=================== 路径 ====================||

#pragma mark - URLPath

// 举例
// 1.1.1
static NSString * const JAVA_USER_LOGIN = @"/Login/sendCode.aspx";

static NSString * const PHP_USER_LOGIN = @"/Login/sendCode.aspx";

//1.首页列表
#define Post_BrandList  @"/public/index/Index/BrandList"

//2.首页搜索结果
#define Post_BrandListSort  @"/public/index/Index/BrandListSort"

//3.获取顶部横向滑动
#define  Post_SeriesList  @"/public/index/Index/SeriesList"

//4.品牌下显示的系列
#define Post_CateList  @"/public/index/Index/CateList"

//5.获取商品信息
//#define Post_GoodsInfo  @"/public/index/Goods/info"
#define Post_GoodsInfo  @"/public/index/Goods/infoios"


//1、应用登录公司接口
#define Post_LoginCompany  @"/public/index/login/company"

//2、应用公司登录接口
#define Post_LoginIndex  @"/public/index/login/index"

//3、图片验证码
#define Post_loginCaptcha  @"/public/index/login/captcha"

//4、图片验证码
#define Post_loginSendsms  @"/public/index/login/sendsms"

//5、获取token//发送图片验证码
#define Post_LoginSessionToken  @"/public/index/Login/_sessiontoken"

//6、注册第一步
#define Post_LoginRegister  @"/public/index/login/register"

//7、注册第二步
#define Post_LoginRegisterTypeCompany  @"/public/index/login/register/type/company"

//6.更改个人信息
#define Post_EditPersonInfo  @"/open/infocenter/client?method=editinfo"
//#define Post_EditPersonInfo @"/open/Infocenter/client?method=log_test"

//7.修改密码
#define Post_ModifyPassword @"/open/infocenter/client?method=editpassword"


//商品信息
#define Post_Goodsinfos @"/public/index/Goods/infos"




#endif /* LMURL_h */
