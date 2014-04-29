//
//  ViewController.m
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "MyNetManager.h"
#import "PresentImageController.h"

@interface ViewController ()
{
    NSArray* presentData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PresentImageController *controller = [segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [controller setImageInfo:[presentData objectAtIndex:indexPath.row]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)reloadData
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [view.layer setCornerRadius:5.0f];
    view.center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
    [self.view addSubview:view];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.tintColor = [UIColor blackColor];
    indicator.center = CGPointMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0);
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [view addSubview:indicator];
    [indicator startAnimating];
    
    
    [[MyNetManager sharedInstance] getAsyncImagesInfo:^(NSArray *imagesInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [view removeFromSuperview];
            presentData = imagesInfo;
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return presentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell.textLabel setText:[[presentData objectAtIndex:indexPath.row] objectForKey:@"folder_name"]];
    return cell;
}

@end
