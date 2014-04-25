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
#import "Cell.h"

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
    PresentImageController *presentImageController = segue.destinationViewController;
    int index = self.tableView.indexPathForSelectedRow.row;
    NSDictionary *currentDic = [NSDictionary new];
    currentDic = [MyNetManager sharedInstance].imageInfo[index];
    presentImageController.imageInfo = currentDic;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)reloadData
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.tintColor = [UIColor blackColor];
    indicator.center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    
    [[MyNetManager sharedInstance] getAsyncImagesInfo:^(NSArray *imagesInfo) {
        [indicator removeFromSuperview];
        
        // обновление данных
        NSMutableArray *imageNames = [NSMutableArray new];
        for(NSDictionary* dic in imagesInfo) {
            [imageNames addObject:[dic valueForKey:@"folder_name"]];
        }
        presentData = imageNames;

    }];
}

#pragma mark - Table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return presentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    Cell *currentCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [currentCell setTitle:[presentData objectAtIndex:indexPath.row]];
    return currentCell;
}

@end
