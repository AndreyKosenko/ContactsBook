//
//  ViewController.m
//  MicroAdmin
//
//  Created by dev on 2016. 2. 13..
//  Copyright © 2016 year company. All rights reserved.
//

#import "ViewController.h"
#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

#import <AFNetworking/AFNetworking.h>
#import "getData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _indicator.hidden = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender {
//    [self loginfunction];
//    return;
    
    NSString *userEmail = self.emailText.text;//_emailText.text;
    NSString *password = self.pswText.text;
    
    if ([userEmail isEqualToString:@""] || [password isEqualToString:@""]) {
        userEmail = @"auwdio@hotmail.com";
        password = @"testtest";
        
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@", userEmail, password];
    NSString *md5String = [NSString stringWithFormat:@"%@", [str MD5]];
    
    NSString *post = [[NSString alloc] initWithFormat:@"email=%@&myhash=%@",userEmail,md5String];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSURL *url = [NSURL URLWithString:URL1];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPBody:postData];
    
    NSURLConnection *theconnection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    [theconnection start];
    
    if( theconnection )
    {
        _indicator.hidden = NO;
        [_indicator startAnimating];
        mutableData = [[NSMutableData alloc] init];
    }
    else
    {
        NSLog(@"Internet problem maybe...");
    }
}



#pragma mark NSURLConnection delegates

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    [mutableData setLength:0];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // show error
    _indicator.hidden = YES;
    [_indicator stopAnimating];
    return;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *loginStatus = [[NSString alloc] initWithBytes: [mutableData mutableBytes] length:[mutableData length] encoding:NSUTF8StringEncoding];
    NSLog(@"after compareing data is %@", loginStatus);
    if ([loginStatus isEqualToString:@"ok"]) {
        [self show_toast:@"OK"];
        // right login
        [self getRequestData];
        
    } else {
        // wrong login
        [self show_toast:loginStatus];
    }
    _indicator.hidden = YES;
    [_indicator stopAnimating];
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

- (void)getRequestData {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [[manager HTTPRequestOperationWithRequest:[getData searchRequest] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // init data
        // init _category_Dic
        if (contactsData == nil) {
            contactsData = [[NSMutableDictionary alloc]init];
            orderedKeys = [[NSMutableArray alloc]init];
        }else{
            [contactsData removeAllObjects];
            contactsData = nil;
            contactsData = [[NSMutableDictionary alloc]init];
            
            [orderedKeys removeAllObjects];
            orderedKeys = nil;
            orderedKeys = [[NSMutableArray alloc]init];
        }
        
        contactsData = [[responseObject objectForKey:@"data"] mutableCopy];
        [self sortContacts];
        [self performSegueWithIdentifier:@"segueID_Contacts" sender:self];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        NSString *strError = [[NSString init]initWithFormat:@"%@", error];
        //UIAlertView to let them know that something happened with the network connection...
        [self show_toast:strError];
    }] start];
}
-(void)sortContacts{
    
    orderedKeys = [[contactsData allKeys] mutableCopy];
    orderedKeys = [[orderedKeys sortedArrayUsingComparator:^(id a, id b) {
        return [a compare:b options:NSNumericSearch];
    }]mutableCopy];
    
}



@end
