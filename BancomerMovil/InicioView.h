//
//  InicioView.h
//  MPOS
//
//  Created by Ricardo Zertuche on 7/8/16.
//  Copyright © 2016 Ricardo Zertuche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InicioView : UIView

@property (nonatomic) UITextField *amount_tf;
@property (nonatomic) UITextField *order_tf;
@property (nonatomic) UITextField *concept_tf;
@property (nonatomic) UITextField *mail_tf;
@property (nonatomic) UIView *alpa_view;
@property (nonatomic) UISwitch *order_switch;
@property (nonatomic) UISwitch *concepto_switch;
@property (nonatomic) UILabel *name_label;
@property (nonatomic) UILabel     *payment_label;
@property (nonatomic) BOOL        payment_editing;
@property (nonatomic) float       payment_tf_height;
@property (nonatomic) UIToolbar *toolbar;
@property (nonatomic) UIView *menu;
@property (nonatomic) BOOL side_menu_open;

@property (nonatomic) UIButton *menu_bar;
@property (nonatomic) UIButton *logo_bar;
@property (nonatomic) UIButton *info_bar;
@property (nonatomic) UIButton *cont_button;
@property (nonatomic) UIButton *cerrar;
@property (nonatomic) UIButton *historial_label;
@property (nonatomic) UIButton *perfil_label;
@property (nonatomic) UIButton *soporte_label;
@property (nonatomic) UIButton *cerrar_label;
@property (nonatomic) UIButton *flap_link;

- (id)initWithFrame:(CGRect)theFrame;

@end
