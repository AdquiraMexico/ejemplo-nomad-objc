//
//  SoporteViewController.m
//  
//
//  Created by Ricardo Zertuche on 9/8/15.
//
//

#import "SoporteViewController.h"

@interface SoporteViewController ()

@end

@implementation SoporteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [menu_bar addTarget:self action:@selector(dismissSoporte) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *menu_bar_button = [[UIBarButtonItem alloc] initWithCustomView:menu_bar];
    
    UIImage *logo_bar_img = [UIImage imageNamed:@"BAR"];
    UIButton *logo_bar = [UIButton buttonWithType:UIButtonTypeCustom];
    logo_bar.bounds = CGRectMake( 0, 0, logo_bar_img.size.width, logo_bar_img.size.height );
    [logo_bar setImage:logo_bar_img forState:UIControlStateNormal];
    [logo_bar setImage:logo_bar_img forState:UIControlStateSelected];
    [logo_bar setImage:logo_bar_img forState:UIControlStateHighlighted];
    UIBarButtonItem *logo_bar_button = [[UIBarButtonItem alloc] initWithCustomView:logo_bar];
    
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:menu_bar_button, flexibleSpace, logo_bar_button, flexibleSpace, nil];
    
    [toolbar setItems:toolbarItems animated:NO];
    [self.view addSubview:toolbar];
    
    UITextView *todo_label = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 300, 310)];
    todo_label.center = self.view.center;
    todo_label.textColor = [UIColor grayColor];
    todo_label.scrollEnabled = false;
    //todo_label.numberOfLines = 0;

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Soporte:\n (01-800) 060-6767\n Lunes a Viernes de 9:00 a 17:00 hrs.\n Correo electrónico: \n contacto@flap.com.mx"];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:12];
    [text addAttribute:NSParagraphStyleAttributeName
                 value:style
                 range:NSMakeRange(0, [text length])];
    UIFont *font = [UIFont fontWithName:@"Roboto-Light" size:17.0];
    UIFont *font2 = [UIFont fontWithName:@"Roboto-Bold" size:20.0];
    UIFont *font3 = [UIFont fontWithName:@"Roboto-Bold" size:26.0];
    UIFont *font4 = [UIFont fontWithName:@"Roboto-Light" size:20.0];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(0, 25)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor]range:NSMakeRange(0, 25)];
    [text addAttribute:NSFontAttributeName value:font3 range:NSMakeRange(8, 19)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1]range:NSMakeRange(8, 19)];
    [text addAttribute:NSFontAttributeName value:font range:NSMakeRange(27, 41)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor]range:NSMakeRange(27, 41)];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(65, 22)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor]range:NSMakeRange(64, 22)];
    [text addAttribute:NSFontAttributeName value:font4 range:NSMakeRange(86, 23)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:11.0/255.0 green:187.0/255.0 blue:239.0/255.0 alpha:1]range:NSMakeRange(86, 23)];
    
    todo_label.attributedText = text;
    todo_label.textAlignment = NSTextAlignmentCenter;
    todo_label.editable = NO;
    todo_label.selectable = YES;
    
    [self.view addSubview:todo_label];
    
    UIButton *cont_button  = [[UIButton alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-70, self.view.frame.size.width-20, 60)];
    [[cont_button imageView] setContentMode: UIViewContentModeScaleAspectFit];
    cont_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    cont_button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [cont_button setImage:[UIImage imageNamed:@"LLAMAR"] forState:UIControlStateNormal];
    [cont_button addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:cont_button];
    
    
}
- (void)callPhone{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:018000606767"]];
}
- (void)dismissSoporte{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SecondViewControllerDismissed"
                                                        object:nil
                                                      userInfo:nil];
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
