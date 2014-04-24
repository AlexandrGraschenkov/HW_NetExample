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
{
    __block BOOL stop;
    dispatch_queue_t downloadThread;
}
@property (nonatomic, weak) IBOutlet UIScrollView *scroll;
@end

@implementation PresentImageController
@synthesize scroll=_scroll;
@synthesize imageInfo;
@synthesize folder;
- (void)viewDidLoad
{
    [super viewDidLoad];
    downloadThread = dispatch_queue_create("download", 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%d",(int)imageInfo[@"col"]);
    stop=NO;
    [super viewWillAppear:animated];
    
    [self reloadAndPresentData];
}
-(void)viewDidDisappear:(BOOL)animated
{
    stop=YES;
}

- (void)reloadAndPresentData
{
    for(UIView *v in _scroll.subviews){
        [v removeFromSuperview];
    }
    NSNumber *col=imageInfo[@"col"];
    NSNumber *row=imageInfo[@"row"];
    NSNumber *width=imageInfo[@"width"];
    NSNumber *height=imageInfo[@"height"];
    for(int i=0;i<col.integerValue;i++){
        for(int j=0;j<row.integerValue;j++){
            NSURL *imgURL= [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", folder, i, j ]];
            [[MyNetManager sharedInstance] getImageAsyncInScroll:_scroll byUrl:imgURL InThread:downloadThread IfNonStop:stop AtIndexI:i AndJ:j];
        }
    }
    _scroll.contentSize=CGSizeMake(width.integerValue*row.integerValue,height.integerValue*col.integerValue);
    _scroll.pagingEnabled=NO;

//    NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", folderName, col, row]];
    
}

@end
