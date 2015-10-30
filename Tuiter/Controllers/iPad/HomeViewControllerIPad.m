//
//  HomeViewControllerIPad.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/29/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "HomeViewControllerIPad.h"

@interface HomeViewControllerIPad ()

@end

#define TWITTER_LOGO_TOP_PADDING 165.0f

#define SEARCH_BAR_BOTTOM_PADDING 198.0f
#define SEARCH_BAR_LANDSCAPE_PADDING 140.0f

#define SEARCH_FIELD_MIN_WIDTH 320.0f
#define SEARCH_FIELD_PADDING 110.0f

@implementation HomeViewControllerIPad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self isOnLandscape]) {
        self.recentSearchesView.alpha = 0;
        self.trendingNowView.alpha = 0;
        self.recentSearchesView.hidden = true;
        self.trendingNowView.hidden = true;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    if (self.isOnEditingMode) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.searchBarBottomConstraint.constant = (self.view.frame.size.width / 2)  - self.searchBar.frame.size.height;
            
            if (![self isOnLandscape]) {
                self.twitterLogoTopConstraint.constant = self.twitterIcon.frame.origin.y - SEARCH_BAR_LANDSCAPE_PADDING;
                self.searchBarBottomConstraint.constant += SEARCH_BAR_LANDSCAPE_PADDING;
            } else {
                self.twitterLogoTopConstraint.constant = self.twitterIcon.frame.origin.y + SEARCH_BAR_LANDSCAPE_PADDING;
            }
            
            self.twitterIcon.frame = CGRectMake(self.twitterIcon.frame.origin.x, self.twitterLogoTopConstraint.constant, self.twitterIcon.frame.size.width, self.twitterIcon.frame.size.height);
            self.searchFieldWidthConstraint.constant = self.view.frame.size.height - SEARCH_FIELD_PADDING;
            
            self.searchField.frame = CGRectMake(SEARCH_FIELD_PADDING/2, self.searchField.frame.origin.y, self.searchFieldWidthConstraint.constant, self.searchField.frame.size.height);
            self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x, (self.view.frame.size.width / 2), self.searchBar.frame.size.width, self.searchBar.frame.size.height);
            
        } completion:nil];
    } else {
        if ([self isOnLandscape])
            [self showRecentSearchesAndTrending];
        else
            [self hideRecentSearchesAndTrending];
    }
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}



-(void) enterEditingModeOnLandscape:(BOOL)landscape {
    self.searchField.textAlignment = NSTextAlignmentLeft;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.recentSearchesView.alpha = 0;
        self.trendingNowView.alpha = 0;
        
        
        self.searchBarBottomConstraint.constant = (self.view.frame.size.height / 2)  - self.searchBar.frame.size.height;
        
        if(landscape) {
            self.twitterLogoTopConstraint.constant = self.twitterIcon.frame.origin.y - SEARCH_BAR_LANDSCAPE_PADDING;
            self.twitterIcon.frame = CGRectMake(self.twitterIcon.frame.origin.x, self.twitterLogoTopConstraint.constant, self.twitterIcon.frame.size.width, self.twitterIcon.frame.size.height);
            self.searchBarBottomConstraint.constant += SEARCH_BAR_LANDSCAPE_PADDING;
        }
        self.searchFieldWidthConstraint.constant = self.view.frame.size.width - SEARCH_FIELD_PADDING;
        
        self.searchField.frame = CGRectMake(SEARCH_FIELD_PADDING/2, self.searchField.frame.origin.y, self.searchFieldWidthConstraint.constant, self.searchField.frame.size.height);
        self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x, (self.view.frame.size.height / 2), self.searchBar.frame.size.width, self.searchBar.frame.size.height);
        
    } completion:nil];
}

-(void) showRecentSearchesAndTrending{
    self.recentSearchesView.hidden = false;
    self.trendingNowView.hidden = false;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.recentSearchesView.alpha = 1;
        self.trendingNowView.alpha = 1;
    } completion:nil];
    
    
}

-(void) hideRecentSearchesAndTrending {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.recentSearchesView.alpha = 0;
        self.trendingNowView.alpha = 0;
    } completion:^(BOOL success) {
        self.recentSearchesView.hidden = true;
        self.trendingNowView.hidden = true;
    }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [super textFieldDidBeginEditing:textField];
    [self enterEditingModeOnLandscape:[self isOnLandscape]];
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    float alpha = 1;
    if([self isOnLandscape])
        alpha = 0;

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.recentSearchesView.alpha = alpha;
        self.trendingNowView.alpha = alpha;
        self.twitterIcon.frame = CGRectMake(self.twitterIcon.frame.origin.x, TWITTER_LOGO_TOP_PADDING, self.twitterIcon.frame.size.width, self.twitterIcon.frame.size.height);
        self.twitterLogoTopConstraint.constant = TWITTER_LOGO_TOP_PADDING;
        self.searchBarBottomConstraint.constant = SEARCH_BAR_BOTTOM_PADDING;
        self.searchFieldWidthConstraint.constant = SEARCH_FIELD_MIN_WIDTH;
        self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x, self.view.frame.size.height - (self.searchBar.frame.size.height + SEARCH_BAR_BOTTOM_PADDING), self.searchBar.frame.size.width, self.searchBar.frame.size.height);
    } completion:^(BOOL success) {
        self.recentSearchesView.hidden = alpha == 0;
        self.trendingNowView.hidden = alpha == 0;
    }];
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
