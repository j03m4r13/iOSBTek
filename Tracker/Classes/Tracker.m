
#import "Tracker.h"
#import <Cordova/CDV.h>

#define MAXIMUM_AGE 15     //secs
#define SLEEP_TIME   5     //secs

@implementation Tracker
@synthesize locationManager = _locationManager;
static BOOL gpsRunning;

+(BOOL)isGPSRunning{
    return gpsRunning;
}

// the Cordova's init method
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
    if (abs(howRecent) < MAXIMUM_AGE) {
        
            NSLog(@"Location Update: latitude %+.6f, longitude %+.6f, horacc, %.6f\n",
                  location.coordinate.latitude,
                  location.coordinate.longitude,
                  location.horizontalAccuracy);
            gpsRunning = NO;
            NSLog(@"Location updates stopped..\n");
            [manager stopUpdatingLocation];
            [NSThread sleepForTimeInterval: SLEEP_TIME]; // in secs
            NSLog(@"Location updates started..\n");
            [manager startUpdatingLocation];
        
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



/**
 *  Background handler.. This gets called by Phonegap when app is put into background..
 */

//TODO: error handler
- (void)pause:(CDVInvokedUrlCommand*)command{
    [self.commandDelegate runInBackground:^{
            CDVPluginResult* pluginResult = nil;

            if([CLLocationManager locationServicesEnabled]){
                NSLog(@"Running Location Manager in Background..");
                [self.locationManager startUpdatingLocation];
                gpsRunning = YES;
            }
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Good"];
            
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end
