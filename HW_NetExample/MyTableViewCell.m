//
//  MyTableViewCell.m
//  HW_NetExample
//
//  Created by Amir Zigangarayev on 17.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation MyTableViewCell

- (void)setText:(NSString *)text
{
    _label.text = text;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
