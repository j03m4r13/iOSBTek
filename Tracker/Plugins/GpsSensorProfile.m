
#import "GpsSensorProfile.h"

@implementation GpsSensorProfile

- (id) init {
    self = [super init];
    if (self != nil) {
		sensorType = nil; //ProfileMgr.GPS_SENSOR;
    }
    return self;
}


-(long)getGpsAccuracyThreshold{
    return gpsAccuracyThreshold;
}


-(void)setGpsAccuracyThreshold:(long)gpsAccuracyThres{
    gpsAccuracyThreshold = gpsAccuracyThres;
}


-(long)getNetworkAccuracyThreshold{
    return networkAccuracyThreshold;
}


-(void)setNetworkAccuracyThreshold:(long)networkAccuracyThres{
    networkAccuracyThreshold = networkAccuracyThres;
}


-(long)getMovementThreshold{
    return movementThreshold;
}


-(void)setMovementThreshold:(long)movementThres{
    movementThreshold = movementThres;
}



-(bool)processSettingsConfig:(NSString *)settingsStr{
    @try{
        NSError *error;
        NSData *settings = [settingsStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *schedulesArr = [NSJSONSerialization JSONObjectWithData:settings options:kNilOptions error: &error];
        
        gpsAccuracyThreshold = [[schedulesArr objectForKey:@"gpsAccuracyThreshold"] longValue];
        networkAccuracyThreshold = [[schedulesArr objectForKey:@"networkAccuracyThreshold"] longValue];
        movementThreshold = [[schedulesArr objectForKey:@"movementThreshold"] longValue];
        
        //gpsAccuracyThreshold = settings.optLong("gpsAccuracyThreshold");
        //networkAccuracyThreshold = settings.optLong("networkAccuracyThreshold");
        //movementThreshold = settings.optLong("movementThreshold");
        
        
    }
    @catch(NSException *ex){
        return false;
    }
    return true;
}


-(bool)processHandlersConfig:(NSString *)handlersStr{
    @try{
        NSError *error;
        NSData *settings = [handlersStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *schedulesArr = [NSJSONSerialization JSONObjectWithData:settings options:kNilOptions error: &error];
        /*
        //Process each handler
        JSONArray handlerObjs = new JSONArray(handlersStr);
        for (int handlerIdx = 0; handlerIdx < handlerObjs.length(); handlerIdx++) {
            
            JSONObject handlerObj = handlerObjs.getJSONObject(handlerIdx);
            String handlerType = handlerObj.optString("type");
            
            //Depending on the type of handler config, add the appropriate gps handler object
            if (handlerType.equalsIgnoreCase("mqtt")) {
                
                GpsMqttHandler handler = new GpsMqttHandler();
                handler.setSensorProfile(this);
                handler.ProcessHandlerConfig(handlerObj.toString());
                handlers.add(handler);
            }
        }
        */
        
    }
    @catch(NSException *ex){
        return false;
    }
    return true;
}


@end
