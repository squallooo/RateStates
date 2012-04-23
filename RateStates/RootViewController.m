//
//  RootViewController.m
//  RateStates
//
//  Created by amine on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//  114 142 147

#import "RootViewController.h"
#import "RateStatesDoc.h"
#import "RateStatesData.h"
#import "EditViewController.h"


@implementation RootViewController
@synthesize states = _states;
@synthesize editViewController = _editViewController;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"Rate States";
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
											   target:self action:@selector(addTapped:)] autorelease];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}



#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _states.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	RateStatesDoc *doc = [_states objectAtIndex:indexPath.row];
	cell.textLabel.text = doc.data.title;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.imageView.image = doc.thumbImage;
	
	
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		RateStatesDoc *doc = [_states objectAtIndex:indexPath.row];
		[doc deleteDoc];
		[_states removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}



/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if(_editViewController == nil) {
		self.editViewController = [[[EditViewController alloc] initWithNibName:@"EditViewController" bundle:[NSBundle mainBundle]] autorelease];
	}
	RateStatesDoc *doc = [_states objectAtIndex:indexPath.row];
	_editViewController.stateDoc = doc;
	[self.navigationController pushViewController:_editViewController animated:YES];
	
	/*
	 *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}

- (void)addTapped:(id)sender {
	RateStatesDoc	*newDoc = [[[RateStatesDoc alloc] initWithTitle:@"New State" rating:0 thumbImage:nil fullImage:nil]	autorelease];
	[_states addObject:newDoc];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_states.count-1 inSection:0];
	NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
	[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
	
	[self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
	[self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    self.editViewController = nil;
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[_states release];
	_states = nil;
	[_editViewController release];
	_editViewController = nil;
	
    [super dealloc];
}


@end

