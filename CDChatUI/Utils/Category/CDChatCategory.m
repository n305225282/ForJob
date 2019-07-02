//
//  CDChatCategory.m
//  CDChat
//
//  Created by 吴文海 on 2019/3/7.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "CDChatCategory.h"
#import "CDMessageModel.h"

@implementation UIDevice(CDChatCategory)

+ (BOOL)cd_isIPhone {
    
	return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

+ (BOOL)cd_isIPhoneX {
    
#ifdef __IPHONE_11_0
	return CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size);
#else
	return NO;
#endif
}

@end



@implementation UIImage(CKPhotoBrowserCategory)

+ (nullable instancetype)cd_imageWithName:(NSString *)imageName {
    
	NSString *bundleImageName = [NSString stringWithFormat:@"image/%@",imageName];
	UIImage *image = [UIImage imageNamed:bundleImageName inBundle:[NSBundle cd_photoViewerResourceBundle] compatibleWithTraitCollection:nil];
    return image;
}

+ (UIImage *)cd_imageWithColor:(UIColor *)color {
    
	CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end


@implementation NSBundle(CKPhotoBrowserCategory)

+ (nullable instancetype)cd_photoViewerResourceBundle {
    
	NSString *resourceBundlePath = [[NSBundle bundleForClass:[CDMessageModel class]] pathForResource:@"CDChat" ofType:@"bundle"];
	return [self bundleWithPath:resourceBundlePath];
}

@end


@implementation NSString(CDChatCategory)

- (CGSize)cd_sizeWithFont:(UIFont *)font {
    
	CGSize result = [self sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
	result.height = ceilf(result.height);
	result.width = ceilf(result.width);
	return result;
}

- (CGSize)cd_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    
	CGSize result = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil].size;
	result.height = ceilf(result.height);
	result.width = ceilf(result.width);
	return result;
}

@end



@implementation UIResponder(CDChatCategory)

- (nullable __kindof UIResponder *)cd_findNextResonderInClass:(nonnull Class)responderClass {
    
	UIResponder *next = self;
	do {
		next = [next nextResponder];
		if ([next isKindOfClass:responderClass]) {
			break;
		}
		// next 不为空 且 不是达到最底层的 appdelegate
	} while (next!=nil && ![next conformsToProtocol:@protocol(UIApplicationDelegate)]);
	
	return next;
}

@end
