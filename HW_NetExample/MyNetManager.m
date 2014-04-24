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
    static MyNetManager *manager;
    if(!manager) {
        manager = [MyNetManager new];
        
    }
    return manager;
}


- (void)getAsyncImagesInfo:(void(^)(NSArray* imagesInfo))complection
{
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/ListImages.json"];
    NSData *data = [self getDataFromUrl:url];
    _imageInfo = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    complection(_imageInfo);
}

- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection
{
    
    NSData * data = [self getDataFromUrl:url];
    UIImage *img = [UIImage imageWithData:data];
    complection(img);
}

-(NSData *)getDataFromUrl:(NSURL*)url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSURLResponse *resp;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:nil];
    return data;
}

@end
