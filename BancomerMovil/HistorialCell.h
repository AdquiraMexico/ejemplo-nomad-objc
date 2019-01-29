//
//  HistorialCell.h
//  
//
//  Created by Ricardo Zertuche on 9/8/15.
//
//

#import "MGSwipeTableCell.h"

@interface HistorialCell : MGSwipeTableCell

- (void)setDate:(NSString*)date setAmount:(NSString*)amount setConcepto:(NSString*)concepto setOrden:(NSString*)orden setAprobacion:(NSString*)aprobacion setBanco:(NSString*)banco setTarjeta:(NSString*)tarjeta andTipo:(NSString*)tipo andSwipe:(NSString*)swipe;

@end
