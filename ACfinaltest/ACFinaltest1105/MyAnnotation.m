//
//  MyAnnotation.m
//  ACFinaltest1105
//
//  Created by 廖崇捷 on 2015/11/5.
//  Copyright © 2015年 Dimo. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;


-(id)initWithCoordinate:(CLLocationCoordinate2D)argCoordinate title:(NSString*)argTitle subtitle:(NSString*)argSubtitle
{
    self = [super init];
    if(self)
    {
        coordinate = argCoordinate;
        title = argTitle;
        subtitle = argSubtitle;
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    
    coordinate = newCoordinate;
}

@end
