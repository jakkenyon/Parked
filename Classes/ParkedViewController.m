//
//  ParkedViewController.m
//  Parked
//
//  Created by Christopher Baltzer on 10-12-07.
//  Copyright 2010 Christopher Baltzer. All rights reserved.
//

#import "ParkedViewController.h"

@implementation ParkedViewController

@synthesize map, parkButton, parkButtonWithNote;
@synthesize initialZoom, notation;

-(void) viewDidLoad {
	[super viewDidLoad];
	self.initialZoom = YES;
	
	BOOL parkStored = [[NSUserDefaults standardUserDefaults] boolForKey:@"parkStored"];
	if (parkStored) {
		float lat = [[NSUserDefaults standardUserDefaults] floatForKey:@"storedLat"];
		float lon = [[NSUserDefaults standardUserDefaults] floatForKey:@"storedLon"];
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"parkStored"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		self.notation = [[NSUserDefaults standardUserDefaults] stringForKey:@"storedNote"];
		[self addPinAtCoordsLat:lat Long:lon];
	}
	
}

-(IBAction) park {
	[self addPinAtCoords:[self getUserLocation]];
}


-(IBAction) parkWithNote {
	UIAlertView *noteAlert = [[UIAlertView alloc] initWithTitle:@"Add a note" 
														message:@"\n"
														delegate:self 
											  cancelButtonTitle:NSLocalizedString(@"Park!",nil)
											  otherButtonTitles:nil];
	
	UITextField *noteField = [[UITextField alloc] initWithFrame:CGRectMake(16, 43, 252, 25)];
	noteField.borderStyle = UITextBorderStyleRoundedRect;
	noteField.keyboardAppearance = UIKeyboardAppearanceAlert;
	noteField.delegate = self;
	[noteField becomeFirstResponder];
	[noteAlert addSubview:noteField];
	
	//[noteAlert setTransform:CGAffineTransformMakeTranslation(0, 109)];
	[noteAlert show];
	[noteAlert release];
	[noteField autorelease];
	
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	self.notation = textField.text;
	[self addPinAtCoords:[self getUserLocation]];
}

- (BOOL)textFieldShouldReturn:(UITextField*)theTextField {
    return YES;
}

-(void)addPinAtCoordsLat:(float)latitude Long:(float)longitude {
	CLLocationCoordinate2D parkLoc = CLLocationCoordinate2DMake((CLLocationDegrees)latitude, (CLLocationDegrees)longitude);
	[self addPinAtCoords:parkLoc];
}

-(void)addPinAtCoords:(CLLocationCoordinate2D)coordinate {
	ParkedAnnotation *parked = [[[ParkedAnnotation alloc] initWithCoordinate:coordinate] autorelease];
	
	if (nil != self.notation) {
		parked.notation = self.notation;
		[[NSUserDefaults standardUserDefaults] setValue:self.notation forKey:@"storedNote"];
	}
	
	[self.map removeAnnotations:[self.map annotations]];
	[self.map addAnnotation:parked];
	
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"parkStored"];
	[[NSUserDefaults standardUserDefaults] setFloat:coordinate.latitude forKey:@"storedLat"];
	[[NSUserDefaults standardUserDefaults] setFloat:coordinate.longitude forKey:@"storedLon"];
	[[NSUserDefaults standardUserDefaults] synchronize];

}


-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[MKUserLocation class]]) {
		return nil;
	} else {
		
		MKPinAnnotationView *pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"parkingident"] autorelease];
		pin.animatesDrop = YES;
		pin.canShowCallout = YES;
		
		return pin;
	}
	
	return nil;
}

-(void)mapView:(MKMapView*)mapView didUpdateUserLocation:(MKUserLocation*)userLocation {
	if (initialZoom) {
		CLLocationCoordinate2D userLoc = [self getUserLocation];
		[self.map setCenterCoordinate:userLoc animated:YES];
		MKCoordinateRegion userRegion = MKCoordinateRegionMakeWithDistance(userLoc, 1000, 1000);
		[self.map setRegion:userRegion animated:YES];
		self.initialZoom = NO;
	}
}

-(CLLocationCoordinate2D) getUserLocation {
	CLLocationCoordinate2D userLoc;
# if TARGET_IPHONE_SIMULATOR
	NSLog(@"Forcing user location to Halifax for simulator");
	userLoc = CLLocationCoordinate2DMake(44.63750734, -63.58743652);
# else
	NSLog(@"Finding user location");
	userLoc = self.map.userLocation.location.coordinate;
# endif
	return userLoc;
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
