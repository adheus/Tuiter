//
//  HomeViewControllerIPhone.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/29/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "HomeViewControllerIPhone.h"

#define TWITTER_LOGO_TOP_PADDING 165.0f

#define SEARCH_BAR_TOP_PADDING 120.0f
#define SEARCH_BAR_LANDSCAPE_PADDING -20.0f

#define SEARCH_FIELD_MIN_WIDTH 120.0f
#define SEARCH_FIELD_PADDING 16.0f

@interface HomeViewControllerIPhone ()

@end

@implementation HomeViewControllerIPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [super textFieldDidBeginEditing:textField];
    self.searchField.textAlignment = NSTextAlignmentLeft;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.recentSearchesView.hidden = NO;
        self.recentSearchesView.alpha = 1;
        self.trendingNowView.alpha = 0;
        
        
        //self.searchBarBottomConstraint.constant = (self.view.frame.size.height / 2)  - self.searchBar.frame.size.height;
        
        if([self isOnLandscape]) {
            self.twitterIcon.alpha = 0;
            self.searchBarBottomConstraint.constant += SEARCH_BAR_LANDSCAPE_PADDING;
        }
        self.searchFieldWidthConstraint.constant = self.view.frame.size.width - SEARCH_FIELD_PADDING;
        
        self.searchField.frame = CGRectMake(SEARCH_FIELD_PADDING/2, self.searchField.frame.origin.y, self.searchFieldWidthConstraint.constant, self.searchField.frame.size.height);
        
    } completion:nil];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.recentSearchesView.alpha = 0;
        self.trendingNowView.alpha = 1;
        if([self isOnLandscape]) {
            self.twitterIcon.alpha = 1;
        }
        self.searchFieldWidthConstraint.constant = SEARCH_FIELD_MIN_WIDTH;
        self.searchBarBottomConstraint.constant = SEARCH_BAR_TOP_PADDING;
    } completion:nil];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    if ([self isOnLandscape])
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.twitterIcon.alpha = 1;
            self.trendingNowView.alpha = 1;
        } completion:nil];
    else
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.trendingNowView.alpha = 0;
        } completion:nil];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
