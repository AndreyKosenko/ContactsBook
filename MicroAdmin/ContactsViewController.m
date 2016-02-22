//
//  ContactsViewController.m
//  MicroAdmin
//
//  Created by dev on 2/18/16.
//  Copyright © 2016 company. All rights reserved.
//

#import "ContactsViewController.h"
#import "getData.h"

#import "ContactEditViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tblContacts.delegate = self;
    _tblContacts.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -tblContacts tableView delegate & datasources

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // typically you need know which item the user has selected.
    // this method allows you to keep track of the selection

    NSDictionary *contactOne = [contactsData objectForKey:[orderedKeys objectAtIndex:indexPath.row]];
    NSString *phNo = [contactOne objectForKey:@"phone"];
    //NSString *phNo = @"+8617073474541";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        NSString *strMessage = [[NSString alloc]initWithFormat:@"Call facility is not available! '%@'", phNo];
        [self show_toast:strMessage];
    }
}

// This will tell your UITableView how many rows you wish to have in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [orderedKeys count];
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"contact_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    NSDictionary *contactOne = [contactsData objectForKey:[orderedKeys objectAtIndex:indexPath.row]];
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:1];
    NSString *strName = [[NSString alloc]initWithFormat:@"%@ %@", [contactOne objectForKey:@"firstname"], [contactOne objectForKey:@"lastname"]];
    nameLabel.text = strName;
    
    UILabel *phoneNumber = (UILabel*) [cell viewWithTag:2];
    phoneNumber.text = [contactOne objectForKey:@"phone"];
    
    UIImageView *personImage = (UIImageView*)[cell viewWithTag:4];
    personImage.image = [UIImage imageNamed:@"person1.png"];
    
    UIImageView *phoneImage = (UIImageView*)[cell viewWithTag:3];
    phoneImage.image = [UIImage imageNamed:@"phone.jpg"];
    
    return cell;
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




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SegueEditContact"]) {
        ContactEditViewController *contactEdit = (ContactEditViewController *)[segue destinationViewController];
        NSIndexPath *selectedIndexPath = [_tblContacts indexPathForSelectedRow];
        CGPoint hitPoint = [sender convertPoint:CGPointZero toView:_tblContacts];
        NSIndexPath *hitIndex = [_tblContacts indexPathForRowAtPoint:hitPoint];
        NSString *contactID = [orderedKeys objectAtIndex:hitIndex.row];
        [contactEdit setContactID:contactID];
    }
    //
}


@end
