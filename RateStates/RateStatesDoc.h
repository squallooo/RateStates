//
//  RateStatesDoc.h
//  RateStates
//
//  Created by amine on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RateStatesData;

@interface RateStatesDoc : NSObject {
    RateStatesData *_data;
    UIImage *_thumbImage;
    UIImage *_fullImage;
    NSString *_docPath;
}

@property (retain) RateStatesData *data;
@property (retain) UIImage *thumbImage;
@property (retain) UIImage *fullImage;
@property (copy) NSString *docPath;

- (id)initWithTitle:(NSString*)title rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage;
- (id)init;
- (id)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;
- (void)saveImages;

@end