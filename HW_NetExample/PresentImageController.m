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
    NSString * folderName;
    int col;
    int row;
    int width;
    int height;
    CGRect frame;
    int scrollWidth;
    int scrollHeight;
    int currentWidth;
    int currentHeight;
}
@property (nonatomic, weak) IBOutlet UIScrollView *scroll;
@end

@implementation PresentImageController{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_scroll setBounces:NO];
    folderName = [_imageInfo valueForKey: @"folder_name"];
    row = [[_imageInfo valueForKey: @"columns_count"] intValue];
    col = [[_imageInfo valueForKey:@"rows_count"]intValue];
    width = [[_imageInfo valueForKey:@"elem_width"]doubleValue];
    height = [[_imageInfo valueForKey:@"elem_height"]doubleValue];
    scrollWidth = width*col;
    scrollHeight = height*row;
    
    
    [_scroll setContentSize:CGSizeMake(scrollWidth, scrollHeight)];
    
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
    
    int beginX = 0;
    int beginY = 0;
    
        for(int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", folderName, i, j]];
                [[MyNetManager sharedInstance] getAsyncImageWithURL:imgURL complection:^(UIImage *image) {
                        UIImageView* imgView = [[UIImageView alloc]initWithImage:image];
                        [imgView sizeToFit];
                        [imgView setFrame:CGRectMake(beginX, beginY, width, height)];
                        [_scroll addSubview: imgView];
                    }];
                beginX += width;
            }
            beginX = 0;
            beginY += height;
        }
}
@end