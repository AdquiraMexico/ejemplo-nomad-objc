//
//  HistorialCell.m
//  
//
//  Created by Ricardo Zertuche on 9/8/15.
//
//

#import "HistorialCell.h"

@implementation HistorialCell


- (void)setDate:(NSString*)date setAmount:(NSString*)amount setConcepto:(NSString*)concepto setOrden:(NSString*)orden setAprobacion:(NSString*)aprobacion setBanco:(NSString*)banco setTarjeta:(NSString*)tarjeta andTipo:(NSString*)tipo andSwipe:(NSString *)swipe{
    
    UILabel *fecha_label = [[UILabel alloc]initWithFrame:CGRectMake(85, 10, self.frame.size.width-70, 20)];
    fecha_label.text = date;
    fecha_label.textColor = [UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1];
    fecha_label.font = [UIFont fontWithName:@"Roboto-Light" size:12];
    [self.contentView addSubview:fecha_label];
    
    UILabel *tipo_label = [[UILabel alloc]initWithFrame:CGRectMake(85, 30, self.frame.size.width-70, 20)];
    tipo_label.text = tipo;
    tipo_label.textColor = [UIColor grayColor];
    tipo_label.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
    [self.contentView addSubview:tipo_label];
    
    UILabel *amount_label = [[UILabel alloc]initWithFrame:CGRectMake(85, 50, self.frame.size.width-70, 20)];
    amount_label.text = amount;
    amount_label.textColor = [UIColor grayColor];
    amount_label.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
    [self.contentView addSubview:amount_label];
    
    UILabel *concepto_label = [[UILabel alloc]initWithFrame:CGRectMake(85, 70, self.frame.size.width-70, 20)];
    concepto_label.text = [NSString stringWithFormat:@"CONCEPTO: %@", concepto];
    concepto_label.textColor = [UIColor grayColor];
    concepto_label.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
    [self.contentView addSubview:concepto_label];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]
                                       initWithAttributedString: concepto_label.attributedText];
    [text addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"Roboto-Light" size:12]
                 range:NSMakeRange(0, 8)];
    [concepto_label setAttributedText: text];
    
    UILabel *order_label = [[UILabel alloc]initWithFrame:CGRectMake(85, 90, self.frame.size.width-70, 20)];
    order_label.text = [NSString stringWithFormat:@"NO. DE ORDEN: %@", orden];
    order_label.font = [UIFont fontWithName:@"Roboto-Bold" size:10];
    order_label.textColor = [UIColor grayColor];
    [self.contentView addSubview:order_label];
    
    NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc]
                                       initWithAttributedString: order_label.attributedText];
    [text2 addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"Roboto-Light" size:12]
                 range:NSMakeRange(0, 12)];
    [order_label setAttributedText: text2];
    
    UILabel *aprobacion_label = [[UILabel alloc]initWithFrame:CGRectMake(85, 110, self.frame.size.width-70, 20)];
    aprobacion_label.text = [NSString stringWithFormat:@"NO. DE APROBACIÓN: %@", aprobacion];;
    aprobacion_label.textColor = [UIColor grayColor];
    aprobacion_label.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
    [self.contentView addSubview:aprobacion_label];
    
    NSMutableAttributedString *text3 = [[NSMutableAttributedString alloc]
                                       initWithAttributedString: aprobacion_label.attributedText];
    [text3 addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"Roboto-Light" size:12]
                 range:NSMakeRange(0, 17)];
    [aprobacion_label setAttributedText: text3];
    
    UILabel *banco_label = [[UILabel alloc]initWithFrame:CGRectMake(85, 130, self.frame.size.width-70, 20)];
    banco_label.text = banco;
    banco_label.textColor = [UIColor grayColor];
    banco_label.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
    [self.contentView addSubview:banco_label];
    
    UIImage *image = [UIImage imageNamed:@"ICO-MC"];
    if ([tarjeta characterAtIndex:0]=='4') {
        image = [UIImage imageNamed:@"ICO-VISA"];
    }
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 57, 55, 36)];
    iv.image = image;
    [self.contentView addSubview:iv];
    
    if ([swipe isEqualToString:@"0"]) {
        self.userInteractionEnabled = NO;
    }
}

@end
