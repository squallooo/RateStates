//
//  EditViewController.m
//  RateStates
//
//  Created by amine on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "RateView.h"

@class RateStatesDoc;
@class DSActivityView;

@interface EditViewController : UIViewController <UITextFieldDelegate, RateViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	RateStatesDoc *_stateDoc;
	UITextField *_titleField;
	UIImageView *_imageView;
	RateView *_rateView;
	UIImagePickerController *_picker;
	DSActivityView *_activityView;
	NSOperationQueue *_queue;
}

@property (retain) RateStatesDoc *stateDoc;
@property (retain) IBOutlet UITextField *titleField;
@property (retain) IBOutlet UIImageView *imageView;
@property (retain) IBOutlet RateView *rateView;
@property (retain) UIImagePickerController *picker;
@property (retain) DSActivityView *activityView;
@property (retain) NSOperationQueue *queue;

- (IBAction)titleFieldValueChanged:(id)sender;
- (IBAction)addPictureTapped:(id)sender;

@end
