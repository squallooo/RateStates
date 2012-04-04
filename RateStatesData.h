//
//  RateStatesData.h
//  RateStates
//
//  Created by amine on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RateStatesData : NSObject {
    NSString *_title;
    float _rating;
}
@property (copy) NSString *title;
@property  float rating;

- (id)initWithTitle:(NSString*)title rating:(float)rating;

@end