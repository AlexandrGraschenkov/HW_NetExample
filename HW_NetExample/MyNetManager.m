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
    //NSURLConnection * connection = [NSURLConnection alloc]init
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/ListImages.json"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSURLResponse *resp;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:nil];//[[NSData alloc]initWithContentsOfURL:url];
    NSArray *imageInfo = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    _imageInfo = imageInfo;
    NSLog(@"Image List %@",imageInfo);
    NSMutableArray *imageNames = [NSMutableArray new];// = [_imageInfo mutableArrayValueForKey:@"folder_name"];
    for(NSDictionary* dic in _imageInfo) {
        [imageNames addObject:[dic valueForKey:@"folder_name"]];
        NSLog(@"%@", [dic valueForKey:@"folder_name"]);
    }
    complection(imageNames);
}

- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection
{
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    complection(img);
}

@end
