//
//  MyNetManager.h
//  HW_NetExample
//
//  Created by Alexander on 12.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyNetManager : NSObject

+ (instancetype)sharedInstance;

- (void)getAsyncImagesInfo:(void(^)(NSArray* imagesInfo))complection;

- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection;
- (void)getImageAsyncInScroll:(UIScrollView *)scroll byUrl:(NSURL *)imgURL InThread:(dispatch_queue_t)downloadThread IfNonStop:(BOOL)stop AtIndexI:(int)i AndJ:(int)j;

@end
