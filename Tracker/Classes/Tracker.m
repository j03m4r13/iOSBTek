//
//  Tracker.m
//  Tracker
//
//  Created by Joemarie Aliling on 4/19/13.
//
//

#import "Tracker.h"
#import <Cordova/CDV.h>

@implementation Tracker
@synthesize locationManager = _locationManager;
static BOOL gpsRunning;

+(BOOL)isGPSRunning{
    return gpsRunning;
}
-(void)pluginInitialize
{
        if(self.locationManager == nil){
            _locationManager=[[CLLocationManager alloc] init];
            _locationManager.distanceFilter = kCLDistanceFilterNone;
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            _locationManager.delegate = self;
            self.locationManager = _locationManager;
            NSLog(@"Location Manager Initialized..");
        }
        
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        if(location.horizontalAccuracy < 35.0){
            
            NSLog(@"Location Update: latitude %+.6f, longitude %+.6f, horacc, %.6f\n",
                  location.coordinate.latitude,
                  location.coordinate.longitude,
                  location.horizontalAccuracy);
            gpsRunning = NO;
            NSLog(@"Location updates stopped..\n");
            [manager stopUpdatingLocation];
            [NSThread sleepForTimeInterval: 5]; // 60 secs rest 1 min
            NSLog(@"Location updates started..\n");
            [manager startUpdatingLocation];
        }
        
    }
}

/**
 *  Starts the Location Manager
 */

//TODO: error handler
- (void)start:(CDVInvokedUrlCommand*)command{
    CDVPluginResult* pluginResult = nil;
        if([CLLocationManager locationServicesEnabled]){
            NSLog(@"Starting Location Manager..");
            [self.locationManager startUpdatingLocation];
            gpsRunning = YES;
        }
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Good"];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

/*
- (void)echo:(CDVInvokedUrlCommand*)command{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];
    
    if (echo != nil && [echo length] > 0) {
        if([CLLocationManager locationServicesEnabled]){
            [self.locationManager startUpdatingLocation];
            gpsRunning = YES;
        }
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
*/
@end
