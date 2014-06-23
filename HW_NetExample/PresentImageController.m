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
    
    int width = [[_imageInfo objectForKey:@"elem_width"] intValue];
    int height = [[_imageInfo objectForKey:@"elem_height"] intValue];
    size_t columns = [[_imageInfo objectForKey:@"rows_count"] intValue];
    size_t rows = [[_imageInfo objectForKey:@"columns_count"] intValue];
    NSString *folderName = [_imageInfo objectForKey:@"folder_name"];
    [self.scroll setContentSize:CGSizeMake(width * columns, height * rows)];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", folderName, i, j]];
            [[MyNetManager sharedInstance] getAsyncImageWithURL:imageURL complection:^(UIImage *image) {
                dispatch_async(dispatch_get_main_queue(), ^(){
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(j * width, i * height, width, height)];
                    imgView.image = image;
                    [self.scroll addSubview:imgView];
                });
            }];
        }
    }
    
}

@end
