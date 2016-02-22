//
//  ContactModifyViewController.h
//  MicroAdmin
//
//  Created by dev on 2/18/16.
//  Copyright © 2016 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactModifyViewController : UIViewController{
    UIDatePicker *datePicker;
}

@property (weak, nonatomic) IBOutlet UITextField *txtCustomer;
@property (weak, nonatomic) IBOutlet UITextField *txtGender;
@property (weak, nonatomic) IBOutlet UITextField *txtBirthday;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailAddr;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtAddr;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;
@property (weak, nonatomic) IBOutlet UITextField *txtPostalAddr;
@property (weak, nonatomic) IBOutlet UITextField *txtPostalZip;
@property (weak, nonatomic) IBOutlet UITextField *txtPostalCity;
@property (weak, nonatomic) IBOutlet UITextField *txtEnterNote;
@property (weak, nonatomic) IBOutlet UITextField *txtCompany;
@property (weak, nonatomic) IBOutlet UITextField *txtSelectCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtPostalCountry;

- (IBAction)OnAddContact:(id)sender;
@end
