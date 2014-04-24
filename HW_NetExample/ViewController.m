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
@property NSDictionary *imagesInfo;
@end

@implementation ViewController
@synthesize imagesInfo;
- (void)viewDidLoad
{
    [super viewDidLoad];
    presentData=[[NSArray alloc] initWithObjects:(NSString *) @"plane",(NSString *) @"mountain",(NSString *) @"sunset",(NSString *) @"forest", nil];
    imagesInfo=@{
                 presentData[0]:[self returnDictionaryWithWidth:41 Height: 46 ColCount:12 andRows:20],
                 presentData[1]:[self returnDictionaryWithWidth:41 Height: 41 ColCount:15 andRows:20],
                 presentData[2]:[self returnDictionaryWithWidth:197 Height: 263 ColCount:2 andRows:4],
                 presentData[3]:[self returnDictionaryWithWidth:461 Height: 181 ColCount:3 andRows:2],
                };
}
-(NSDictionary *)returnDictionaryWithWidth:(int)w Height:(int)h ColCount:(int)c andRows:(int)r{
    NSDictionary *info=@{
                         @"width":@((int)w),
                         @"height":@((int)h),
                         @"col":@((int)c),
                         @"row":@((int)r),
                         };
    return info;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    PresentImageController *imageViewController = segue.destinationViewController;
    imageViewController.folder=sender.textLabel.text;
    imageViewController.imageInfo=imagesInfo[imageViewController.folder];
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
    }];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text=presentData[indexPath.row];
    return cell;
}
@end
