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
    
    CGSize sliceSize = CGSizeMake([[_imageInfo objectForKey:@"elem_width"] doubleValue], [[_imageInfo objectForKey:@"elem_height"] doubleValue]);
    
    size_t rows = [[_imageInfo objectForKey:@"rows_count"] intValue];
    size_t columns = [[_imageInfo objectForKey:@"columns_count"] intValue];
    
    [self.scroll setContentSize:CGSizeMake(sliceSize.width*rows, sliceSize.height*columns)];
    
    for (int i = 0; i < columns; i++) {
        for (int j = 0; j < rows; j++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(j*sliceSize.width, i*sliceSize.height, sliceSize.width, sliceSize.height)];
            
            NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", [_imageInfo objectForKeyedSubscript:@"folder_name"], i, j]];
            
            [[MyNetManager sharedInstance] getAsyncImageWithURL:imgURL complection:^(UIImage *image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [imageView setImage:image];
                });
            }];
            
            [self.scroll addSubview:imageView];
        }
    }
}

@end
