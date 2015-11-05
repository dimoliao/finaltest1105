//
//  MyAnnotation.h
//  ACFinaltest1105
//
//  Created by 廖崇捷 on 2015/11/5.
//  Copyright © 2015年 Dimo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>

-(id)initWithCoordinate:(CLLocationCoordinate2D)argCoordinate
                  title:(NSString*)argTitle subtitle:(NSString*)argSubtitle;


@end
