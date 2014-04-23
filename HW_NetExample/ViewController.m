//
//  ViewController.m
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "MyNetManager.h"
#import "MyTableViewCell.h"
#import "PresentImageController.h"

@interface ViewController ()
{
    NSArray* presentData;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    static NSString *identifier = @"ShowImage";
    if ([segue.identifier isEqualToString:identifier]) {
        PresentImageController *destination = [segue destinationViewController];
        destination.imageInfo = (NSDictionary *)[presentData objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)reloadData
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor blackColor];
    
    indicator.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    
    [[MyNetManager sharedInstance] getAsyncImagesInfo:^(NSArray *imagesInfo) {
        [indicator removeFromSuperview];
        presentData = [NSArray arrayWithArray:imagesInfo];
        dispatch_async(dispatch_get_main_queue(), ^(){
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return presentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *dictionary = presentData[indexPath.row];
    [cell setText:[dictionary valueForKey:@"folder_name"]];
    return cell;
}

@end
