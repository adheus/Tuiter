//
//  ResultsViewControllerIPhone.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/29/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "ResultsViewControllerIPhone.h"
#import "ColorUtils.h"
#import "TwitterStatusCell.h"

@interface ResultsViewControllerIPhone ()

@end

@implementation ResultsViewControllerIPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[ColorUtils lightBlue] normalIcon:[UIImage imageNamed:@"GenericButtonOff"] selectedIcon:[UIImage imageNamed:@"GenericButtonOn"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:[ColorUtils lightBlue] normalIcon:[UIImage imageNamed:@"GenericButtonOff"] selectedIcon:[UIImage imageNamed:@"GenericButtonOn"]];
    
    return leftUtilityButtons;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:[ColorUtils lightBlue] normalIcon:[UIImage imageNamed:@"GenericButtonOff"] selectedIcon:[UIImage imageNamed:@"GenericButtonOn"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[ColorUtils lightBlue] normalIcon:[UIImage imageNamed:@"GenericButtonOff"] selectedIcon:[UIImage imageNamed:@"GenericButtonOn"]];
    
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
        default:
            break;
    }
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    ((UIButton *)[cell.rightUtilityButtons objectAtIndex:index]).selected = !((UIButton *)[cell.rightUtilityButtons objectAtIndex:index]).selected;
    switch (index) {
        case 0:
            NSLog(@"3 button was pressed");
            break;
        case 1:
            NSLog(@"4 button was pressed");
            break;
        default:
            break;
    }

}

// prevent cell(s) from displaying left/right utility buttons
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state {
    return YES;
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
