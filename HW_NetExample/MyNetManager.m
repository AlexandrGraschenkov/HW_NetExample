//
//  MyNetManager.m
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MyNetManager.h"

@interface MyNetManager ()

@property (strong, nonatomic) NSOperationQueue *queue;

@end


@implementation MyNetManager

// в каждой функции чего-то не хватает
+ (instancetype)sharedInstance
{
    static dispatch_once_t predicate;
    __strong static MyNetManager *instance;
    dispatch_once(&predicate, ^(){
        instance = [[MyNetManager alloc] init];
        instance.queue = [NSOperationQueue new];
        instance.queue.maxConcurrentOperationCount = 1;
    });
    return instance;
}

- (void)getAsyncImagesInfo:(void(^)(NSArray* imagesInfo))completion
{
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/ListImages.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data)
        {
            NSArray *obj = [NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
            completion(obj);
        }
        else
        {
            NSLog(@"No data at images info");
        }
    }];
}

- (void)getAsyncImageWithURL:(NSURL*)url completion:(void(^)(UIImage* image))completion
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data)
        {
            UIImage *image = [UIImage imageWithData:data];
            completion(image);
        }
        else
        {
            NSLog(@"You did something wrong\n(URL: %@)", url);
        }
    }];
}

@end
