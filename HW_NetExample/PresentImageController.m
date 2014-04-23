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
    
    int rows = [[_imageInfo objectForKey:@"columns_count"] intValue];
    int columns = [[_imageInfo objectForKey:@"rows_count"] intValue];
    int width = [[_imageInfo objectForKey:@"elem_width"] intValue];
    int height = [[_imageInfo objectForKey:@"elem_height"] intValue];
    NSString *folderName = [_imageInfo objectForKey:@"folder_name"];
    self.scroll.contentSize = CGSizeMake(width * columns, height * rows);
    for (int row = 0; row < rows; row++)
    {
        for (int col = 0; col < columns; col++)
        {
            NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", folderName, row, col]];
            
            [[MyNetManager sharedInstance] getAsyncImageWithURL:imgURL completion:^(UIImage *image) {
                UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(col * width, row * height, width, height)];
                view.image = image;
                [self.scroll addSubview:view];
            }];
        }
    }
}

@end
