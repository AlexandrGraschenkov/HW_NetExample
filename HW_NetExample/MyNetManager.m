//
//  MyNetManager.m
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MyNetManager.h"

@implementation MyNetManager

// в каждой функции чего-то не хватает
+ (instancetype)sharedInstance
{
    static id _singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[MyNetManager alloc] init];
    });
    return _singleton;}

- (void)getAsyncImagesInfo:(void(^)(NSArray* imagesInfo))complection
{
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/ListImages.json"];
}

- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection
{
    
}
- (void)getImageAsyncInScroll:(UIScrollView *)scroll byUrl:(NSURL *)imgURL InThread:(dispatch_queue_t)downloadThread IfNonStop:(BOOL)stop AtIndexI:(int)i AndJ:(int)j{
    dispatch_async(downloadThread,^{
        if(stop) return ;
        NSData *img=[NSData dataWithContentsOfURL:imgURL];
        dispatch_async(dispatch_get_main_queue(),^{
            UIImageView *image=[[UIImageView alloc] init];
            image.image= [UIImage imageWithData:img];
            CGRect frame=CGRectMake(j*image.image.size.width, i*image.image.size.height, image.image.size.width,image.image.size.height);
            image.frame=frame;
            [scroll addSubview:image];
        });
        
    });
}

@end
