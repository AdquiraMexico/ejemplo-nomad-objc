//
//  HistorialViewController.h
//  
//
//  Created by Ricardo Zertuche on 9/8/15.
//
//

#import <UIKit/UIKit.h>
#import <mPosAPI/BBVANomad.h>
#import "HistorialCell.h"
#import "MGSwipeButton.h"
#import "Popup.h"

@interface HistorialViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate, BBVADelegate, UITextFieldDelegate>{
    UITableView *historial;
    NSIndexPath *row_to_delete;
    Popup *popup;
    Popup *popup_loader;
    
    UIView *search_view;
    BOOL search_is_open;
    
    UIButton *info_bar;
    
    UILabel *search_label;
    UITextField *search_tf;
    UIButton *button_apr;
    UIButton *button_orden;
}

@property (nonatomic) NSMutableArray *objects;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *env;

@property (nonatomic) BBVANomad *bbvaAPI;

@end
