//
//  MyNetManager.m
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MyNetManager.h"

@interface MyNetManager ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end
@implementation MyNetManager

// в каждой функции чего-то не хватает
+ (instancetype)sharedInstance
{
    static MyNetManager *net;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(){
        net = [MyNetManager new];
        net.queue = [NSOperationQueue new];
    });
    return net;
}

- (void)getAsyncImagesInfo:(void(^)(NSArray* imagesInfo))complection
{
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/ListImages.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        complection([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]);
    }];
}

- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue: _queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        complection([UIImage imageWithData:data]);
    }];
}

@end
