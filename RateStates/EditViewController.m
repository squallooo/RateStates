//
//  EditViewController.m
//  RateStates
//
//  Created by amine on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"
#import "RateStatesData.h"
#import "RateStatesDoc.h"
#import "UIImageExtras.h"
#import "DSActivityView.h"

@implementation EditViewController

@synthesize stateDoc = _stateDoc;
@synthesize titleField = _titleField;
@synthesize imageView = _imageView;
@synthesize picker = _picker;
@synthesize rateView = _rateView;
@synthesize activityView, queue;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	_rateView.notSelectedImage = [UIImage imageNamed:@"emptystar.png"];
	_rateView.halfSelectedImage = [UIImage imageNamed:@"emptystar.png"];
	_rateView.fullSelectedImage = [UIImage imageNamed:@"fullstar.png"];
	_rateView.editable = YES;
	_rateView.maxRating = 5;
	_rateView.delegate = self;
	
	self.queue = [[[NSOperationQueue alloc] init] autorelease];
	
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
	_titleField.text = _stateDoc.data.title;
	_rateView.rating = _stateDoc.data.rating;
	_imageView.image = _stateDoc.fullImage;
	[super viewWillAppear:animated];
}

-(IBAction)titleFieldValueChanged:(id)sender{
	_stateDoc.data.title = _titleField.text;
	[_stateDoc saveData];
}

#pragma mark UITextFieldDelegate


// This gets rid of the keyboard when return is pressed
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark RateViewDelegate

-(void)rateView:(RateView*)rateView ratingDidChange:(float)rating{
	_stateDoc.data.rating = rating;
	[_stateDoc saveData];
}

-(IBAction)addPictureTapped:(id)sender{
	if(_picker == nil){
		[DSBezelActivityView newActivityViewForView:self.navigationController.navigationBar.superview withLabel:@"Loading Image Picker..." width:160];
		[queue addOperationWithBlock:^{
			self.picker = [[UIImagePickerController alloc] init];
			_picker.delegate = self;
			_picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			_picker.allowsEditing = NO;	
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				[DSBezelActivityView removeViewAnimated:YES];
				[self.navigationController presentModalViewController:_picker animated:YES];
			}];
		}];
		
	} else {
		[self.navigationController presentModalViewController:_picker animated:YES];
	}
}

#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info{
	[self dismissModalViewControllerAnimated:YES];
	
	[DSBezelActivityView newActivityViewForView:self.navigationController.navigationBar.superview withLabel:@"Resizing image..." width:160];
	[queue addOperationWithBlock:^{
		UIImage *fullImage = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
		UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(44,44)];
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{
			_stateDoc.fullImage = fullImage;
			_stateDoc.thumbImage = thumbImage;
			_imageView.image = fullImage;
			[_stateDoc saveImages];
			[DSBezelActivityView removeViewAnimated:YES];
		}];	
	}];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	self.picker = nil;
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.titleField = nil;
	self.imageView = nil;
	self.rateView = nil;
	self.queue = nil;
}


- (void)dealloc {
	[_stateDoc release];
	_stateDoc = nil;
	[_titleField release];
	_titleField = nil;
	[_imageView release];
	_imageView = nil;
	[_rateView release];
	_rateView = nil;
	[_picker release];
	_picker = nil;
	[queue release];
	queue = nil;
    [super dealloc];
}


@end
