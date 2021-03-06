//
//  ParkedViewController.h
//  Parked
//
//  Created by Christopher Baltzer on 10-12-07.
//  Copyright 2010 Christopher Baltzer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ParkedAnnotation.h"

@interface ParkedViewController : UIViewController <MKMapViewDelegate, UITextFieldDelegate> {
	MKMapView *map;
	UIDatePicker *picker; 
	UIBarButtonItem *parkButton;
	UIBarButtonItem *parkButtonWithNote;
	UIBarButtonItem *timerButton;
	UIToolbar *toolbar;
	
	BOOL initialZoom;
	BOOL pickerVisible;
	NSString *notation;
	
}

@property (nonatomic, retain) IBOutlet MKMapView *map;
@property (nonatomic, retain) IBOutlet UIDatePicker *picker;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *parkButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *parkButtonWithNote;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *timerButton;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, assign) BOOL initialZoom;
@property (nonatomic, assign) BOOL pickerVisible;
@property (nonatomic, retain) NSString *notation;


-(IBAction) park;
-(IBAction) parkWithNote;
-(void) scheduleNotification;
-(void) showNotification;
-(IBAction) showTimePicker;
-(void) cleanMap;
-(void)addPinAtCoordsLat:(float)latitude Long:(float)longitude;
-(void)addPinAtCoords:(CLLocationCoordinate2D)coordinate;
-(CLLocationCoordinate2D) getUserLocation;


@end

