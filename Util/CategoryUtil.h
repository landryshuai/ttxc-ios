//
//  UIImageCalcSize.h
//  test_plus
//
//  Created by handpay on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//冗余类，否则category在静态库中使用会出错
@interface CategoryDummy : NSObject {
    
}
@end

@interface MainThreadData : NSObject{
    SEL func;
    NSObject* arg1;
    NSObject* arg2;
    BOOL wait;
    id target;
}

-(void)doFunc;
- (id)initData:(id)tar func:(SEL)function obj1:(NSObject*)obj1 obj2:(NSObject*)obj2 wait:(BOOL)isWait;
@end

@interface UIView (Extended)

- (void) removeAllSubviews;

@end

@interface UIImage (ClacSize)

-(CGSize)realSize;  //根据 iphone 手机返回实际的大小

// 重新设置图片大小
- (UIImage *) reSize: (CGSize) size;

// 根据颜色生成图片
+ (UIImage *) imageWithColor:(UIColor *)color size:(CGSize)size;

//从大图按rect截取小图
-(UIImage*)getSubImage:(CGRect)rect;
@end

@interface NSString (NilOrEmpty)

+(BOOL)isNilOrEmpty:(NSString*)str;

@end

@interface NSObject (ReleaseByCheck)

-(void)myRelease;

@end

/*
 支持多个参数
 */
@interface NSObject (PerformSelectorOnMainThreadTwoObj)

- (void) performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg1 withObject:(id)arg2 waitUntilDone:(BOOL)wait;

@end

@interface UITextField (ValueChanged)


@end

@protocol MyUITextFieldDelegate <UITextFieldDelegate>

-(void)autoValueChange:(UITextField*)textField;

@end



@interface UIButton (CustomerButton)
typedef enum {
    /*EBtnStyleBig = 1,  
    EBtnStyleSmall,  
    EBtnStylePopup,
    EBtnStyleCheckBox,
    EBtnStyleRadioBox,
    EBtnStyleDeleted,
    EBtnStyleSmallGray,
    EBtnStyleBigGray,*/
    EBtnStyleRadioBox,
}EBtnStyle;
-(void)setHandpayStyle: (EBtnStyle)btnStyle withImgWidth:(NSInteger) imgW;  //设置按钮图片样式
-(void)setRadioButton:(NSString*)normal highLight:(NSString *)highLight;
@end


typedef NS_ENUM(NSInteger, UITableViewCellHPEditingStyle) {
    UITableViewCellEditingStyleHPDelete,
};

@interface UITableViewCell (CustomEditStyle)

@property (nonatomic, assign) UITableViewCellHPEditingStyle hpEditingStyle;

@end