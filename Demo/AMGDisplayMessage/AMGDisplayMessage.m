//
// 
//  AMGDisplayMessage
//
//  Created by Moral on 05/03/14.
//  Copyright (c) 2014 Moral. All rights reserved.
//

#import "AMGDisplayMessage.h"

CGFloat const kSizeMessage = 50.0f;

#pragma mark - AMGDisplayMessage
@interface AMGDisplayMessage (){
    CGRect screenBound;
}

@property (nonatomic, strong) AMGView *view;

@end

@implementation AMGDisplayMessage

#pragma mark - Share Instance
+ (instancetype)sharedInstance{
    
    static id shared;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

#pragma mark - Create Message View
- (UIView *)showMessageWithTitle:(NSString *)title withDescription:(NSString *)description andTypeMessage:(AMGDisplayMessageType)typeMessage{
    
    screenBound = [[UIScreen mainScreen] bounds];
    CGRect rectMessageView;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        
        rectMessageView = CGRectMake(0, -kSizeMessage, CGRectGetHeight(screenBound), kSizeMessage);
    }else{
        rectMessageView = CGRectMake(0, -kSizeMessage, CGRectGetWidth(screenBound), kSizeMessage);
    }
    
    AMGView *view= [[AMGView alloc] initWithFrame:rectMessageView withTitle:title withDescription:description andTypeMessage:typeMessage andOrientation:orientation];
    [view messageAnimation];

    return view;
}

@end


#pragma mark - AMGView
@interface AMGView (){
    
    BOOL isDoubleTapped;
    NSTimer *timer;
    SEL expandMessageView;

    UILabel *labelTitle;
    UILabel *labelDescription;
    
    CGRect screenBound;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) UIImage *imageMessage;
@property (nonatomic) AMGDisplayMessageType typeMessage;
@property (nonatomic) UIInterfaceOrientation orientation;

@end

@implementation AMGView

#pragma mark - alloc/init
- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withDescription:(NSString *)description andTypeMessage:(AMGDisplayMessageType)typeMessage andOrientation:(UIInterfaceOrientation)orientarion{
    
    if (self = [super initWithFrame:frame]) {

        _title = title;
        _description = description;
        _typeMessage = typeMessage;
        _orientation = orientarion;
        
        screenBound = [[UIScreen mainScreen] bounds];

        expandMessageView = @selector(expandMessageView:);
        
        [self addDoubleTapGesture];
        [self createLabelWithTitle];
        [self backgroundMessageView];
        [self createImage];

    }
    return self;
}




#pragma mark - Setup
- (void)createLabelWithTitle{

    labelTitle = [[UILabel alloc]init];
    labelTitle.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), kSizeMessage);
    labelTitle.text = _title;
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    labelTitle.textColor = [UIColor whiteColor];
    
    [self addSubview:labelTitle];
}

- (void)createLabelWithDescription{
    
    labelDescription = [[UILabel alloc]init];
    labelDescription.frame = CGRectMake(0,  CGRectGetHeight(self.frame) * 0.1, CGRectGetWidth(self.frame)*0.9, CGRectGetHeight(screenBound)*0.5 - kSizeMessage);
    labelDescription.text = _description;
    labelDescription.numberOfLines = 0;
    labelDescription.textAlignment = NSTextAlignmentCenter;
    labelDescription.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:26];
    labelDescription.textColor = [UIColor whiteColor];
    
    [self addSubview:labelDescription];
}

- (void)createImage{
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:_imageMessage];
    imageView.frame = CGRectMake(CGRectGetWidth(self.frame) * 0.1, 6, _imageMessage.size.width, _imageMessage.size.height);
    [self addSubview:imageView];
}

- (void)backgroundMessageView{
    
    switch (_typeMessage) {
        case AMGDisplayMessageTypeSuccess:
            self.backgroundColor = [UIColor colorWithRed:126.0/255 green:212.0/255 blue:34.0/255 alpha:0.8];
            self.imageMessage = [UIImage imageNamed:@"success"];
            break;
        case AMGDisplayMessageTypeAdvice:
            self.backgroundColor = [UIColor colorWithRed:250.0/255 green:193.0/255 blue:34.0/255 alpha:0.8];
            self.imageMessage = [UIImage imageNamed:@"advice"];
            break;
        case AMGDisplayMessageTypeError:
            self.backgroundColor = [UIColor colorWithRed:230.0/255 green:36.0/255 blue:55.0/255 alpha:0.8];
            self.imageMessage = [UIImage imageNamed:@"error"];
            break;
        case AMGDisplayMessageTypeInformation:
            self.backgroundColor = [UIColor colorWithRed:74.0/255 green:144.0/255 blue:226.0/255 alpha:0.8];
            self.imageMessage = [UIImage imageNamed:@"info"];
            break;
        default:
            break;
    }
}


#pragma mark - Animation
-(void)messageAnimation{
    
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:4.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
        if (_orientation == UIInterfaceOrientationLandscapeLeft || _orientation == UIInterfaceOrientationLandscapeRight) {
            
            self.frame = CGRectMake(0, 0, CGRectGetHeight(screenBound), kSizeMessage);
        }else{
            self.frame = CGRectMake(0, 0, CGRectGetWidth(screenBound), kSizeMessage);
        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            
            timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkAlert) userInfo:nil repeats:NO];
        }
    }];
}

//  Delete animation
-(void)checkAlert{

    labelDescription.text = @"";

    [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:2.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
        
        if (_orientation == UIInterfaceOrientationLandscapeLeft || _orientation == UIInterfaceOrientationLandscapeRight) {
            
            self.frame = CGRectMake(0, -kSizeMessage, CGRectGetHeight(screenBound), kSizeMessage);
        }else{
            self.frame = CGRectMake(0, -kSizeMessage, CGRectGetWidth(screenBound), kSizeMessage);
        }

    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}


#pragma mark - UIGesture
- (void) addDoubleTapGesture {

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:expandMessageView];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];

}


- (void) expandMessageView:(UITapGestureRecognizer *)doubleTap{
    
    isDoubleTapped = YES;
    [timer invalidate];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

    if (self.frame.size.height == screenBounds.size.height*0.5) {
        [self checkAlert];
        
    }else{
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:2.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, screenBounds.size.height*0.5);
        } completion:^(BOOL finished) {
            [self createLabelWithDescription];
        }];
    }
}


@end
