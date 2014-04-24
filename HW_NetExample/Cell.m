//
//  Cell.m
//  HW_NetExample
//
//  Created by Anastasia Tkachenko on 21.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "Cell.h"

@interface Cell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@end


@implementation Cell

-(void)setTitle: (NSString*)title
{
    _name.text = title;
}

@end
