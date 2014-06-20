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
    NSString *folderName =[self.imageInfo objectForKey:@"folder_name"];
   // NSLog(@"Folder Name%@",folderName);
    int row = [[self.imageInfo objectForKey:@"columns_count"]intValue] ;
    int column = [[self.imageInfo objectForKey:@"rows_count"]intValue] ;
    int width = [[self.imageInfo objectForKey:@"elem_width"]intValue] ;
    int height = [[self.imageInfo objectForKey:@"elem_height"]intValue];
    self.scroll.contentSize = CGSizeMake(column * width,  row * height);
    //NSLog(@"PRESENIMAGE");
  
    for (int i= 0; i<row ;i++){
        for(int j = 0; j<column; j++){
    
            NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/%@/%d_%d.png", folderName ,i , j]];
            [[MyNetManager sharedInstance]getAsyncImageWithURL:imgURL complection:^(UIImage *img){
                dispatch_async(dispatch_get_main_queue(), ^(){
                   
                   UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(j*width,i*height,width,height ) ];
                    
                    imgView.image = img;
                    [self.scroll addSubview:imgView];
                    [self.view setNeedsDisplay];
                    [self.scroll setNeedsDisplay];
                    
                });
            }];
           
            
            
    }
    }
}

@end
