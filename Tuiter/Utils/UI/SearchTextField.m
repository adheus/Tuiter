//
//  SearchTextField.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField


-(void)awakeFromNib {
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchIcon"]];
    [super awakeFromNib];
}

@end
