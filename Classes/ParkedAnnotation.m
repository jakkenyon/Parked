//
//  ParkedAnnotation.m
//  Parked
//
//  Created by Christopher Baltzer on 10-12-07.
//  Copyright 2010 Christopher Baltzer. All rights reserved.
//

#import "ParkedAnnotation.h"


@implementation ParkedAnnotation

@synthesize notation, coordinate;

-(id) initWithCoordinate:(CLLocationCoordinate2D)coord {
	[super init];
	coordinate = coord;
	self.notation = nil;
	return self;
}


-(id) initWithCoordinate:(CLLocationCoordinate2D)coord andNote:(NSString*)note {
	[super init];
	self.coordinate = coord;
	self.notation = note;
	return self;
}

-(NSString*)subtitle {
	if (nil == self.notation) {
		return nil;
	} else {
		return self.notation;
	}

}

-(NSString*)title {
	return @"You parked here!";
}


@end
