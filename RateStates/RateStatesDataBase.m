//
//  RateStatesDataBase.m
//  RateStates
//
//  Created by amine on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RateStatesDataBase.h"
#import "RateStatesDoc.h"

@implementation RateStatesDataBase

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
+ (NSString *)getPrivateDocsDir {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
	
	NSError *error;
	[[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
	
	return documentsDirectory;
}

+ (NSMutableArray *)loadRateStatesDocs {
	
	// Get private docs dir
	NSString *documentsDirectory = [RateStatesDataBase getPrivateDocsDir];
	NSLog(@"Loading states from %@", documentsDirectory);
	
	// Get contents of documents directory
	NSError *error;
	NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
	if (files == nil) {
		NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
		return nil;
	}
	
	// Create RateStatesDoc for each file
	NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count];
	for (NSString *file in files) {
		if ([file.pathExtension compare:@"ratestates" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
			NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
			RateStatesDoc *doc = [[[RateStatesDoc alloc] initWithDocPath:fullPath] autorelease];
			[retval addObject:doc];
		}
	}
	
	return retval;
}

+ (NSString *)nextRateStatesDocPath {
	
	// Get private docs dir
	NSString *documentsDirectory = [RateStatesDataBase getPrivateDocsDir];
	
	// Get contents of documents directory
	NSError *error;
	NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
	if (files == nil) {
		NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
		return nil;
	}
	
	// Search for an available name
	int maxNumber = 0;
	for (NSString *file in files) {
		if([file.pathExtension compare:@"ratestates" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
			NSString *fileName = [file stringByDeletingPathExtension];
			maxNumber = MAX(maxNumber, fileName.intValue);
		}
	}
	
	// Get available name
	NSString *availableName = [NSString stringWithFormat:@"%d.ratestates", maxNumber+1];
	return [documentsDirectory stringByAppendingPathComponent:availableName];
}


@end
