//
//  AMGViewController.m
//  AMGDisplayMessage
//
//  Created by Moral on 05/03/14.
//  Copyright (c) 2014 Moral. All rights reserved.
//

#import "AMGViewController.h"

CGFloat const kWidthButton = 80.0f;
CGFloat const kHeightButton = 80.0f;

static NSString *const kText = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit...";

@interface AMGViewController (){
    
    UIButton *_successButton;
    UIButton *_adviceButton;
    UIButton *_infoButton;
    UIButton *_errorButton;
}
@end



@implementation AMGViewController


- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)loadView{
    
    [super loadView];
    
    //  background
    UIImage *image = [UIImage imageNamed:@"background.png"];
    UIImageView *background = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:background];
    
    //  Success Button
    CGRect frameSuccess = CGRectMake(CGRectGetWidth(self.view.frame)*0.25 - kWidthButton*0.5, CGRectGetHeight(self.view.frame)*0.5 - kHeightButton*0.5, kWidthButton, kHeightButton);
    _successButton = [UIButton roundButton:frameSuccess withType:AMGDisplayMessageTypeSuccess withColor:[UIColor newGreenColor]];
    [_successButton addTarget:self action:@selector(displaySuccessMessage) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_successButton];

    //  Info Button
    CGRect frameInfo = CGRectMake(CGRectGetWidth(self.view.frame)*0.75 - kWidthButton*0.5, CGRectGetHeight(self.view.frame)*0.5 - kHeightButton*0.5, kWidthButton, kHeightButton);
    _infoButton = [UIButton roundButton:frameInfo withType:AMGDisplayMessageTypeInformation withColor:[UIColor newBlueColor]];
    [_infoButton addTarget:self action:@selector(displayInfoMessage) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_infoButton];

    
    //  Advice Button
    CGRect frameAdvice = CGRectMake(CGRectGetWidth(self.view.frame)*0.25 - kWidthButton*0.5, CGRectGetHeight(self.view.frame)*0.75 - kHeightButton*0.5, kWidthButton, kHeightButton);
    _adviceButton = [UIButton roundButton:frameAdvice withType:AMGDisplayMessageTypeAdvice withColor:[UIColor newYellowColor]];
    [_adviceButton addTarget:self action:@selector(displayAdviceMessage) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_adviceButton];
    
    //  Error Button
    CGRect frameError = CGRectMake(CGRectGetWidth(self.view.frame)*0.75 - kWidthButton*0.5, CGRectGetHeight(self.view.frame)*0.75 - kHeightButton*0.5, kWidthButton, kHeightButton);
    _errorButton = [UIButton roundButton:frameError withType:AMGDisplayMessageTypeError withColor:[UIColor newRedColor]];
    [_errorButton addTarget:self action:@selector(displayErrorMessage) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_errorButton];
}

#pragma mark - Demo with Buttons

-(void) displaySuccessMessage{
    
    [self.view addSubview:[[AMGDisplayMessage sharedInstance] showMessageWithTitle:@"Success!" withDescription:kText  andTypeMessage:AMGDisplayMessageTypeSuccess]];
}

-(void) displayInfoMessage{

    [self.view addSubview:[[AMGDisplayMessage sharedInstance] showMessageWithTitle:@"Info!" withDescription:kText andTypeMessage:AMGDisplayMessageTypeInformation]];
}

-(void) displayAdviceMessage{
    
    [self.view addSubview:[[AMGDisplayMessage sharedInstance] showMessageWithTitle:@"Advice!" withDescription:kText andTypeMessage:AMGDisplayMessageTypeAdvice]];
}

-(void) displayErrorMessage{
    
    [self.view addSubview:[[AMGDisplayMessage sharedInstance] showMessageWithTitle:@"Error!" withDescription:kText andTypeMessage:AMGDisplayMessageTypeError]];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end



#pragma mark - Category roundButton
@implementation UIButton (roundButton)

+ (UIButton *)roundButton:(CGRect)frame withType:(AMGDisplayMessageType)type withColor:(UIColor *)color{

    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = color;
    button.layer.cornerRadius = 40.0;
    UIImage *image = [[UIImage alloc]init];
    
    switch (type) {
        case AMGDisplayMessageTypeSuccess:
            image = [UIImage imageNamed:@"success"];
            break;
        case AMGDisplayMessageTypeAdvice:
            image = [UIImage imageNamed:@"advice"];
            break;
        case AMGDisplayMessageTypeError:
            image = [UIImage imageNamed:@"error"];
            break;
        case AMGDisplayMessageTypeInformation:
            image = [UIImage imageNamed:@"info"];
            break;
        default:
            break;
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(CGRectGetWidth(frame)*0.5 - image.size.width/2, CGRectGetHeight(frame)*0.5 - image.size.height/2, image.size.width, image.size.height);
    [button addSubview:imageView];
    
    return button;
}

@end


@implementation UIColor (newColors)

+ (UIColor *)newBlueColor{
    return [UIColor colorWithRed:74.0/255 green:144.0/255 blue:226.0/255 alpha:0.8];
}

+ (UIColor *)newRedColor{
    return [UIColor colorWithRed:230.0/255 green:36.0/255 blue:55.0/255 alpha:0.8];
}

+ (UIColor *)newYellowColor{
    return [UIColor colorWithRed:253.0/255 green:212.0/255 blue:99.0/255 alpha:0.8];
}

+ (UIColor *)newGreenColor{
    return [UIColor colorWithRed:126.0/255 green:212.0/255 blue:34.0/255 alpha:0.8];
}

@end
