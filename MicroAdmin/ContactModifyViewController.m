//
//  ContactModifyViewController.m
//  MicroAdmin
//
//  Created by dev on 2/18/16.
//  Copyright © 2016 company. All rights reserved.
//

#import "ContactModifyViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "getData.h"
#import "SGPopSelectView.h"
@interface ContactModifyViewController ()

@property (nonatomic, strong) NSArray *SelCustomer;
@property (nonatomic, strong) SGPopSelectView *popViewSelCustomer;

@property (nonatomic, strong) NSArray *SelGender;
@property (nonatomic, strong) SGPopSelectView *popViewSelGenter;

@property (nonatomic, strong) NSDictionary *CountryDic;
@property (nonatomic, strong) NSArray *SelCountry;

@property (nonatomic, strong) SGPopSelectView *popViewSelCountry;
@property (nonatomic, strong) SGPopSelectView *popViewSelPostalCountry;

@end

@implementation ContactModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.txtCustomer.text = @"Customer";
    self.txtSelectCountry.text = @"Nederland";
    self.txtPostalCountry.text = @"Nederland";
    
    [self InitDataPicker];
    
    self.SelCustomer = @[@"Customer",@"Supplier",@"Personnal"];
    self.popViewSelCustomer = [[SGPopSelectView alloc] init];
    self.popViewSelCustomer.selections = self.SelCustomer;
    self.popViewSelCustomer.selectedHandle = ^(NSInteger selectedIndex){
        self.txtCustomer.text = self.SelCustomer[selectedIndex];
         [self.popViewSelCustomer hide:YES];
    };
    
    self.SelGender = @[@"Gender",@"male",@"Female"];
    self.popViewSelGenter = [[SGPopSelectView alloc] init];
    self.popViewSelGenter.selections = self.SelGender;
    self.popViewSelGenter.selectedHandle = ^(NSInteger selectedIndex){
        self.txtGender.text = self.SelGender[selectedIndex];
        [self.popViewSelGenter hide:YES];
    };
    
    [self getCountryInfo];
    [self sortCountry];
    self.popViewSelCountry = [[SGPopSelectView alloc] init];
    self.popViewSelCountry.selections = self.SelCountry;
    self.popViewSelCountry.selectedHandle = ^(NSInteger selectedIndex){
        self.txtSelectCountry.text = self.SelCountry[selectedIndex];
        [self.popViewSelCountry hide:YES];
    };
    
    self.popViewSelPostalCountry = [[SGPopSelectView alloc] init];
    self.popViewSelPostalCountry.selections = self.SelCountry;
    self.popViewSelPostalCountry.selectedHandle = ^(NSInteger selectedIndex){
        self.txtPostalCountry.text = self.SelCountry[selectedIndex];
        [self.popViewSelPostalCountry hide:YES];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)OnCustomerEdit:(id)sender {
    CGPoint p = [(UIButton *)sender center];
    p.y += 100;
    [self.popViewSelCustomer showFromView:self.view atPoint:p animated:YES];
}
- (IBAction)OnCustomerEnd:(id)sender {
    [self.popViewSelCustomer hide:YES];
}

- (IBAction)OnGenderEdit:(id)sender {
    CGPoint p = [(UIButton *)sender center];
    p.y += 100;
    [self.popViewSelGenter showFromView:self.view atPoint:p animated:YES];
}
- (IBAction)OnGenderEnd:(id)sender {
    [self.popViewSelGenter hide:YES];
}

- (IBAction)OnSelectCountryEdit:(id)sender {
    CGPoint p = [(UIButton *)sender center];
    [self.popViewSelCountry showFromView:self.view atPoint:p animated:YES];
}
- (IBAction)OnSelectCountryEnd:(id)sender {
    [self.popViewSelCountry hide:YES];
}

- (IBAction)OnPostalCountryEdit:(id)sender {
    CGPoint p = [(UIButton *)sender center];
    [self.popViewSelPostalCountry showFromView:self.view atPoint:p animated:YES];
}
- (IBAction)OnPostalCountryEnd:(id)sender {
    [self.popViewSelPostalCountry hide:YES];
}

-(void)InitDataPicker{
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.txtBirthday setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.txtBirthday setInputAccessoryView:toolBar];
}
-(void)ShowSelectedDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MMM/YYYY"];
    self.txtBirthday.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.txtBirthday resignFirstResponder];
}

-(void)getCountryInfo{
    _CountryDic = @{
                    @"Afghanistan" : @"AF",
                    @"�land Islands" : @"AX",
                    @"Albania" : @"AL",
                    @"Algeria" : @"DZ",
                    @"American Samoa" : @"AS",
                    @"Andorra" : @"AD",
                    @"Angola" : @"AO",
                    @"Anguilla" : @"AI",
                    @"Antarctica" : @"AQ",
                    @"Antigua and Barbuda" : @"AG",
                    @"Argentina" : @"AR",
                    @"Armenia" : @"AM",
                    @"Aruba" : @"AW",
                    @"Australia" : @"AU",
                    @"Austria" : @"AT",
                    @"Azerbaijan" : @"AZ",
                    @"Bahamas" : @"BS",
                    @"Bahrain" : @"BH",
                    @"Bangladesh" : @"BD",
                    @"Barbados" : @"BB",
                    @"Belarus" : @"BY",
                    @"Belgie" : @"BE",
                    @"Belize" : @"BZ",
                    @"Benin" : @"BJ",
                    @"Bermuda" : @"BM",
                    @"Bhutan" : @"BT",
                    @"Bolivia" : @"BO",
                    @"Bosnia and Herzegovina" : @"BA",
                    @"Botswana" : @"BW",
                    @"Bouvet Island" : @"BV",
                    @"Brazil" : @"BR",
                    @"British Indian Ocean Territory" : @"IO",
                    @"Brunei" : @"BN",
                    @"Bulgaria" : @"BG",
                    @"Burkina Faso" : @"BF",
                    @"Burma (Myanmar)" : @"MM",
                    @"Burundi" : @"BI",
                    @"Cambodia" : @"KH",
                    @"Cameroon" : @"CM",
                    @"Canada" : @"CA",
                    @"Cape Verde" : @"CV",
                    @"Cayman Islands" : @"KY",
                    @"Central African Republic" : @"CF",
                    @"Chad" : @"TD",
                    @"Chile" : @"CL",
                    @"China" : @"CN",
                    @"Christmas Island" : @"CX",
                    @"Cocos (Keeling) Islands" : @"CC",
                    @"Colombia" : @"CO",
                    @"Comoros" : @"KM",
                    @"Congo :  Dem. Republic" : @"CD",
                    @"Congo :  Republic" : @"CG",
                    @"Cook Islands" : @"CK",
                    @"Costa Rica" : @"CR",
                    @"Croatia" : @"HR",
                    @"Cuba" : @"CU",
                    @"Cyprus" : @"CY",
                    @"Czech Republic" : @"CZ",
                    @"Denmark" : @"DK",
                    @"Djibouti" : @"DJ",
                    @"Dominica" : @"DM",
                    @"Dominican Republic" : @"DO",
                    @"Duitsland" : @"DE",
                    @"East Timor" : @"TL",
                    @"Ecuador" : @"EC",
                    @"Egypt" : @"EG",
                    @"El Salvador" : @"SV",
                    @"Equatorial Guinea" : @"GQ",
                    @"Eritrea" : @"ER",
                    @"Estonia" : @"EE",
                    @"Ethiopia" : @"ET",
                    @"Falkland Islands" : @"FK",
                    @"Faroe Islands" : @"FO",
                    @"Fiji" : @"FJ",
                    @"Finland" : @"FI",
                    @"France" : @"FR",
                    @"French Guiana" : @"GF",
                    @"French Polynesia" : @"PF",
                    @"French Southern Territories" : @"TF",
                    @"Gabon" : @"GA",
                    @"Gambia" : @"GM",
                    @"Georgia" : @"GE",
                    @"Ghana" : @"GH",
                    @"Gibraltar" : @"GI",
                    @"Greece" : @"GR",
                    @"Greenland" : @"GL",
                    @"Grenada" : @"GD",
                    @"Guadeloupe" : @"GP",
                    @"Guam" : @"GU",
                    @"Guatemala" : @"GT",
                    @"Guernsey" : @"GG",
                    @"Guinea" : @"GN",
                    @"Guinea-Bissau" : @"GW",
                    @"Guyana" : @"GY",
                    @"Haiti" : @"HT",
                    @"Heard Island and McDonald Islands" : @"HM",
                    @"Honduras" : @"HN",
                    @"HongKong" : @"HK",
                    @"Hungary" : @"HU",
                    @"Iceland" : @"IS",
                    @"India" : @"IN",
                    @"Indonesia" : @"ID",
                    @"Iran" : @"IR",
                    @"Iraq" : @"IQ",
                    @"Ireland" : @"IE",
                    @"Israel" : @"IL",
                    @"Italy" : @"IT",
                    @"Ivory Coast" : @"CI",
                    @"Jamaica" : @"JM",
                    @"Japan" : @"JP",
                    @"Jersey" : @"JE",
                    @"Jordan" : @"JO",
                    @"Kazakhstan" : @"KZ",
                    @"Kenya" : @"KE",
                    @"Kiribati" : @"KI",
                    @"Korea :  Dem. Republic of" : @"KP",
                    @"Kuwait" : @"KW",
                    @"Kyrgyzstan" : @"KG",
                    @"Laos" : @"LA",
                    @"Latvia" : @"LV",
                    @"Lebanon" : @"LB",
                    @"Lesotho" : @"LS",
                    @"Liberia" : @"LR",
                    @"Libya" : @"LY",
                    @"Liechtenstein" : @"LI",
                    @"Lithuania" : @"LT",
                    @"Luxemburg" : @"LU",
                    @"Macau" : @"MO",
                    @"Macedonia" : @"MK",
                    @"Madagascar" : @"MG",
                    @"Malawi" : @"MW",
                    @"Malaysia" : @"MY",
                    @"Maldives" : @"MV",
                    @"Mali" : @"ML",
                    @"Malta" : @"MT",
                    @"Man Island" : @"IM",
                    @"Marshall Islands" : @"MH",
                    @"Martinique" : @"MQ",
                    @"Mauritania" : @"MR",
                    @"Mauritius" : @"MU",
                    @"Mayotte" : @"YT",
                    @"Mexico" : @"MX",
                    @"Micronesia" : @"FM",
                    @"Moldova" : @"MD",
                    @"Monaco" : @"MC",
                    @"Mongolia" : @"MN",
                    @"Montenegro" : @"ME",
                    @"Montserrat" : @"MS",
                    @"Morocco" : @"MA",
                    @"Mozambique" : @"MZ",
                    @"Namibia" : @"NA",
                    @"Nauru" : @"NR",
                    @"Nederland" : @"NL",
                    @"Nepal" : @"NP",
                    @"Netherlands Antilles" : @"AN",
                    @"New Caledonia" : @"NC",
                    @"New Zealand" : @"NZ",
                    @"Nicaragua" : @"NI",
                    @"Niger" : @"NE",
                    @"Nigeria" : @"NG",
                    @"Niue" : @"NU",
                    @"Norfolk Island" : @"NF",
                    @"Northern Mariana Islands" : @"MP",
                    @"Norway" : @"NO",
                    @"Oman" : @"OM",
                    @"Pakistan" : @"PK",
                    @"Palau" : @"PW",
                    @"Palestinian Territories" : @"PS",
                    @"Panama" : @"PA",
                    @"Papua New Guinea" : @"PG",
                    @"Paraguay" : @"PY",
                    @"Peru" : @"PE",
                    @"Philippines" : @"PH",
                    @"Pitcairn" : @"PN",
                    @"Poland" : @"PL",
                    @"Portugal" : @"PT",
                    @"Puerto Rico" : @"PR",
                    @"Qatar" : @"QA",
                    @"Reunion Island" : @"RE",
                    @"Romania" : @"RO",
                    @"Russian Federation" : @"RU",
                    @"Rwanda" : @"RW",
                    @"Saint Barthelemy" : @"BL",
                    @"Saint Kitts and Nevis" : @"KN",
                    @"Saint Lucia" : @"LC",
                    @"Saint Martin" : @"MF",
                    @"Saint Pierre and Miquelon" : @"PM",
                    @"Saint Vincent and the Grenadines" : @"VC",
                    @"Samoa" : @"WS",
                    @"San Marino" : @"SM",
                    @"S�o Tom� and Pr�ncipe" : @"ST",
                    @"Saudi Arabia" : @"SA",
                    @"Senegal" : @"SN",
                    @"Serbia" : @"RS",
                    @"Seychelles" : @"SC",
                    @"Sierra Leone" : @"SL",
                    @"Singapore" : @"SG",
                    @"Slovakia" : @"SK",
                    @"Slovenia" : @"SI",
                    @"Solomon Islands" : @"SB",
                    @"Somalia" : @"SO",
                    @"South Africa" : @"ZA",
                    @"South Georgia and the South Sandwich Islands" : @"GS",
                    @"South Korea" : @"KR",
                    @"Spain" : @"ES",
                    @"Sri Lanka" : @"LK",
                    @"Sudan" : @"SD",
                    @"Suriname" : @"SR",
                    @"Svalbard and Jan Mayen" : @"SJ",
                    @"Swaziland" : @"SZ",
                    @"Sweden" : @"SE",
                    @"Switzerland" : @"CH",
                    @"Syria" : @"SY",
                    @"Taiwan" : @"TW",
                    @"Tajikistan" : @"TJ",
                    @"Tanzania" : @"TZ",
                    @"Thailand" : @"TH",
                    @"Togo" : @"TG",
                    @"Tokelau" : @"TK",
                    @"Tonga" : @"TO",
                    @"Trinidad and Tobago" : @"TT",
                    @"Tunisia" : @"TN",
                    @"Turkey" : @"TR",
                    @"Turkmenistan" : @"TM",
                    @"Turks and Caicos Islands" : @"TC",
                    @"Tuvalu" : @"TV",
                    @"Uganda" : @"UG",
                    @"Ukraine" : @"UA",
                    @"United Arab Emirates" : @"AE",
                    @"United Kingdom" : @"GB",
                    @"United States" : @"US",
                    @"Uruguay" : @"UY",
                    @"Uzbekistan" : @"UZ",
                    @"Vanuatu" : @"VU",
                    @"Vatican City State" : @"VA",
                    @"Venezuela" : @"VE",
                    @"Vietnam" : @"VN",
                    @"Virgin Islands (British)" : @"VG",
                    @"Virgin Islands (U.S.)" : @"VI",
                    @"Wallis and Futuna" : @"WF",
                    @"Western Sahara" : @"EH",
                    @"Yemen" : @"YE",
                    @"Zambia" : @"ZM",
                    @"Zimbabwe" : @"ZW"

                    };
}
-(void)sortCountry{
    _SelCountry = [_CountryDic keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2];
    }];
}


-(void)show_toast:(NSString *)message{
    //diplay message--------------
    
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    toast.backgroundColor=[UIColor redColor];
    [toast show];
    int duration = 2; // duration in seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{                [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
    //----------------------------
}

- (IBAction)OnAddContact:(id)sender {
    
}
@end
