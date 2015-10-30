//
//  ResultsViewController.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "ResultsViewController.h"
#import "TwitterStatusCell.h"
#import "ColorUtils.h"
@implementation ResultsViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.barTintColor = [ColorUtils lightBlue];
    
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavigationBarSearchButton"] style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    closeButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = closeButton;

}

-(void)close {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *statusTableViewCellIdentifier = @"TwitterStatusCell";
    
    TwitterStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:statusTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[TwitterStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:statusTableViewCellIdentifier];
    }
    
    cell.leftUtilityButtons = [self leftButtons];
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
    [cell setTwitterStatus:[self.results objectAtIndex:indexPath.row]];
    
    return cell;
}


- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[ColorUtils lightBlue] normalIcon:[UIImage imageNamed:@"GenericButtonOff"] selectedIcon:[UIImage imageNamed:@"GenericButtonOn"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:[ColorUtils lightBlue] normalIcon:[UIImage imageNamed:@"GenericButtonOff"] selectedIcon:[UIImage imageNamed:@"GenericButtonOn"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:[ColorUtils lightBlue] normalIcon:[UIImage imageNamed:@"GenericButtonOff"] selectedIcon:[UIImage imageNamed:@"GenericButtonOn"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:[ColorUtils lightBlue] normalIcon:[UIImage imageNamed:@"GenericButtonOff"] selectedIcon:[UIImage imageNamed:@"GenericButtonOn"]];
    
    return leftUtilityButtons;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    return rightUtilityButtons;
}


-(void) share:(NSString *) textToShare sourceView:(UIView *)sourceView {
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:textToShare, nil] applicationActivities:nil];
    vc.excludedActivityTypes = @[
                                 UIActivityTypePostToWeibo,
                                 UIActivityTypePrint,
                                 UIActivityTypeCopyToPasteboard,
                                 UIActivityTypeAssignToContact,
                                 UIActivityTypeSaveToCameraRoll,
                                 UIActivityTypeAddToReadingList,
                                 UIActivityTypePostToFlickr,
                                 UIActivityTypePostToVimeo,
                                 UIActivityTypePostToTencentWeibo,
                                 UIActivityTypeAirDrop
                                 ];
    if ( [vc respondsToSelector:@selector(popoverPresentationController)] ) {
        vc.popoverPresentationController.sourceView = sourceView;
        vc.popoverPresentationController.sourceRect = CGRectMake(sourceView.frame.origin.x + sourceView.frame.size.width, sourceView.frame.origin.y + sourceView.frame.size.height/2, 0, 0);
    }
    [self presentViewController:vc animated:YES completion:nil];
}



#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    ((UIButton *)[cell.leftUtilityButtons objectAtIndex:index]).selected = !((UIButton *)[cell.leftUtilityButtons objectAtIndex:index]).selected;
    switch (index) {
        case 0:
            NSLog(@"1 button was pressed");
            [self share: ((TwitterStatusCell *)cell).statusTextLabel.text sourceView:((UIButton *)[cell.leftUtilityButtons objectAtIndex:index])];
            break;
        case 1:
            NSLog(@"2 button was pressed");
            break;
        case 2:
            NSLog(@"3 button was pressed");
            break;
        case 3:
            NSLog(@"4 button was pressed");
        default:
            break;
    }
}

// prevent multiple cells from showing utilty buttons simultaneously
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

// prevent cell(s) from displaying left/right utility buttons
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state {
    return state == kCellStateLeft;
}

@end
