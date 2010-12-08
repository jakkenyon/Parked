//
//  ParkedAnnotation.h
//  Parked
//
//  Created by Christopher Baltzer on 10-12-07.
//  Copyright 2010 Christopher Baltzer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ParkedAnnotation :NSObject <MKAnnotation> {
	NSString *notation;
	CLLocationCoordinate2D coordinate;
}

@property (nonatomic, retain) NSString *notation;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


-(id) initWithCoordinate:(CLLocationCoordinate2D)coord;
-(id) initWithCoordinate:(CLLocationCoordinate2D)coord andNote:(NSString*)note;
-(NSString*)subtitle;
-(NSString*)title;

@end
