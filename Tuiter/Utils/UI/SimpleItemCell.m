//
//  SimpleItemCell.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "SimpleItemCell.h"
#import "ColorUtils.h"

@implementation SimpleItemCell

-(NSString *)reuseIdentifier {
    return @"SimpleItemCell";
}

-(void)awakeFromNib {
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    UIColor *newColor =  [ColorUtils darkGray];
    if(highlighted)
        newColor = [ColorUtils lightBlue];
    
    self.title.textColor = newColor;
}
@end
