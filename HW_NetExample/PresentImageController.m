//
//  PresentImageController.m
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "PresentImageController.h"
#import "MyNetManager.h"

@interface PresentImageController ()
{}
@property (nonatomic, weak) IBOutlet UIScrollView *scroll;
@end

@implementation PresentImageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadAndPresentData];
}

- (void)reloadAndPresentData
{
    for(UIView *v in self.scroll.subviews){
        [v removeFromSuperview];
    }
    
//    NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", folderName, col, row]];
    
}

@end
