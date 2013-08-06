
#import "GpsMQTTHandler.h"

@implementation GpsMQTTHandler

- (id) init {
    self = [super init];
    if (self != nil) {
		sensorType = nil; //ProfileMgr.GPS_SENSOR;
		handlerType = nil; //ProfileMgr.GPS_MQTT_HANDLER;
    }
    return self;
}

-(NSString*)getServer{
    return server;
}


-(void)setServer:(NSString*)serv{
    self.server = serv;
}


-(long)getPort{
    return port;
}


-(void)setPort:(long)thePort{
    self.port = thePort;
}


-(NSString*)getUsername{
    return username;
}


-(void)setUsername:(NSString*)user{
    self.username = user;
}


-(void)setPassword:(NSString*)pass{
    self.password = pass;
}


-(NSString*)getTopic{
    return topic;
}


-(void)setTopic:(NSString*)theTopic{
    self.topic = theTopic;
}


-(BOOL)processHandlerConfig:(NSString*)handlerStr{
    @try {
        NSError *error;
        NSData *handler = [handlerStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *schedulesArr = [NSJSONSerialization JSONObjectWithData:handler options:kNilOptions error: &error];
        
        id value = [schedulesArr objectForKey:@"settings"];
        
        self.server = [value objectForKey:@"server"];
        self.port = [[value objectForKey:@"port"] longValue];
        
        self.username = [value objectForKey:@"username"];
        self.password = [value objectForKey:@"password"];
        self.topic = [value objectForKey:@"topic"];
        
    }
    @catch (NSException *ex) {
        NSLog(@"processHandlerconfig exception");
        return false;
    }		
    
    return true;
    
}
/*
 * Handle a Location event
 * @param location The event to handle
 * @return true if the event was processed, false otherwise
@Override
public boolean HandleEvent(Context ctx, Location location) {
    
    if (DEBUG) {
        Log.d(TAG, "Handling " + location.getProvider() + " location event");
    }
    
    GpsSensorProfile profile = (GpsSensorProfile)this.sensorProfile;
    
    if (location.hasAccuracy()) {
		
        if (location.getProvider().equalsIgnoreCase("gps")) {
			
            if (location.getAccuracy() <= profile.getGpsAccuracyThreshold()) {
                BroadcastMQTTLocation(ctx, location);
            }
            else {
                if (DEBUG) {
                    Log.d(TAG, "GPS location discarded, not accurate enough " + location.getAccuracy() + " > " + profile.getGpsAccuracyThreshold());
                }
            }
        }
        
        else if (location.getProvider().equalsIgnoreCase("network")) {
            
            if (location.getAccuracy() <= profile.getNetworkAccuracyThreshold()) {
                BroadcastMQTTLocation(ctx, location);
            }
            else {
                if (DEBUG) {
                    Log.d(TAG, "Network location discarded, not accurate enough " + location.getAccuracy() + " > " + profile.getNetworkAccuracyThreshold());
                }
            }
            
        } else {
            if (DEBUG) {
                Log.e(TAG, "Unknown location provider : " + location.getProvider());
            }
        }
    } else {
        if (DEBUG) {
            Log.e(TAG, "Location discared, no accuracy info");
        }
    }
    
    return true;
}
*/
@end
