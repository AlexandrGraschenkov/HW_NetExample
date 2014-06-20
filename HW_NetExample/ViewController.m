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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[MyNetManager sharedInstance] getAsyncImagesInfo:^(NSArray *imagesInfo) {
      
       // NSLog(@"images loaded");
       // NSLog(@"%@", imagesInfo);
        presentData = imagesInfo;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self tableView] reloadData];
        });
        
    }];
    

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    PresentImageController *imgController = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    imgController.imageInfo = [presentData objectAtIndex:indexPath.row];
   // NSLog(@"PRESENT DATA %@", [presentData objectAtIndex:indexPath.row]);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData
{
   UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
   [self.view addSubview:view];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.tintColor = [UIColor blackColor];
    indicator.center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:indicator];
    
    [indicator startAnimating];
    
   }

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [presentData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [[presentData objectAtIndex:indexPath.row]objectForKey:@"folder_name"];
    return cell;
}

@end
