//
//  MyNetManager.m
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MyNetManager.h"

@implementation MyNetManager

+ (instancetype)sharedInstance
{
    static MyNetManager *staticManagerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ staticManagerInstance = [[MyNetManager alloc] init]; });
    return staticManagerInstance;
}


- (void)getAsyncImagesInfo:(void(^)(NSArray* imagesInfo))complection
{
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/ListImages.json"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *localError = NULL;
        
        NSArray *items = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:&localError];
        
        if (localError) {
            NSLog(@"%@", [localError localizedDescription]);
        }
        if (complection) { complection(items); }
        
    }] resume];
}


- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error debugDescription]);
        }
        if (complection) { complection([UIImage imageWithData:data]); }
        
    }] resume];
}

@end
