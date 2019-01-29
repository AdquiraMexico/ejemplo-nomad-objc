//
//  HistorialViewController.m
//  
//
//  Created by Ricardo Zertuche on 9/8/15.
//
//

#import "HistorialViewController.h"

@implementation HistorialViewController
@synthesize objects, token, env;

- (void)viewWillDisappear:(BOOL)animated{
    self.bbvaAPI = nil;
}

- (void)viewDidLoad{
    
    self.bbvaAPI = [[BBVANomad alloc]init];
    self.bbvaAPI.delegate = self;
    [self.bbvaAPI initBBVANomad];
    self.bbvaAPI.env = env;

    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [toolbar setBarTintColor:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1]];
    [toolbar setTranslucent:NO];
    
    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIImage *menu_bar_img = [UIImage imageNamed:@"ATRAS"];
    UIButton *menu_bar = [UIButton buttonWithType:UIButtonTypeCustom];
    menu_bar.bounds = CGRectMake( 0, 0, menu_bar_img.size.width, menu_bar_img.size.height );
    [menu_bar setImage:menu_bar_img forState:UIControlStateNormal];
    [menu_bar setImage:menu_bar_img forState:UIControlStateSelected];
    [menu_bar setImage:menu_bar_img forState:UIControlStateHighlighted];
    [menu_bar addTarget:self action:@selector(dismissHistorial) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *menu_bar_button = [[UIBarButtonItem alloc] initWithCustomView:menu_bar];
    
    UIImage *logo_bar_img = [UIImage imageNamed:@"BAR"];
    UIButton *logo_bar = [UIButton buttonWithType:UIButtonTypeCustom];
    logo_bar.bounds = CGRectMake( 0, 0, logo_bar_img.size.width, logo_bar_img.size.height );
    [logo_bar setImage:logo_bar_img forState:UIControlStateNormal];
    [logo_bar setImage:logo_bar_img forState:UIControlStateSelected];
    [logo_bar setImage:logo_bar_img forState:UIControlStateHighlighted];
    UIBarButtonItem *logo_bar_button = [[UIBarButtonItem alloc] initWithCustomView:logo_bar];
    
    UIImage *info_bar_img = [UIImage imageNamed:@"SEARCH"];
    info_bar = [UIButton buttonWithType:UIButtonTypeCustom];
    info_bar.bounds = CGRectMake( 0, 0, info_bar_img.size.width, info_bar_img.size.height );
    [info_bar setImage:info_bar_img forState:UIControlStateNormal];
    [info_bar setImage:info_bar_img forState:UIControlStateSelected];
    [info_bar setImage:info_bar_img forState:UIControlStateHighlighted];
    [info_bar addTarget:self action:@selector(openCloseSearch) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *info_bar_button = [[UIBarButtonItem alloc] initWithCustomView:info_bar];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:menu_bar_button, flexibleSpace, logo_bar_button, flexibleSpace, info_bar_button, nil];
    
    [toolbar setItems:toolbarItems animated:NO];
    [self.view addSubview:toolbar];
    
    search_view = [[UIView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 50)];
    [search_view setBackgroundColor:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1]];
    [self.view addSubview:search_view];
    
    search_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, search_view.frame.size.width, 40)];
    search_label.font = [UIFont fontWithName:@"Roboto-Light" size:16];
    search_label.textAlignment = NSTextAlignmentCenter;
    search_label.textColor = [UIColor whiteColor];
    search_label.text = @"ULTIMAS TRANSACCIONES";
    [search_view addSubview:search_label];
    
    
    search_tf = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, search_view.frame.size.width-40, 40)];
    search_tf.placeholder = @"No. de Aprobación o No. de Orden";
    search_tf.font = [UIFont fontWithName:@"Roboto-Light" size:14];
    search_tf.textAlignment = NSTextAlignmentCenter;
    search_tf.backgroundColor = [UIColor whiteColor];
    search_tf.delegate = self;
    search_tf.alpha = 0;
    [search_view addSubview:search_tf];
    
    button_apr = [[UIButton alloc]initWithFrame:CGRectMake(20, 60, (search_view.frame.size.width/2)-30, 50)];
    [button_apr setTitle:@"No. de Aprobación" forState:UIControlStateNormal];
    button_apr.layer.borderWidth = 1;
    button_apr.layer.borderColor = [[UIColor whiteColor]CGColor];
    button_apr.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:14];
    [button_apr addTarget:self action:@selector(searchAprobacion) forControlEvents:UIControlEventTouchDown];
    [search_view addSubview:button_apr];
    button_apr.alpha = 0;
    
    button_orden = [[UIButton alloc]initWithFrame:CGRectMake((search_view.frame.size.width/2)+10, 60, (search_view.frame.size.width/2)-30, 50)];
    [button_orden setTitle:@"No. de Orden" forState:UIControlStateNormal];
    button_orden.layer.borderWidth = 1;
    button_orden.layer.borderColor = [[UIColor whiteColor]CGColor];
    button_orden.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:14];
    [button_orden addTarget:self action:@selector(searchOrden) forControlEvents:UIControlEventTouchDown];
    [search_view addSubview:button_orden];
    button_orden.alpha = 0;
    
    search_is_open = FALSE;
    
    historial = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height-60)];
    historial.delegate = self;
    historial.dataSource = self;
    historial.allowsSelection = false;
    
    [self.view addSubview:historial];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return objects.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistorialCell * cell;
    
    static NSString * reuseIdentifier = @"programmaticCell";
    cell = [historial dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[HistorialCell alloc] init];
    }
    
    NSDictionary *dict = [objects objectAtIndex:indexPath.row];
    NSString *d_date        = [NSString stringWithFormat:@"%@",[dict objectForKey:@"fecha"]];
    NSString *d_amount      = [NSString stringWithFormat:@"$ %@ %@",[dict objectForKey:@"importe"],[dict objectForKey:@"moneda"]];
    NSString *d_concepto    = [NSString stringWithFormat:@"%@",[dict objectForKey:@"servicio"]];
    NSString *d_orden       = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orden"]];
    NSString *d_apr         = [NSString stringWithFormat:@"%@",[dict objectForKey:@"aprobacion"]];
    NSString *d_banco       = [NSString stringWithFormat:@"%@",[dict objectForKey:@"banco"]];
    NSString *d_tarjeta     = [NSString stringWithFormat:@"%@",[dict objectForKey:@"ultimosDigitos"]];
    NSString *d_tipo        = [NSString stringWithFormat:@"%@",[dict objectForKey:@"tipo"]];
    NSString *d_subStatus   = [NSString stringWithFormat:@"%@",[dict objectForKey:@"subStatus"]];
    if ([d_tipo isEqualToString:@"1"]) d_tipo = @"Pago";
    if ([d_tipo isEqualToString:@"2"]) d_tipo = @"Cancelación";
    if ([d_tipo isEqualToString:@"3"]) d_tipo = @"Devolución";
    if ([d_tipo isEqualToString:@"4"]) d_tipo = @"Contracargo";
    if ([d_tipo isEqualToString:@"5"]) d_tipo = @"Dispersión";
    
    cell.delegate = self;
    if ([d_tipo isEqualToString:@"Pago"]){
        if (![d_subStatus isEqualToString:@"C"]) {
            [cell setDate:d_date setAmount:d_amount setConcepto:d_concepto setOrden:d_orden setAprobacion:d_apr setBanco:d_banco setTarjeta:d_tarjeta andTipo:d_tipo andSwipe:@"1"];
        } else {
            [cell setDate:d_date setAmount:d_amount setConcepto:d_concepto setOrden:d_orden setAprobacion:d_apr setBanco:d_banco setTarjeta:d_tarjeta andTipo:d_tipo andSwipe:@"0"];
        }
    } else {
        [cell setDate:d_date setAmount:d_amount setConcepto:d_concepto setOrden:d_orden setAprobacion:d_apr setBanco:d_banco setTarjeta:d_tarjeta andTipo:d_tipo andSwipe:@"0"];
    }
    
    MGSwipeButton *bt = [MGSwipeButton buttonWithTitle:@"CANCELAR \nTRANSACCIÓN" backgroundColor:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1]];
    bt.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:12];
    [bt setPadding:40];
    cell.rightButtons = @[bt];
    
    return cell;
}
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion{
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        NSIndexPath * path = [historial indexPathForCell:cell];
        NSDictionary *dict = [objects objectAtIndex:path.row];
        NSString *trans_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"transaccionId"]];
        row_to_delete = path;
        [self cancelWithTrans:trans_id];
        return NO; //Don't autohide to improve delete expansion animation
    }
    return YES;
}

- (void)didConnectDevice:(BOOL)yes{
    //nothing here
}
- (void)lowBaterryMessage:(NSString *)message{
    [self createPopUpWithSuccess:FALSE andMessage:message];
}

- (void)cancelWithTrans:(NSString*)trans{
    [self createPopUpLoaderWithMessage:@"Cancelando..."];
    [self.bbvaAPI cancelTransactionWithOrder:trans andToken:token];
}
- (void)didCancel:(BOOL)success andMessage:(NSString *)message{
    if (success) {
        [objects removeObjectAtIndex:row_to_delete.row];
        [self createPopUpWithSuccess:success andMessage:@"Transacción cancelada EXITOSAMENTE"];
        [historial deleteRowsAtIndexPaths:@[row_to_delete] withRowAnimation:UITableViewRowAnimationLeft];
    } else {
        [self createPopUpWithSuccess:success andMessage:@"No se pudo cancelar. \nFavor de contactar a soporte."];
    }
    [self closePopUpLoader];
}

- (void)searchAprobacion{
    if ([search_tf.text length]>0) {
        [search_tf resignFirstResponder];
        [self createPopUpLoaderWithMessage:@"Buscando..."];
        [self.bbvaAPI searchTransactionWithAuthCode:search_tf.text andToken:self.token andEnv:env];
    } else {
        [search_tf resignFirstResponder];
        [self createPopUpWithSuccess:FALSE andMessage:@"Campo vacío, ingresa No. de Aprobación o No. de Orden"];
    }
}
- (void)searchOrden{
    if ([search_tf.text length]>0) {
        [search_tf resignFirstResponder];
        [self createPopUpLoaderWithMessage:@"Buscando..."];
        [self.bbvaAPI searchTransactionWithOrder:search_tf.text andToken:self.token andEnv:env];
    } else {
        [search_tf resignFirstResponder];
        [self createPopUpWithSuccess:FALSE andMessage:@"Campo vacío, ingresa No. de Aprobación o No. de Orden"];
    }
}

- (void)searchResult:(NSArray *)result withSucces:(BOOL)success{
    //NSLog(@"%@",result);
    [self closePopUpLoader];
    id elid = result;
    if ([result count]>0) {
        objects = [[NSMutableArray alloc]init];
        for (int i = 0; i<[result count]; i++) {
            NSDictionary *dict2 = (NSDictionary*)[elid objectAtIndex:i];
            [objects addObject:dict2];
        }
        [historial reloadData];
    } else {
        [self createPopUpWithSuccess:FALSE andMessage:@"No existen transacciones con ese criterio."];
    }
}
- (void)openCloseSearch{
    if (search_is_open) {
        [UIView animateWithDuration:1.0 animations:^{
            search_view.frame = CGRectMake(0, 60, self.view.frame.size.width, 50);
            historial.frame = CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height-110);
            search_is_open = FALSE;
            search_tf.alpha     = 0;
            button_apr.alpha    = 0;
            button_orden.alpha  = 0;
            search_label.alpha  = 1;
            [info_bar setImage:[UIImage imageNamed:@"SEARCH"] forState:UIControlStateNormal];
        }];
    } else {
        [UIView animateWithDuration:1.0 animations:^{
            search_view.frame = CGRectMake(0, 60, self.view.frame.size.width, 120);
            historial
            .frame = CGRectMake(0, 180, self.view.frame.size.width, self.view.frame.size.height-180);
            search_is_open = TRUE;
            search_tf.alpha     = 1;
            button_apr.alpha    = 1;
            button_orden.alpha  = 1;
            search_label.alpha  = 0;
            [info_bar setImage:[UIImage imageNamed:@"DELETE"] forState:UIControlStateNormal];
        }];
    }
    [search_tf resignFirstResponder];
}
- (void)dismissHistorial{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SecondViewControllerDismissed"
                                                        object:nil
                                                      userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - PopOver Notifications
- (void)createPopUpWithSuccess:(BOOL)succes andMessage:(NSString*)message{
    popup = [[Popup alloc] initWithView];
    //[popup setDelegate:self];
    [popup setBackgroundColor:[UIColor whiteColor]];
    [popup setBackgroundBlurType:PopupBackGroundBlurTypeDark];
    [popup setIncomingTransition:PopupIncomingTransitionTypeBounceFromCenter];
    [popup setTapBackgroundToDismiss:NO];
    [popup setSwipeToDismiss:YES];
    
    if (succes){
        if (message.length>0)
            [popup setupView:[self createSuccesViewWithMessage:message]];
        else
            [popup setupView:[self createSuccesView]];
    }else{
        if (message.length>0)
            [popup setupView:[self createErrorViewWithMessage:message]];
        else
            [popup setupView:[self createErrorView]];
    }
    [popup showPopup];
}
- (UIView*)createLoaderView{
    UIView *successView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popup_loader.bounds.size.width, popup_loader.frame.size.height)];
    [successView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *alert_image = [[UIImageView alloc]initWithFrame:CGRectMake(80, 30, 100, 100)];
    alert_image.image = [UIImage imageNamed:@"LOADER1"];
    [successView addSubview:alert_image];
    
    UIImageView *alert_image2 = [[UIImageView alloc]initWithFrame:CGRectMake(80, 30, 100, 100)];
    alert_image2.image = [UIImage imageNamed:@"LOADER2"];
    [successView addSubview:alert_image2];
    
    UIImageView *alert_image3 = [[UIImageView alloc]initWithFrame:CGRectMake(80, 30, 100, 100)];
    alert_image3.image = [UIImage imageNamed:@"LOADER3"];
    [successView addSubview:alert_image3];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 1.5;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.repeatCount = 100;
    [alert_image2.layer addAnimation:animation forKey:animation.keyPath];
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation2.duration = 1.5;
    animation2.fromValue = [NSNumber numberWithFloat:0];
    animation2.toValue = [NSNumber numberWithFloat:-2 * M_PI];
    animation2.repeatCount = 100;
    [alert_image3.layer addAnimation:animation2 forKey:animation2.keyPath];
    
    UILabel *alert_label = [[UILabel alloc]initWithFrame:CGRectMake(0, alert_image.frame.origin.y+alert_image.frame.size.height+10, 260, 30)];
    alert_label.numberOfLines = 2;
    alert_label.text = @"Por favor espere un momento estamos \n realizando la transacción, gracias...";
    alert_label.textColor = [UIColor grayColor];
    alert_label.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    alert_label.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]
                                       initWithAttributedString: alert_label.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1]
                 range:NSMakeRange(28, 35)];
    [alert_label setAttributedText: text];
    
    [successView addSubview:alert_label];
    
    return successView;
}
- (UIView*)createLoaderViewWithMessage:(NSString*)message{
    UIView *successView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popup_loader.bounds.size.width, popup_loader.frame.size.height)];
    [successView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *alert_image = [[UIImageView alloc]initWithFrame:CGRectMake(80, 30, 100, 100)];
    alert_image.image = [UIImage imageNamed:@"LOADER1"];
    [successView addSubview:alert_image];
    
    UIImageView *alert_image2 = [[UIImageView alloc]initWithFrame:CGRectMake(80, 30, 100, 100)];
    alert_image2.image = [UIImage imageNamed:@"LOADER2"];
    [successView addSubview:alert_image2];
    
    UIImageView *alert_image3 = [[UIImageView alloc]initWithFrame:CGRectMake(80, 30, 100, 100)];
    alert_image3.image = [UIImage imageNamed:@"LOADER3"];
    [successView addSubview:alert_image3];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 1.5;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.repeatCount = 100;
    [alert_image2.layer addAnimation:animation forKey:animation.keyPath];
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation2.duration = 1.5;
    animation2.fromValue = [NSNumber numberWithFloat:0];
    animation2.toValue = [NSNumber numberWithFloat:-2 * M_PI];
    animation2.repeatCount = 100;
    [alert_image3.layer addAnimation:animation2 forKey:animation2.keyPath];
    
    UILabel *alert_label = [[UILabel alloc]initWithFrame:CGRectMake(0, alert_image.frame.origin.y+alert_image.frame.size.height+10, 260, 30)];
    alert_label.numberOfLines = 2;
    alert_label.text = message;
    alert_label.textColor = [UIColor grayColor];
    alert_label.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    alert_label.textAlignment = NSTextAlignmentCenter;
    
    
    [successView addSubview:alert_label];
    
    return successView;
}
- (UIView*)createSuccesView{
    UIView *successView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popup.bounds.size.width, popup.frame.size.height)];
    [successView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *alert_image = [[UIImageView alloc]initWithFrame:CGRectMake(90, 30, 80, 80)];
    alert_image.image = [UIImage imageNamed:@"POP-EXITOSO.png"];
    [successView addSubview:alert_image];
    
    UILabel *alert_label = [[UILabel alloc]initWithFrame:CGRectMake(0, alert_image.frame.origin.y+alert_image.frame.size.height+10, 260, 30)];
    alert_label.text = @"La transacción se realizo ¡CORRECTAMENTE!";
    alert_label.textColor = [UIColor colorWithRed:0.54 green:0.77 blue:0.25 alpha:1];
    alert_label.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
    alert_label.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]
                                       initWithAttributedString: alert_label.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor grayColor]
                 range:NSMakeRange(0, 26)];
    [text addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"Roboto-Regular" size:12]
                 range:NSMakeRange(0, 26)];
    [alert_label setAttributedText: text];
    
    [successView addSubview:alert_label];
    
    UIButton *alert_close  = [[UIButton alloc]initWithFrame:CGRectMake(0, alert_label.frame.origin.y+alert_label.frame.size.height+10, 260, 20)];
    [alert_close setBackgroundColor:[UIColor whiteColor]];
    [alert_close setTitle:@"Aceptar >" forState:UIControlStateNormal];
    [alert_close setTitleColor:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1] forState:UIControlStateNormal];
    alert_close.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:12];
    [alert_close addTarget:self action:@selector(closePopUp) forControlEvents:UIControlEventTouchDown];
    [successView addSubview:alert_close];
    
    return successView;
}
- (UIView*)createErrorView{
    UIView *successView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popup.bounds.size.width, popup.frame.size.height)];
    [successView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *alert_image = [[UIImageView alloc]initWithFrame:CGRectMake(90, 30, 80, 80)];
    alert_image.image = [UIImage imageNamed:@"POP-ERROR.png"];
    [successView addSubview:alert_image];
    
    UILabel *alert_label = [[UILabel alloc]initWithFrame:CGRectMake(0, alert_image.frame.origin.y+alert_image.frame.size.height+10, 260, 30)];
    alert_label.text = @"A ocurrido un error favor de verificar su tarjeta";
    alert_label.textColor = [UIColor grayColor];
    alert_label.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    alert_label.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]
                                       initWithAttributedString: alert_label.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor colorWithRed:0.96 green:0.2 blue:0.25 alpha:1]
                 range:NSMakeRange(0, 19)];
    [text addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"Roboto-Bold" size:12]
                 range:NSMakeRange(0, 19)];
    [alert_label setAttributedText: text];
    
    [successView addSubview:alert_label];
    
    UIButton *alert_close  = [[UIButton alloc]initWithFrame:CGRectMake(0, alert_label.frame.origin.y+alert_label.frame.size.height+10, 260, 20)];
    [alert_close setBackgroundColor:[UIColor whiteColor]];
    [alert_close setTitle:@"Aceptar >" forState:UIControlStateNormal];
    [alert_close setTitleColor:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1] forState:UIControlStateNormal];
    alert_close.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:12];
    [alert_close addTarget:self action:@selector(closePopUp) forControlEvents:UIControlEventTouchDown];
    [successView addSubview:alert_close];
    
    return successView;
}
- (UIView*)createSuccesViewWithMessage:(NSString*)message{
    UIView *successView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popup.bounds.size.width, popup.frame.size.height)];
    [successView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *alert_image = [[UIImageView alloc]initWithFrame:CGRectMake(90, 30, 80, 80)];
    alert_image.image = [UIImage imageNamed:@"POP-EXITOSO.png"];
    [successView addSubview:alert_image];
    
    UILabel *alert_label = [[UILabel alloc]initWithFrame:CGRectMake(0, alert_image.frame.origin.y+alert_image.frame.size.height+10, 260, 30)];
    alert_label.text = message;
    alert_label.textColor = [UIColor grayColor];
    alert_label.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
    alert_label.textAlignment = NSTextAlignmentCenter;
    
    [successView addSubview:alert_label];
    
    UIButton *alert_close  = [[UIButton alloc]initWithFrame:CGRectMake(0, alert_label.frame.origin.y+alert_label.frame.size.height+10, 260, 20)];
    [alert_close setBackgroundColor:[UIColor whiteColor]];
    [alert_close setTitle:@"Aceptar >" forState:UIControlStateNormal];
    [alert_close setTitleColor:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1] forState:UIControlStateNormal];
    alert_close.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:12];
    [alert_close addTarget:self action:@selector(closePopUp) forControlEvents:UIControlEventTouchDown];
    [successView addSubview:alert_close];
    
    return successView;
}
- (UIView*)createErrorViewWithMessage:(NSString*)message{
    UIView *successView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popup.bounds.size.width, popup.frame.size.height)];
    [successView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *alert_image = [[UIImageView alloc]initWithFrame:CGRectMake(90, 30, 80, 80)];
    alert_image.image = [UIImage imageNamed:@"POP-ERROR.png"];
    [successView addSubview:alert_image];
    
    UILabel *alert_label = [[UILabel alloc]initWithFrame:CGRectMake(0, alert_image.frame.origin.y+alert_image.frame.size.height+10, 260, 30)];
    alert_label.text = message;
    alert_label.textColor = [UIColor grayColor];
    alert_label.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    alert_label.textAlignment = NSTextAlignmentCenter;
    alert_label.numberOfLines = 0;
    
    [successView addSubview:alert_label];
    
    UIButton *alert_close  = [[UIButton alloc]initWithFrame:CGRectMake(0, alert_label.frame.origin.y+alert_label.frame.size.height+10, 260, 20)];
    [alert_close setBackgroundColor:[UIColor whiteColor]];
    [alert_close setTitle:@"Aceptar >" forState:UIControlStateNormal];
    [alert_close setTitleColor:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1] forState:UIControlStateNormal];
    alert_close.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:12];
    [alert_close addTarget:self action:@selector(closePopUp) forControlEvents:UIControlEventTouchDown];
    [successView addSubview:alert_close];
    
    return successView;
}
- (void)createPopUpLoaderWithMessage:(NSString*)message{
    
    popup_loader = [[Popup alloc] initWithView];
    //[popup setDelegate:self];
    [popup_loader setBackgroundColor:[UIColor whiteColor]];
    [popup_loader setBackgroundBlurType:PopupBackGroundBlurTypeDark];
    [popup_loader setIncomingTransition:PopupIncomingTransitionTypeBounceFromCenter];
    [popup_loader setTapBackgroundToDismiss:NO];
    
    if (![message length]>0) [popup_loader setupView:[self createLoaderView]];
    else [popup_loader setupView:[self createLoaderViewWithMessage:message]];
    
    [popup_loader showPopup];
}
- (void)closePopUp{
    [popup dismissPopup:PopupButtonCancel];
}
- (void)closePopUpLoader{
    [popup_loader dismissPopup:PopupButtonCancel];
}

@end
