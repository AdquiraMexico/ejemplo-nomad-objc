//
//  CustomPopoverController.m
//  
//
//  Created by Ricardo Zertuche on 9/4/15.
//
//

#import "CustomPopoverController.h"

@interface CustomPopoverController () <UIPopoverPresentationControllerDelegate>

@end

@implementation CustomPopoverController

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.delegate = self;
    }
    return self;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone; //You have to specify this particular value in order to make it work on iPhone.
}

@end