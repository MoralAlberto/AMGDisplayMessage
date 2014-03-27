//
//  AMGViewController.h
//  AMGDisplayMessage
//
//  Created by Moral on 05/03/14.
//  Copyright (c) 2014 Moral. All rights reserved.
//

@import UIKit;
#import "AMGDisplayMessage.h"


@interface AMGViewController : UIViewController
@end

#pragma mark - Category roundButton
@interface UIButton (roundButton)

+ (UIButton *)roundButton:(CGRect)frame withType:(AMGDisplayMessageType)type withColor:(UIColor *)color;

@end


@interface UIColor (newColors)

+ (UIColor *) newBlueColor;
+ (UIColor *) newRedColor;
+ (UIColor *) newGreenColor;
+ (UIColor *) newYellowColor;

@end

