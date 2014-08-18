//
//  Utility.m
//  test_plus
//
//  Created by handpay on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryUtil.h"
#import <math.h>
#import <objc/runtime.h>
//static CGFloat screenWidth = 0;

@implementation CategoryDummy

@end

@implementation UIView (Extended)

- (void) removeAllSubviews
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

@end

@implementation UIImage (ClacSize)

-(CGSize)realSize{
    return CGSizeMake(self.size.width / 2, self.size.height / 2);
}

// 重新设置图片大小
- (UIImage *) reSize: (CGSize) size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

// 根据颜色生成图片
+ (UIImage *) imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIImage *img = [[UIImage alloc] init];
    UIImage* tempImg = [img maskImage:color size:size];
    //[img release];
    return tempImg;
}

-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
	
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CFRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}
- (UIImage *)maskImage:(UIColor *)maskColor size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextSetFillColorWithColor(context, maskColor.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return smallImage;
}

@end

@implementation MainThreadData

- (id)initData:(id)tar func:(SEL)function obj1:(NSObject*)obj1 obj2:(NSObject*)obj2 wait:(BOOL)isWait{
    self = [super init];
    if (self) {
        func = function;
        arg1 = obj1;
        arg2 = obj2;
        wait = isWait;
        target = tar;
    }
    return self;
}

-(void)doFunc{
    if ([target respondsToSelector:func]) {
        [target performSelector:func withObject:arg1 withObject:arg2];
    }
}

@end

@implementation NSString (NilOrEmpty)

+(BOOL)isNilOrEmpty:(NSString*)str{
    return (!str || [str length] == 0);
}

@end


@implementation NSObject (PerformSelectorOnMainThreadTwoObj)

- (void) doPerformSelecotrOnMainThread:(MainThreadData*)data{
    [data doFunc];
}


- (void) performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg1 withObject:(id)arg2 waitUntilDone:(BOOL)wait{

    MainThreadData* data = [[MainThreadData alloc] initData:self func:aSelector obj1:arg1 obj2:arg2 wait:wait];
    [self performSelectorOnMainThread:@selector(doPerformSelecotrOnMainThread:) withObject:data waitUntilDone:YES];
    //[data release];
    
}

@end

@implementation UITextField (ValueChanged)

@end


static char kTableViewCellHPEditingStyleKey;
@implementation UITableViewCell (CustomEditStyle)
@dynamic hpEditingStyle;
- (void) setHpEditingStyle:(UITableViewCellHPEditingStyle)hpEditingStyle
{
    objc_setAssociatedObject(self, &kTableViewCellHPEditingStyleKey, [NSNumber numberWithInt:hpEditingStyle], OBJC_ASSOCIATION_ASSIGN);
}

- (UITableViewCellHPEditingStyle) hpEditingStyle
{
    return [((NSNumber *)objc_getAssociatedObject(self, &kTableViewCellHPEditingStyleKey)) intValue];
}

@end
