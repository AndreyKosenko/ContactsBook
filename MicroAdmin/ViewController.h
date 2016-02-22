//
//  ViewController.h
//  MicroAdmin
//
//  Created by dev on 2016. 2. 13..
//  Copyright © 2016년 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDelegate>{
    NSMutableData *mutableData;
    #define URL @"http://www.earchief.nl/microadmin/?obj=authentication&func=process&au_then_ti_ca_tion=PostLogin"
    
    #define URL1 @"http://www.ikzzp.nl/microadmin/?obj=authentication&func=process&au_then_ti_ca_tion=PostLogin" 
}

- (IBAction)loginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *pswText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

