//
//  LoginView.h
//  MPOS
//
//  Created by Ricardo Zertuche on 7/8/16.
//  Copyright © 2016 Ricardo Zertuche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (nonatomic) UIView *loginView;
@property (nonatomic) UITextField *usuario_tf;
@property (nonatomic) UITextField *password_tf;

@property (nonatomic) UIImageView *login_logo;
@property (nonatomic) UILabel     *login_label1;
@property (nonatomic) UILabel     *login_label2;
@property (nonatomic) UIView      *login_line;
@property (nonatomic) BOOL        login_editing;

@property (nonatomic) UIButton *login_button;


- (id)initWithFrame:(CGRect)theFrame;

@end
