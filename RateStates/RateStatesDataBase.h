//
//  RateStatesDataBase.h
//  RateStates
//
//  Created by amine on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RateStatesDataBase : NSObject{
    
}

+ (NSMutableArray *)loadRateStatesDocs;
+ (NSString *)nextRateStatesDocPath;
@end
