//
//  LoginView.m
//  MPOS
//
//  Created by Ricardo Zertuche on 7/8/16.
//  Copyright © 2016 Ricardo Zertuche. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)theFrame{
    self = [super initWithFrame:theFrame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    _login_logo = [[UIImageView alloc]initWithFrame:CGRectMake(self.center.x-118, 70, 236, 109)];
    [_login_logo setImage:[UIImage imageNamed:@"LOGO.png"]];
    [self addSubview:_login_logo];
    
    UIButton *olv_contrasena_button = [[UIButton alloc]initWithFrame:CGRectMake(10, self.frame.size.height-40, 140,
                                                                                40)];
    [olv_contrasena_button setTitle:@"¿Olvidaste tu contraseña?" forState:UIControlStateNormal];
    [olv_contrasena_button setTitleColor:[UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:157.0/255.0 alpha:1] forState:UIControlStateNormal];
    olv_contrasena_button.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:12];
    [olv_contrasena_button addTarget:self action:@selector(web_forgot) forControlEvents:UIControlEventTouchDown];
    [self addSubview:olv_contrasena_button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 50, 30, 100, 30)];
    label.text = @"v.2.5.5-i";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:157.0/255.0 alpha:1];
    label.font = [UIFont fontWithName:@"Roboto-Light" size:12];
    [self addSubview:label];
    
    UIButton *registrarse_button = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-100, self.frame.size.height-40, 90, 40)];
    [registrarse_button setTitle:@"Registrarse >" forState:UIControlStateNormal];
    [registrarse_button setTitleColor:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1] forState:UIControlStateNormal];
    registrarse_button.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:12];
    [registrarse_button addTarget:self action:@selector(web_register) forControlEvents:UIControlEventTouchDown];
    [self addSubview:registrarse_button];
    
    _login_button  = [[UIButton alloc]initWithFrame:CGRectMake(10, olv_contrasena_button.frame.origin.y-70, self.frame.size.width-20, 60)];
    [[_login_button imageView] setContentMode: UIViewContentModeScaleAspectFit];
    _login_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _login_button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [_login_button setImage:[UIImage imageNamed:@"ENTRAR.png"] forState:UIControlStateNormal];
    
    [self addSubview:_login_button];
    
    _login_label1         = [[UILabel alloc]initWithFrame:CGRectMake(self.center.x-118, _login_logo.frame.origin.y+_login_logo.frame.size.height+15, 236, 20)];
    _login_label1.textAlignment    = NSTextAlignmentCenter;
    _login_label1.text             = @"PAGOS RÁPIDOS Y SEGUROS";
    _login_label1.textColor        = [UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1];
    _login_label1.font             = [UIFont fontWithName:@"Roboto-Bold" size:15];
    [self addSubview:_login_label1];
    
    
    _login_label2             = [[UILabel alloc]initWithFrame:CGRectMake(self.center.x-150, _login_label1.frame.origin.y+_login_label1.frame.size.height+5, 300, 40)];
    _login_label2.textAlignment        = NSTextAlignmentCenter;
    _login_label2.numberOfLines        = 2;
    _login_label2.text                 = @"Recibe pagos con tarjeta de forma segura \n e inmediata.";
    _login_label2.textColor            = [UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:157.0/255.0 alpha:1];
    _login_label2.font                 = [UIFont fontWithName:@"Roboto-Light" size:15];
    [self addSubview:_login_label2];
    
    _usuario_tf                  = [[UITextField alloc]initWithFrame:CGRectMake(self.center.x-125,
                                                                               _login_label2.frame.origin.y+_login_label2.frame.size.height+35,
                                                                               250,
                                                                               30)];
    _usuario_tf.textAlignment    = NSTextAlignmentLeft;
    _usuario_tf.placeholder      = @"Usuario";
    _usuario_tf.textColor        = [UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:157.0/255.0 alpha:1.0];
    _usuario_tf.font             = [UIFont fontWithName:@"Roboto-Regular" size:18];
    [self addSubview:_usuario_tf];
    
    _login_line = [[UIView alloc]initWithFrame:CGRectMake(self.center.x-125, _usuario_tf.frame.origin.y+_usuario_tf.frame.size.height+3, 250, 1)];
    _login_line.backgroundColor        = [UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:157.0/255.0 alpha:0.1];
    [self addSubview:_login_line];
    
    _password_tf                 = [[UITextField alloc]initWithFrame:CGRectMake(self.center.x-125,
                                                                               _login_line.frame.origin.y+_login_line.frame.size.height+5,
                                                                               250,
                                                                               30)];
    _password_tf.textAlignment   = NSTextAlignmentLeft;
    _password_tf.secureTextEntry = TRUE;
    _password_tf.placeholder     = @"Contraseña";
    _password_tf.textColor       = [UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:157.0/255.0 alpha:1.0];
    _password_tf.font            = [UIFont fontWithName:@"Roboto-Regular" size:18];
    [self addSubview:_password_tf];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)web_register{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mpos.flap.com.mx/register"]];
}

- (void)web_forgot{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mpos.flap.com.mx/forgot_password"]];
}

@end
