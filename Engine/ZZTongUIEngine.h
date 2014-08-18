//
//  ZZTongUIEngine.h
//  V-POS
//
//  Created by handpay on 12-10-24.
//  Copyright (c) 2012年 handpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlertData.h"
#import "ZZTongAlertWaitingView.h"

/*
#define SCR_WELCOME              @"HPWelcomeViewController"             // 欢迎界面
#define SCR_LOGIN                @"HPLoginViewController"               // 登录界面
#define SCR_REGISTER             @"HPRegisterViewController"            // 注册界面
#define SCR_REGISTER_SUCCESS     @"HPRegisterSuccessViewController"     // 注册成功界面

#define SCR_FORGET_PWD           @"HPForgetPwdViewController"           // 忘记密码
#define SCR_BASE_INFO_MANAGER    @"HPAccountInfoViewController"         // 基本信息管理
#define SCR_MODIFY_PWD           @"HPModifyPwdViewController"           // 修改密码
#define SCR_MODIFY_MOBILE        @"HPModifyMobileViewController"        // 修改手机号
#define SCR_VERIFY_CURRENT_MOBILE  @"HPVerifyCurrentMobileViewController" // 验证当前手机号
#define SCR_CARDS_MANAGER        @"HPCardsManagerViewController"        // 收款卡管理
#define SCR_MODIFY_CARD          @"HPModifyCardViewController"          // 修改收款卡
#define SCR_ACCOUNT_LIMIT        @"HPAccountLimitViewController"        // 收款限额
#define SCR_ACCOUNT_INDEX        @"HPAccountIndexViewController"        // 账户首页
#define SCR_QUALITY_INDEX        @"HPQualityIndexViewController"        // 资质首页
#define SCR_QUALITY_PHOTO        @"HPQualityPhotoViewController"        // 提交照片资料
#define SCR_UPLOAD_SUCCESS       @"HPUploadSuccessViewController"       // 提交资料成功
#define SCR_REVIEW_STATE        @"HPReviewStateViewController"          // 资质状态说明

#define SCR_TRANSACTION_SUCCESS  @"HPTransactionSuccessViewController"   //交易成功页面

#define SCR_SIGN_TRANSACTION     @"HPSignTransactionViewController"      //签购单

#define SCR_TRANSACTION_FAIL     @"HPTransactionFailViewController"    //交易失败页面
#define SCR_ADD_USER_SIGN        @"HPAddUserSignViewController"       //用户签名页面

#define SCR_SWIPER               @"HPSwiperViewController"              //刷卡页面
#define SCR_COLLECT_MONEY        @"HPCollectMoneyViewController"        //收款首页
#define SCR_SEND_SIGN            @"HPSendSignViewController"            //发送签购单
#define SCR_HELP                 @"HPHelpViewController"                // 帮助中心
#define SCR_CONFIRM_AMOUNT       @"HPConfirmAmountViewController"       //确认金额


#define SCR_FUNCTION             @"HPFunctionViewController"            //功能首页
#define SCR_BALANCE_RESULT       @"HPBalanceQueryViewController"        //余额结果页面
#define SCR_FAST_TRANSFER        @"HPFastTransferViewController"        //快速转账
#define SCR_CARD_OR_RECORD       @"HPCardORRecordViewController"        //卡包＋交易流水
#define SCR_INPUT_PWD            @"HPInputSwiperPwdViewController"      //刷卡器密码界面
#define SCR_CM_TRANS_RECORD      @"HPCMTransRecordViewController"*/
#define HPUIENG [ZZTongUIEngine getInstance]
@interface ZZTongUIEngine : NSObject <ZZTongAlertWaitingViewDelegate>
{
@private
    UIAlertView* mAlertView; // 只保留一个alertView
    AlertData* mAlertData;   // 对话框的数据
}
@property(nonatomic, retain)UINavigationController* navigationController;
@property(nonatomic, retain) UIAlertView* mAlertView;
@property(nonatomic, retain) AlertData* mAlertData;
- (void)hideNavigationBar:(BOOL)hidden;
- (void)showNetWaiting;
- (void)showWaiting:(NSString*)msg;
- (void)showAlert:(NSString *)msg;
- (void)removeAlert;
- (void)doRemoveAlert;
- (void)showAlertWithData:(AlertData*)alertData;
- (void)showAlert:(NSString*)title msg:(NSString*)msg;
- (UINavigationController*)getCurrentNavigation;
- (void)doShowAlert:(AlertData*)alertData;
+ (ZZTongUIEngine*)getInstance;
+ (void)releaseInstance;
@end
