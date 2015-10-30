//
//  SearchTextField.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "SearchTextField.h"

#define MARGIN_CONST 20
#define PLACEHOLDER_COLOR [UIColor colorWithRed:0.37 green:0.62 blue:0.79 alpha:1.0]
@implementation SearchTextField


-(void)awakeFromNib {
    self.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchIcon"]];
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, self.font.lineHeight, self.font.lineHeight);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.leftView = imageView;
    [self setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: PLACEHOLDER_COLOR}]];
    [super awakeFromNib];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.leftView.frame.size.width + MARGIN_CONST, bounds.origin.y,
                      bounds.size.width - (self.leftView.frame.size.width + MARGIN_CONST), bounds.size.height);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
