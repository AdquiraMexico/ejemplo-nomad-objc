//
//  ViewController.m
//  BancomerMovil
//
//  Created by Ricardo Zertuche on 8/10/14.
//  Copyright (c) 2014 Ricardo Zertuche. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController{
    //Login
    
//__weak IBOutlet UIButton *Boton;
    
    BOOL        isEmvProcess;
    NSArray     *months_array;
    UIButton *walker_button;
    UIButton *nomad_button;
    
    __weak IBOutlet UIButton *Boton;
    NSArray *services;
    NSString *servicesString;
}
@synthesize locationManager;


- (void)viewDidAppear:(BOOL)animated{
 
    
    //INIT the BBVA API
    
    self.bbvaAPI = [[BBVANomad alloc]init];
    [self.bbvaAPI initBBVANomad];
    
    //Delegate the API to Self
    self.bbvaAPI.delegate = self;

    
    //Setup Developement enviroment for this Exaple
    
    env         = @"D";
    self.bbvaAPI.env = @"D";
    servicio    = @"773";
    msi         = @"0";
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    modalDismissed = false;
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //Auto Login for testing
    [self.bbvaAPI loginWithUsername:@"v1" andPassword:@"v1" andEnv:@"D"];
    [[NSUserDefaults standardUserDefaults] setObject:env forKey:@"env"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    msi         = @"0";
    contadorSwipesDev = 0;
    showConcepto = @"0";
    showOrder    = @"0";
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
   
    //ADD Button for search PRESS ONLY ONE TIME
    
    [Boton addTarget:self action:@selector(scanBluetooth) forControlEvents:UIControlEventTouchDown];
    
    [self toDevMode];
}

- (void)loginSucceded:(BOOL)success andToken:(NSString*)token andDictionary:(NSDictionary *)info{
    if (success) {
        
        
        //[self dismissViewFade:loginView];
        global_token = token;
        //Save to NSUserDefaults
        if ([env isEqualToString:@"P"]) {
            [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"user"];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [[NSUserDefaults standardUserDefaults] setObject:global_token forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //[self createPopUpWithSuccess:success andMessage:@"Sesión iniciada"];
        
        NSDictionary *servicesDictionary = [info objectForKey:@"services"];
        
        services = [servicesDictionary allKeys];
        servicesString = @"773";
        for(int x = 0 ; x < [services count] ; x++){
            servicesString = [NSString stringWithFormat:@"%@;%@",servicesString, services[x]];
        }
        
    } else {
        // [self createPopUpWithSuccess:success andMessage:@"Usuario o Contraseña incorrectas"];
    }
}

- (void)didStartOnlineTransaction{
    //[self closePopUpLoader];
    //[self createPopUpLoaderWithMessage:@""];
}
- (void)processText:(NSString*)text{
    info_label.text = text;
}


- (void)didCancel:(BOOL)success andMessage:(NSString*)message{}

- (void)didConnectDevice:(BOOL)yes{
    if (yes){
        info_image.image = [UIImage imageNamed:@"img_procesando"];
        info_label.alpha = 1;
        //        if (showingCardView) {
        //            [self createPopUpLoaderWithMessage:@"Iniciando lector..."];
        //            [self performSelector:@selector(closePopUpLoader) withObject:nil afterDelay:3];
        //        }
    } else {
        info_image.image = [UIImage imageNamed:@"img_procesando"];
        info_label.alpha = 1;
        regresar_button.enabled = true;
        pagar_button.enabled    = true;
    }
}
- (void)didConnectNomad:(BOOL)yes{
    
    if (yes){
        info_image.image = [UIImage imageNamed:@"img_procesando"];
        info_label.alpha = 1;
        //[self createPopUpWithSuccess:TRUE andMessage:@"Nomad conectado"];
    } else {
        info_image.image = [UIImage imageNamed:@"img_procesando"];
        info_label.alpha = 1;
        regresar_button.enabled = true;
        pagar_button.enabled    = true;
        //[self createPopUpWithSuccess:TRUE andMessage:@"Error en la conexión"];
    }
}
- (void)lowBaterryMessage:(NSString *)message{
    //[self createPopUpWithSuccess:FALSE andMessage:message];
}
- (void)connectionResultWithSuccess:(BOOL)success andResult:(NSArray*)result{
    //Back After button found the nomad device

    printf("Conected");
    
    //The process continues as the last API
    
    if (success) {
        btdevices = result;
        printf("Results:");
       // NSLog(@"Results: %@", result);

        for (NSString *string in result) {
            NSLog(@"Results: %@", string);
        }
        //[self.bbvaAPI connectToNomad:result[0]];

        [listView reloadData];
        // [self createPopUpList];
    } else {
        //[self createPopUpWithSuccess:FALSE andMessage:[result objectAtIndex:0]];
    }
}
- (void)usedPin{
    usedPin = true;
}


- (void)toDevMode{
    if (contadorSwipesDev>=3) {
        env         = @"D";
        self.bbvaAPI.env = @"D";
        servicio    = @"773";
        msi         = @"0";
        //[self createPopUpWithSuccess:true andMessage:@"Modo Developer"];
        [[NSUserDefaults standardUserDefaults] setObject:env forKey:@"env"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    contadorSwipesDev = 0;
}




- (void)leerTarjeta{
    if ([self.bbvaAPI devicePluggedBBVA]) {
        
        regresar_button.enabled     = false;
        pagar_button.enabled        = false;
        
        info_label.text = @"Favor de insertar o deslizar la tarjeta";
        
        if (!([order length]>0)) order = @"-";
        if (!([concepto length]>0)) concepto = @"-";
        if (!([mail length]>0)) mail = @"-";
        
        NSString *env_l = [[NSUserDefaults standardUserDefaults]stringForKey:@"env"];
        NSString *token_l = [[NSUserDefaults standardUserDefaults]stringForKey:@"token"];
        
        [self.bbvaAPI sendAmount:monto andConcept:concepto andEmail:mail andToken:token_l andService:servicesString andOrderID:order andPeriod:msi andEnv:env_l andLat:[NSString stringWithFormat:@"%f", payment_location.coordinate.latitude] andLong:[NSString stringWithFormat:@"%f", payment_location.coordinate.longitude]];
        self.bbvaAPI.versionString = @"whitelabel_i_1.0.0";
        //Mostrar instertar o deslizar segun sea el caso
        [self.bbvaAPI checkCard];
    }
    else{
        //  [self createPopUpWithSuccess:false andMessage:@"Conecta el dispositivo"];
    }
    
}

- (void)scanBluetooth{
    printf("ScanBlueTooth");
    [self.bbvaAPI scanNomad];
    // [self createPopUpLoaderWithMessage:@"Buscando dispositivos"];
}
- (void)connectWalker{
    
    
    [self.bbvaAPI disconnectWalker];
}


#pragma mark - Restart
- (void)allViariablesRestart{
    env         = @"P";
    self.bbvaAPI.env         = @"P";
    msi         = @"0";
    global_token= @"";
    order       = @"";
    mail        = @"";
    concepto    = @"";
    monto       = @"";
    [[NSUserDefaults standardUserDefaults] setObject:env forKey:@"env"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)allTextfieldsRestart{
    
}

#pragma mark - Extras
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didDismissSecondViewController{
    modalDismissed = TRUE;
}
- (void)web_perfil{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mpos.flap.com.mx/perfil"]];
}


#pragma mark - TableView Delegates
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numOfSection = 0;
    numOfSection = [btdevices count];
    return numOfSection;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"cellForRowAtIndexPath: %@", indexPath);
    UITableViewCell    *cell;
    CBPeripheral    *peripheral;
    NSInteger        row    = [indexPath row];
    static NSString *cellID = @"DeviceList";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    
    peripheral = (CBPeripheral*)[btdevices objectAtIndex:row];
    
    if (peripheral != nil){
        if ([[peripheral name] length]){
            //Remove "-LE" in peripheralName
            NSString *peripheralName = [peripheral name];
            if ([peripheralName length] >= 3){
                if ([[[peripheralName substringWithRange:NSMakeRange([peripheralName length]-3, 3)] uppercaseString] isEqualToString:@"-LE"]){
                    peripheralName = [peripheralName substringWithRange:NSMakeRange(0, [peripheralName length]-3)];
                }
            }
            [[cell textLabel] setText:peripheralName];
        }else{
            [[cell textLabel] setText:@"Peripheral"];
        }
        //[[cell detailTextLabel] setText: [peripheral isConnected] ? @"Connected" : @"Not connected"];
    }
    return cell;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.bbvaAPI connectToNomad:indexPath];
    
}

@end
