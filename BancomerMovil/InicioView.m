//
//  InicioView.m
//  MPOS
//
//  Created by Ricardo Zertuche on 7/8/16.
//  Copyright © 2016 Ricardo Zertuche. All rights reserved.
//

#import "InicioView.h"

@implementation InicioView

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

    [self setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1]];
    
    _toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    [_toolbar setBarTintColor:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1]];
    [_toolbar setTranslucent:NO];
    
    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIImage *_menu_bar_img = [UIImage imageNamed:@"MENU"];
    _menu_bar = [UIButton buttonWithType:UIButtonTypeCustom];
    _menu_bar.bounds = CGRectMake( 0, 0, _menu_bar_img.size.width, _menu_bar_img.size.height );
    [_menu_bar setImage:_menu_bar_img forState:UIControlStateNormal];
    [_menu_bar setImage:_menu_bar_img forState:UIControlStateSelected];
    [_menu_bar setImage:_menu_bar_img forState:UIControlStateHighlighted];
    UIBarButtonItem *_menu_bar_button = [[UIBarButtonItem alloc] initWithCustomView:_menu_bar];
    
    UIImage *_logo_bar_img = [UIImage imageNamed:@"BAR"];
    _logo_bar = [UIButton buttonWithType:UIButtonTypeCustom];
    _logo_bar.bounds = CGRectMake( 0, 0, _logo_bar_img.size.width, _logo_bar_img.size.height );
    [_logo_bar setImage:_logo_bar_img forState:UIControlStateNormal];
    [_logo_bar setImage:_logo_bar_img forState:UIControlStateSelected];
    [_logo_bar setImage:_logo_bar_img forState:UIControlStateHighlighted];
    UIBarButtonItem *_logo_bar_button = [[UIBarButtonItem alloc] initWithCustomView:_logo_bar];
    
    UIImage *_info_bar_img = [UIImage imageNamed:@"BT-MAS"];
    _info_bar = [UIButton buttonWithType:UIButtonTypeCustom];
    _info_bar.bounds = CGRectMake( 0, 0, _info_bar_img.size.width, _info_bar_img.size.height );
    [_info_bar setImage:_info_bar_img forState:UIControlStateNormal];
    [_info_bar setImage:_info_bar_img forState:UIControlStateSelected];
    [_info_bar setImage:_info_bar_img forState:UIControlStateHighlighted];
    UIBarButtonItem *_info_bar_button = [[UIBarButtonItem alloc] initWithCustomView:_info_bar];
    
    NSArray *_toolbarItems = [NSArray arrayWithObjects:_menu_bar_button, flexibleSpace, _logo_bar_button, flexibleSpace, _info_bar_button, nil];
    
    [_toolbar setItems:_toolbarItems animated:NO];
    
    [self addSubview:_toolbar];
    
    
    _amount_tf = [[UITextField alloc]initWithFrame:CGRectMake(10, 80, self.frame.size.width-20, 60)];
    _amount_tf.placeholder = @"$ 0.00 MX";
    _amount_tf.textAlignment = NSTextAlignmentCenter;
    _amount_tf.keyboardType = UIKeyboardTypeNumberPad;
    _amount_tf.font = [UIFont fontWithName:@"Roboto-Thin" size:50];
    _amount_tf.adjustsFontSizeToFitWidth = TRUE;
    [self addSubview:_amount_tf];
    
    _payment_label = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, self.frame.size.width-20, 20)];
    _payment_label.textAlignment = NSTextAlignmentCenter;
    _payment_label.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _payment_label.textColor = [UIColor grayColor];
    _payment_label.text = @"Dar \"clic\" para ingresar monto";
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]
                                       initWithAttributedString: _payment_label.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1]
                 range:NSMakeRange(4, 7)];
    [_payment_label setAttributedText: text];
    
    NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc]
                                        initWithAttributedString: _payment_label.attributedText];
    [text2 addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1]
                  range:NSMakeRange(16, 14)];
    [_payment_label setAttributedText: text2];
    
    [self addSubview:_payment_label];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    
    _order_tf = [[UITextField alloc]initWithFrame:CGRectMake(10, 110+_amount_tf.frame.size.height, self.frame.size.width-20, 0)];
    _order_tf.placeholder = @"";
    _order_tf.textAlignment = NSTextAlignmentLeft;
    _order_tf.font = [UIFont fontWithName:@"Roboto-Thin" size:18];
    _order_tf.adjustsFontSizeToFitWidth = TRUE;
    _order_tf.backgroundColor = [UIColor whiteColor];
    _order_tf.layer.borderWidth = 1;
    _order_tf.layer.borderColor =[[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1] CGColor];
    _order_tf.leftView = paddingView;
    _order_tf.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:_order_tf];
    
    _concept_tf = [[UITextField alloc]initWithFrame:CGRectMake(10, _order_tf.frame.origin.y+_order_tf.frame.size.height+10, self.frame.size.width-20, 0)];
    _concept_tf.placeholder = @"";
    _concept_tf.textAlignment = NSTextAlignmentLeft;
    _concept_tf.font = [UIFont fontWithName:@"Roboto-Thin" size:18];
    _concept_tf.adjustsFontSizeToFitWidth = TRUE;
    _concept_tf.backgroundColor = [UIColor whiteColor];
    _concept_tf.layer.borderWidth = 1;
    _concept_tf.layer.borderColor =[[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1] CGColor];
    _concept_tf.leftView = paddingView2;
    _concept_tf.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:_concept_tf];
    
    if (self.frame.size.height < 500) {_payment_tf_height = 40.0;}
    else { _payment_tf_height = 60.0;}
    _mail_tf = [[UITextField alloc]initWithFrame:CGRectMake(10, _concept_tf.frame.origin.y+_concept_tf.frame.size.height+10, self.frame.size.width-20, _payment_tf_height)];
    _mail_tf.placeholder = @"Mail tarjetahabiente (Opcional)";
    _mail_tf.textAlignment = NSTextAlignmentLeft;
    _mail_tf.font = [UIFont fontWithName:@"Roboto-Thin" size:18];
    _mail_tf.adjustsFontSizeToFitWidth = TRUE;
    _mail_tf.backgroundColor = [UIColor whiteColor];
    _mail_tf.layer.borderWidth = 1;
    _mail_tf.layer.borderColor =[[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1] CGColor];
    _mail_tf.leftView = paddingView3;
    _mail_tf.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:_mail_tf];
    
    _cont_button  = [[UIButton alloc]initWithFrame:CGRectMake(10, self.frame.size.height-70, self.frame.size.width-20, 60)];
    [[_cont_button imageView] setContentMode: UIViewContentModeScaleAspectFit];
    _cont_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _cont_button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [_cont_button setImage:[UIImage imageNamed:@"BT-ACEPTAR"] forState:UIControlStateNormal];
    [self addSubview:_cont_button];
    
    _alpa_view = [[UIView alloc]initWithFrame:self.frame];
    _alpa_view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    _alpa_view.alpha = 0;
    [self addSubview:_alpa_view];
    
    _menu                    = [[UIView alloc]initWithFrame:CGRectMake(-250, 0, 250, self.frame.size.height)];
    _menu.backgroundColor    = [UIColor whiteColor];
    [self addSubview:_menu];
    
    _cerrar = [[UIButton alloc]initWithFrame:CGRectMake(210, 10, 30, 30)];
    [_cerrar setImage:[UIImage imageNamed:@"CERRAR-BUSCAR"] forState:UIControlStateNormal];
    _cerrar.titleLabel.font = [UIFont fontWithName:@"Roboto-Thin" size:18];
    [_cerrar setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_menu addSubview:_cerrar];
    
    UIImageView *flap_holder = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, 50, 50)];
    flap_holder.image = [UIImage imageNamed:@"ICO"];
    [_menu addSubview:flap_holder];
    
    _name_label = [[UILabel alloc]initWithFrame:CGRectMake(80, 65, 160, 20)];
    _name_label.font = [UIFont fontWithName:@"Roboto-Thin" size:14];
    _name_label.adjustsFontSizeToFitWidth = TRUE;
    [_menu addSubview:_name_label];
    
    UIImageView *line_div = [[UIImageView alloc]initWithFrame:CGRectMake(20, 120, 210, 1)];
    line_div.image = [UIImage imageNamed:@"LINEA-2"];
    [_menu addSubview:line_div];
    
    UIImageView *historial_icon = [[UIImageView alloc]initWithFrame:CGRectMake(24, 150, 22, 28)];
    historial_icon.image = [UIImage imageNamed:@"HIST"];
    [_menu addSubview:historial_icon];
    
    _historial_label = [[UIButton alloc]initWithFrame:CGRectMake(70, 150, 170, 28)];
    [_historial_label setTitle:@"Historial" forState:UIControlStateNormal];
    [_historial_label setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _historial_label.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:14];
    _historial_label.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    _historial_label.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_menu addSubview:_historial_label];
    
    UIImageView *perfil_icon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 205, 28, 28)];
    perfil_icon.image = [UIImage imageNamed:@"PER"];
    [_menu addSubview:perfil_icon];
    
    _perfil_label = [[UIButton alloc]initWithFrame:CGRectMake(70, 205, 170, 28)];
    [_perfil_label setTitle:@"Perfil" forState:UIControlStateNormal];
    [_perfil_label setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _perfil_label.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:14];
    _perfil_label.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    _perfil_label.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_menu addSubview:_perfil_label];
    
    UIImageView *soporte_icon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 260, 28, 28)];
    soporte_icon.image = [UIImage imageNamed:@"SOPORTE"];
    [_menu addSubview:soporte_icon];
    
    _soporte_label = [[UIButton alloc]initWithFrame:CGRectMake(70, 260, 170, 28)];
    [_soporte_label setTitle:@"Soporte" forState:UIControlStateNormal];
    [_soporte_label setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _soporte_label.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:14];
    _soporte_label.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    _soporte_label.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_menu addSubview:_soporte_label];
    
    UIImageView *_cerrar_icon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 315, 28, 28)];
    _cerrar_icon.image = [UIImage imageNamed:@"CERR"];
    [_menu addSubview:_cerrar_icon];
    
    _cerrar_label = [[UIButton alloc]initWithFrame:CGRectMake(70, 315, 170, 28)];
    [_cerrar_label setTitle:@"Cerrar Sesión" forState:UIControlStateNormal];
    [_cerrar_label setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _cerrar_label.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:14];
    _cerrar_label.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    _cerrar_label.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_menu addSubview:_cerrar_label];
    
    _flap_link = [[UIButton alloc]initWithFrame:CGRectMake(20, _menu.frame.size.height-40, 210, 30)];
    [_flap_link setTitle:@"mpos.flap.com.mx" forState:UIControlStateNormal];
    [_flap_link setTitleColor:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_flap_link.titleLabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:14]];
    [_menu addSubview:_flap_link];
    
    _side_menu_open = FALSE;

}


@end
