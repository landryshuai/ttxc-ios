//
//  VPOSClientEngine.m
//  V-POS
//
//  Created by handpay on 12-10-26.
//  Copyright (c) 2012年 handpay. All rights reserved.
//

#import "ZZTongClientEngine.h"

#define DEF_VERSION     @"version"


#define ZZTDebug   1

#if defined (ZZTDebug) && (ZZTDebug == 1)

    static NSString * APPSERVERURL = @"http://www.tiantianxinche.com"; 

    //银联
    //static NSString * CUPSERVERURL = @"http://218.80.192.213:1725/Gateway/MobilePayment";   // 银联开发环境
    static NSString * CUPSERVERURL = @"http://202.101.25.178:8080/Gateway/MobilePayment"; // 银联仿真环境

#else
    static NSString * APPSERVERURL = @"http://mps.handpay.cn/hpaySft/"; //生产环境
    //银联
    static NSString * CUPSERVERURL = @"http://202.96.255.146:8080/Gateway/MobilePayment"; // 银联生产环境

#endif



static NSString * UPDATE_URL = @"https://itunes.apple.com/cn/app/zhang-zhang-tong/id656091202?mt=8";
static ZZTongClientEngine *clientEngine = nil;

@interface ZZTongClientEngine (){
//    int countDown;
}

@property(nonatomic, retain)UIButton* getVerifyButton;
@property (nonatomic, retain) NSInvocation * callback;

@end

@implementation ZZTongClientEngine
@synthesize uiEngine;
@synthesize user;

+ (ZZTongClientEngine *) sharedInstance{
	if (!clientEngine) {
		clientEngine = [[ZZTongClientEngine alloc] init];
	}
	return clientEngine;
}

+ (void)releaseInstance{
    
    if (clientEngine) {
        //[clientEngine release];
        clientEngine = nil;
    }
}

- (void)dealloc{
    _callback = nil;
    uiEngine = nil;
    user = nil;
    //[super dealloc];
}

- (BOOL)isLogin
{
    if(user) {
        return true;
    } else {
        return false;
    }
}

- (void)clearAccountInfo{
    //self.accountInfo = [[[AccountInfoData alloc] init] autorelease];
}

- (id)init{
    self = [super init];
    if (self) {        
        ZZTongUIEngine* tempUIEngine = [[ZZTongUIEngine alloc] init];
        self.uiEngine = tempUIEngine;
       // [tempUIEngine release];
        
        [self clearAccountInfo];
        
#if ZZT_FOR_TEST
//        AccountInfoData* testAccountData = [[[AccountInfoData alloc] init] autorelease];
//        testAccountData.account = @"qabc3";
//        testAccountData.mobile = @"13812345678";
//        testAccountData.name = @"王欢欢";
//        testAccountData.certNo = @"32092219841021393X";
//        testAccountData.bankName = @"工商银行";
//        testAccountData.branchBankName = @"上海浦东第二支行";
//        testAccountData.cardNo = @"1234567890123456";
//        testAccountData.shopName = @"上海张张通奶茶店";
//        testAccountData.dayAmount = @"1234567800";
//        testAccountData.failDescpriction = @"身份证信息与身份证照片信息不符；\r\n经营场所照片不清晰；";
//        testAccountData.date = @"2014-03-11";
        
//        testAccountData.frontCCPicStatus = PhotoStatusFailed;
//        testAccountData.frontCCPicUrl = @"http://www.baidu.com/img/bdlogo.gif"; //
//        
//        testAccountData.backCCPicStatus = PhotoStatusSuccess;
//        testAccountData.backCCPicUrl = @"http://www.baidu.com/img/bdlogo.gif";
//        
//        testAccountData.holdPicStatus = PhotoStatusSuccess;
//        testAccountData.holdPicUrl  = @"http://www.baidu.com/img/bdlogo.gif";
//        
//        testAccountData.companyPicStatus = PhotoStatusSuccess;
//        testAccountData.companyPicUrl  = @"http://www.baidu.com/img/bdlogo.gif";
//        
//        testAccountData.licensePicStatus = PhotoStatusFailed;
//        testAccountData.licensePicUrl = @"http://www.baidu.com/img/bdlogo.gif";
        
        
//        self.accountInfo = testAccountData;
#else
        [self clearAccountInfo];
#endif
    }
    return self;
}

-(NSString*)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}


- (void)doExit{
    //[HPUIENG DoExit];
}

/*
- (void)parseSendCode{
    dispatch_async(dispatch_get_main_queue(), ^(){
        self.getVerifyButton.enabled = NO;
        
        [HPUIENG showAlert:@"短信验证码发送成功"];
        
//        countDown = 60;
        [self.getVerifyButton setTitle:@"60秒后重发" forState:UIControlStateDisabled];
        [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(resetButtonTitle:) userInfo:self.getVerifyButton repeats:YES] fire];
        self.getVerifyButton = nil;
    });
}*/


- (void)doCancel{
    
}


- (void)resetButtonTitle:(NSTimer*)timer{
    UIButton *button = nil;
    if ([[timer userInfo] isKindOfClass:[UIButton class]]) {
        button = [timer userInfo];
    }
    
    if (!button) {
        return;
    }

    NSString* buttonTitle = [button titleForState:UIControlStateDisabled];
    int countDown = [[buttonTitle substringToIndex:buttonTitle.length - 4] intValue];
    countDown--;
    if (countDown <= 0) {
        button.enabled = YES;
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [timer invalidate];
        return;
    }
    
    [button setTitle:[NSString stringWithFormat:@"%d秒后重发", countDown] forState:UIControlStateDisabled];
    if (button.enabled) {
        button.enabled = NO;
    }
}
/*
- (void)doSendVerifyCode:(NSDictionary*)params withButton:(UIButton*)button{
    self.getVerifyButton = button;
    
#if ZZT_FOR_TEST
    [self responseCallBackSuccess:NET_ACTION_SEND_PHONE_CODE withData:nil];
#else
    [self.netEngine sendRequest:NET_ACTION_SEND_PHONE_CODE withParams:params withDelegate:self];
    [self.uiEngine showNetWaiting];
#endif
}*/

- (void)initApp{
    
    //[self doVerifyVersion];
}


- (NSString*)getUrlByName:(NSString*)name{
    return APPSERVERURL;
}

- (void)doAsyncFunction:(id)target func:(SEL)func arg:(NSObject*)obj{
    NSThread* thread = [[NSThread alloc] initWithTarget:target selector:func object:obj];
    [thread start];
    //[thread release];
}

@end
