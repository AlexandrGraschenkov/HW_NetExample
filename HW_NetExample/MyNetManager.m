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
    static MyNetManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MyNetManager alloc] init];
    });
    return manager;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)getAsyncImagesInfo:(void(^)(NSArray* imagesInfo))complection
{
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/ListImages.json"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *err = nil;
        NSArray *items = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:&err];
        
        if (err) {
            NSLog(@"%@", [err localizedDescription]);
        }
        
        if (complection) {
            complection(items);
        }
    }] resume];
}

- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error debugDescription]);
        }
        
        if (complection) {
            complection([UIImage imageWithData:data]);
        }
    }] resume];
}

@end
