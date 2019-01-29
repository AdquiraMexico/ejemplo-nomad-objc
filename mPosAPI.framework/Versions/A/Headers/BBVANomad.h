//
//  BBVAMovilApi.h
//  BancomerMovil
//
//  Created by Ricardo Zertuche on 8/10/14.
//  Copyright (c) 2014 Ricardo Zertuche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBDeviceController.h"
#import "BBDeviceOTAController.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import <sys/utsname.h>
#import <AudioToolbox/AudioServices.h>
#import <QuartzCore/QuartzCore.h>

@protocol BBVADelegate <NSObject>
@optional
- (void)processText: (NSString*)text;
- (void)didFindBinWithPoint:(BOOL)canUsePoints andMonths:(NSArray*)months andEmvProcess:(BOOL)isEMV;
- (void)didFinishPaymentCorrectly: (BOOL)success withTransactin:(NSString*)transaction;
- (void)didGetTicketWithTotal:(NSString *)total withDireccion:(NSString *)direccion withMoneda:(NSString *)moneda withHoraTransaccion:(NSString *)horaTransaccion withTarjeta:(NSString *)tarjeta withReferencia:(NSString *)referencia withTipoPago:(NSString *)tipoPago withAfiliacion:(NSString *)afiliacion withComercio:(NSString *)comercio withTipoOperacion:(NSString *)tipoOperacion withAutorizacion:(NSString *)autorizacion withTitular:(NSString *)titular withEmisor:(NSString *)emisor withFirma:(NSString *)firma withFechaTransaccion:(NSString *)fechaTransaccion;
- (void)usedPin;
- (void)didSendSignature: (BOOL)success;
- (void)loginSucceded: (BOOL)success andToken:(NSString*)token andDictionary:(NSDictionary*)info;
// Returns an Array with Dictionaries of each transaction
- (void)loadedTransactionsReturn:(NSArray*)transactions;
- (void)didCancel: (BOOL)success andMessage:(NSString*)message;
- (void)didConnectDevice: (BOOL)yes;
- (void)didConnectNomad: (BOOL)yes;
- (void)didStartEMV;
- (void)didStartOnlineTransaction;
- (void)lowBaterryMessage:(NSString*)message;
- (void)searchResult:(NSArray*)result withSucces:(BOOL)success;
// Bluetooth
- (void)connectionResultWithSuccess:(BOOL)success andResult:(NSArray*)result;
//ApplicationList
- (void)applicationListResult:(NSArray*)result;
@end

@interface BBVANomad : NSObject <BBDeviceControllerDelegate, BBDeviceOTAControllerDelegate, UIAlertViewDelegate, UITextFieldDelegate>
{
    BOOL isBadSwiped;
    BOOL isWrongPin;
    BOOL isCanceledPin;
    BOOL isCheckCardOnly;
    BOOL isSwipeCardOnly;
    BOOL isAutoSetAmount;
    BOOL isAutoSelectApplication;
    BOOL isAutoFinalConfirm;
    BOOL isAutoSendOnlineProcessResult;
    BOOL isStartEmvWithTerminalTime;
    BOOL isStartEmvWithDisabledDisplayText;
    BOOL isAutoConnectLastBTv4Device;
    BOOL isAutoConnectLastBTDevice;
    NSMutableDictionary *BTDeviceDictionary;
    
    NSMutableDictionary *bluetoothDeviceDict;
    NSMutableDictionary *ticket;
    BOOL usedPin;
    BOOL bypass;
    
    BOOL isCheckingCardPresent;
    
    NSString *ksn;
    NSString *entrack1;
    NSString *entrack2;
    
    NSString *transactionID;
    NSString *authCode;
    NSString *global_tlv;
    NSString *bin;
    
    NSString *device;
    
    UIAlertView *av;
    
    NSString *serverTlvResponse;
    int fallbackCounter;
    BOOL fallback;
    
    BOOL changingToWalker;
    
    NSString *batteryWlaker;
    
    id <BBVADelegate> delegate;
}
@property (retain) id delegate;

@property (nonatomic, assign) id<BBDeviceControllerDelegate> BTControllerDelegate;
@property (nonatomic, assign) id<BBDeviceOTAControllerDelegate> BTOTAControllerDelegate;

@property (nonatomic) NSString *concepto;
@property (nonatomic) NSString *monto;
@property (nonatomic) NSString *mail;
@property (nonatomic) NSString *order;
@property (nonatomic) NSString *servicio;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *msi;
@property (nonatomic) BOOL points;
@property (nonatomic) NSString *env;
@property (nonatomic) NSString *cvv;
@property (nonatomic) NSString *latitude;
@property (nonatomic) NSString *longitud;
@property (nonatomic) NSString *versionString;

-(void)initBBVANomad;
-(void)scanNomad;
-(void)connectWalker;
-(void)disconnectWalker;

-(void)connectToNomad:(NSIndexPath*)indexPath;
-(void)disconnetNomad;
-(BOOL)devicePluggedBBVA;
-(void)checkCardStatus;
-(void)checkCard;
-(void)emvPaymentProcess;
-(void)msrPaymentProcess;
-(void)getTicket;
-(void)selectApplication:(int)application;

-(void)reset;

- (void)loginWithUsername:(NSString *)username andPassword:(NSString*)password andEnv:(NSString*)env;
- (void)loadTransactions;
- (void)cancelTransactionWithOrder:(NSString*)order andToken:(NSString*)token;

- (void)sendAmount:(NSString*)amount andConcept:(NSString*)concept andEmail:(NSString*)email andToken:(NSString*)token andService:(NSString*)service andOrderID:(NSString*)orderID andPeriod:(NSString*)period andEnv:(NSString*)env andLat:(NSString*)lati andLong:(NSString*)longi;

- (void)sendSignatureData:(NSData*)signData;
- (void)searchTransactionWithAuthCode:(NSString*)auth_code andToken:(NSString *)token andEnv:(NSString*)env;
- (void)searchTransactionWithOrder:(NSString*)order_s andToken:(NSString *)token andEnv:(NSString*)env;

@end
