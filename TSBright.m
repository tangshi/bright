//
//  TSBright.m
//  bright
//
//  Created by TangShi on 14/11/11.
//  Copyright (c) 2014年 TangShi. All rights reserved.
//

#import "TSBright.h"

@implementation TSBright

- (void)setBrightnessTo:(int)level
{
    // change level from int(0 ~ 100) to float (0 ~ 1)
    float lvl = (float)level / 100;
    
    io_iterator_t iterator;
    kern_return_t result = IOServiceGetMatchingServices(kIOMasterPortDefault,
                                                        IOServiceMatching("IODisplayConnect"),
                                                        &iterator);
    // If we were successful
    if (result == kIOReturnSuccess) {
        io_object_t service;
        while ((service = IOIteratorNext(iterator))) {
            IODisplaySetFloatParameter(service, kNilOptions, CFSTR(kIODisplayBrightnessKey), lvl);
            
            // Let the object go
            IOObjectRelease(service);
            
            return;
        }
    }
}

@end
