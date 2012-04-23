//
//  RootViewController.h
//  RateStates
//
//  Created by amine on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditViewController;
@interface RootViewController : UITableViewController{
    EditViewController *_editViewController;
    NSMutableArray *_states;
}
@property (retain) NSMutableArray *states;
@property (retain) EditViewController *editViewController;
@end
