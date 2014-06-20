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
  
    static dispatch_once_t onceToken;
    static MyNetManager *manager;
    dispatch_once(&onceToken, ^(){
        manager = [[MyNetManager alloc] init];
        manager.queue = [NSOperationQueue new];
      
    });
    return manager;
}

- (void)getAsyncImagesInfo:(void(^)(NSArray* imagesInfo))complection
{
      NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/NetExample/ListImages.json"];
      NSData *data = [NSData dataWithContentsOfURL:url];
      complection([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
}

- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection
{
 
    
      NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
      [NSURLConnection sendAsynchronousRequest:request queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
          if (data){
             UIImage *image = [UIImage imageWithData:data];
             complection(image);
         }
        
      }];
    };

@end
