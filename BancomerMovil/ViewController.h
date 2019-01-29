//
//  ViewController.h
//  BancomerMovil
//
//  Created by DC.
//  Copyright (c) 2010 DC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <mPosAPI/BBVANomad.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate,BBVADelegate, UIGestureRecognizerDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSArray *btdevices;
    UITableView *listView;
    
    NSString *concepto;
    NSString *monto;
    NSString *mail;
    NSString *order;
    NSString *servicio;
    NSString *global_token;
    NSString *msi;
    NSString *env;
    
    NSString *showConcepto;
    NSString *showOrder;
    
    CLLocation *payment_location;
    
    int contadorSwipesDev;
    
    NSString *user;
    NSString *password;
    
    NSMutableArray *all_transitions;
    
    //General UI
    UIToolbar *toolbar2;
    UILabel *info_label;
    UILabel *info_header;
    
    //Card UI
    UIView *card_view;
    UIImageView *info_image;
    UILabel *monto_label;
    UIButton *regresar_button;
    UIButton *pagar_button;
    
    //Signature UI
    UIView *signature_view;
    
    BOOL modalDismissed;
    BOOL showingCardView;
    
    //
    UISwitch *puntos_switch;
    UITextField *meses_tf;
    
    NSMutableArray *dots;
    int dot_counter;
    BOOL showing_loader;
    
    BOOL usedPin;
    
}

@property (nonatomic) BBVANomad *bbvaAPI;
@property (nonatomic) CLLocationManager *locationManager;

@end

