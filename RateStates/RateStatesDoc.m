//
//  RateStatesDoc.m
//  RateStates
//
//  Created by amine on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//



#import "RateStatesDoc.h"
#import "RateStatesData.h"
#import "RateStatesDataBase.h"

#define kDataKey	@"Data"
#define kDataFile	@"data.plist"
#define kThumbImageFile @"thumbImage.jpg"
#define kFullImageFile @"fullImage.jpg"

@implementation RateStatesDoc
@synthesize data = _data;
@synthesize thumbImage = _thumbImage;
@synthesize fullImage = _fullImage;
@synthesize docPath = _docPath;

- (id)initWithTitle:(NSString*)title rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage {
    if ((self = [super init])) {
        _data = [[RateStatesData alloc] initWithTitle:title rating:rating];
        _thumbImage = [thumbImage retain];
        _fullImage = [fullImage retain];
    }
    return self;
}

- (void)dealloc {
    [_data release];
    _data = nil;
    [_fullImage release];
    _fullImage = nil;
    [_thumbImage release];
    _thumbImage = nil;
    [_docPath release];
	_docPath = nil;
    [super dealloc];
}

- (id)init {
	if ((self = [super init])) {
	}
	return self;
}

- (id)initWithDocPath:(NSString *)docPath {
	if ((self = [super init])) {
		_docPath = [docPath copy];
	}
	return self;
}

- (BOOL)createDataPath {
	if (_docPath == nil) {
		self.docPath = [RateStatesDataBase nextRateStatesDocPath];
	}
	
	NSError *error;
	BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_docPath withIntermediateDirectories:YES attributes:nil error:&error];
	if (!success) {
		NSLog(@"Error creating data path: %@", [error localizedDescription]);
	}
	return success;
}

- (RateStatesData *)data {
	if (_data != nil) return _data;
	
	NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
	NSData *codedData = [[[NSData alloc] initWithContentsOfFile:dataPath] autorelease];
	
	if (codedData == nil) return nil;
	
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
	_data = [[unarchiver decodeObjectForKey:kDataKey] retain];
	[unarchiver finishDecoding];
	[unarchiver release];
	
	return _data;
}

- (void)saveData {
	
	if (_data == nil) return;
	
	[self createDataPath];
	
	NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:_data forKey:kDataKey];
	[archiver finishEncoding];
	[data writeToFile:dataPath atomically:YES];
	[archiver release];
	[data release];
}

- (void)deleteDoc {
	
	NSError *error;
	BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_docPath error:&error];
	if (!success) {
		NSLog(@"Error removing document path: %@", error.localizedDescription);
	}
}

- (UIImage *)thumbImage {
	
	if (_thumbImage != nil) return _thumbImage;
	
	NSString *thumbImagePath = [_docPath stringByAppendingPathComponent:kThumbImageFile];
	return [UIImage imageWithContentsOfFile:thumbImagePath];
}

- (UIImage *)fullImage {
	
	if (_fullImage != nil) return _fullImage;
	
	NSString *fullImagePath = [_docPath stringByAppendingPathComponent:kFullImageFile];
	return [UIImage imageWithContentsOfFile:fullImagePath];
}

- (void)saveImages {
	if (_thumbImage == nil || _fullImage == nil) return;
	
	[self createDataPath];
	
	NSString *thumbImagePath = [_docPath stringByAppendingPathComponent:kThumbImageFile];
	NSData *thumbImageData = UIImagePNGRepresentation(_thumbImage);
	[thumbImageData writeToFile:thumbImagePath atomically:YES];
	
	NSString *fullImagePath = [_docPath stringByAppendingPathComponent:kFullImageFile];
	NSData *fullImageData = UIImagePNGRepresentation(_fullImage);
	[fullImageData writeToFile:fullImagePath atomically:YES];
	
	self.thumbImage = nil;
	self.fullImage = nil;
}

@end