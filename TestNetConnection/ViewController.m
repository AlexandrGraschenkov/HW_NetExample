//
//  ViewController.m
//  TestNetConnection
//
//  Created by Alexander on 10.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSOperationQueue *queue;
}
@property (nonatomic, weak) IBOutlet UITextField *loginField;
@property (nonatomic, weak) IBOutlet UITextField *passField;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    queue = [NSOperationQueue new];
}

- (IBAction)loginPressed:(id)sender
{
    NSString *login = self.loginField.text;
    NSString *pass = self.passField.text;
    
    NSURL *url = [NSURL URLWithString:@"http://school-test.bars-open.ru/rest/login"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST"; // GET, DELETE, PUT
    
    NSDictionary *params = @{@"login" : login, @"password" : pass};
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    request.HTTPBody = data;
    
    [self sendRequest2:request];
}

- (void)sendRequest:(NSURLRequest*)request
{
    NSURLResponse *resp;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:nil];
    id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@", resp.MIMEType);
    NSLog(@"%@", obj);
}

- (void)sendRequest2:(NSURLRequest*)request
{
    NSURLResponse *resp;
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         NSLog(@"%@", resp.MIMEType);
         NSLog(@"%@", obj);
    }];
}

- (IBAction)getImageAction:(UIButton*)butt
{
    NSURL *url = [NSURL URLWithString:@"http://sciencelakes.com/data_images/out/6/8786361-nature-desktop-pictures.jpg"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSLog(@"%@", cookies);
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgView.image = [UIImage imageWithData:data];
        });
    }];
}

- (void)setImage:(UIImage*)img
{
    self.imgView.image = img;
}

@end
