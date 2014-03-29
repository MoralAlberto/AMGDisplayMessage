//
//  
//  AMGDisplayMessage
//
//  Created by Moral on 15/03/14.
//  Copyright (c) 2014 Moral. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(int, AMGDisplayMessageType){
    AMGDisplayMessageTypeSuccess,
    AMGDisplayMessageTypeInformation,
    AMGDisplayMessageTypeAdvice,
    AMGDisplayMessageTypeError
};


@interface AMGDisplayMessage : NSObject

+ (instancetype)sharedInstance;
- (UIView *)showMessageWithTitle:(NSString *)title withDescription:(NSString *)description andTypeMessage:(AMGDisplayMessageType)typeMessage;

@end


@interface AMGView : UIView

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withDescription:(NSString *)description andTypeMessage:(AMGDisplayMessageType)typeMessage andOrientation:(UIInterfaceOrientation)orientation;
- (void)messageAnimation;

@end
