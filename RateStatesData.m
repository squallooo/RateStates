//
//  RateStatesData.m
//  RateStates
//
//  Created by amine on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "RateStatesData.h"

@implementation RateStatesData
@synthesize title = _title;
@synthesize rating = _rating;

- (id)initWithTitle:(NSString*)title rating:(float)rating {
    if ((self = [super init])) {
        _title = [title copy];
        _rating = rating;
    }
    return self;
}

- (void)dealloc {
    [_title release];
    _title = nil;
    [super dealloc];
}

@end