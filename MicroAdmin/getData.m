//
//  YelpYapper.m
//  Glutton
//
//  Created by Tyler on 4/2/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "getData.h"
#import <AFNetworking/AFNetworking.h>
//#import "NSURLRequest+OAuth.h"
/**
 Default paths and search terms used in this example
 */
static NSString * const kAPIHost           = @"ikzzp.nl";
static NSString * const kSearchPath        = @"/microadmin/";

NSMutableDictionary *contactsData;
NSMutableArray *orderedKeys;
@implementation getData


//+ (NSArray *)getBusinesses:(float)offsetFromCurrentLocation {
////    NSLog(@"In the other business method");
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [[manager HTTPRequestOperationWithRequest:[self searchRequest:CLLocationCoordinate2DMake(0.0, 0.0) withOffset:0] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",[responseObject objectForKey:@"businesses"]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    }] start];
//    return nil;
//}

//+ (NSArray *)getRequest{
//    //    NSLog(@"In the other business method");
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [[manager HTTPRequestOperationWithRequest:[self searchRequest] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"%@",[responseObject objectForKey:@"businesses"]);
//    
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    
//    }] start];
//    return nil;
//}


+ (NSURLRequest *)searchRequest{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:@"rows" forKey:@"json"];
    [params setObject:@"obj" forKey:@"listcontacts"];
    
     NSURL *url = [NSURL URLWithString:@"http://www.ikzzp.nl/microadmin/?json=rows&obj=listcontacts"];
    return [NSURLRequest requestWithURL:url];
}

+ (NSURLRequest *)searchRequestContact:(NSString*)contactID{
    
 
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://www.ikzzp.nl/microadmin/?json=row&obj=editcontact&id_contact=%@",contactID];
    NSURL *url = [NSURL URLWithString:strURL];
    return [NSURLRequest requestWithURL:url];
}

+ (NSURLRequest *)DeleteRequestContact:(NSString*)postString{
    
    NSString *strURL = @"http://www.ikzzp.nl/microadmin?json=post&obj=editcontact";
    NSString *strRequestUrl = [[NSString alloc]initWithFormat:@"%@&%@",strURL, postString];
    //NSString *strURL = @"http://www.ikzzp.nl/microadmin?json=post&obj=editcontact&act=update";
    
    //&id_contact=%@",contactID
    NSURL *url = [NSURL URLWithString:strRequestUrl];
    return [NSURLRequest requestWithURL:url];
    
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:url];
//    [request setHTTPMethod:@"POST"];
//    
//    //NSString *post = [[NSString alloc] initWithFormat:@"id_contact=%@",contactID];
//    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
//
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    
//    [request setHTTPBody:postData];
    
    
//    NSError *error = nil;
//    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:postDic
//                                               options:NSJSONWritingPrettyPrinted
//                                                 error:&error];
//    
//    // create request body
//    NSMutableData *body = [NSMutableData data];
//    [body appendData:jsondata];
//    
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsondata length]] forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPBody:body];
    
//    return request;
}
@end
