//
//  main.m
//  bright
//
//  Created by TangShi on 14/11/11.
//  Copyright (c) 2014年 TangShi. All rights reserved.
//

#import <Foundation/Foundation.h>

void setBrightness (int level)
{
    // change level from int(0 ~ 100) to float (0 ~ 1)
    float lvl = (float)level / 100;
    
    io_iterator_t iterator;
    kern_return_t result =
    IOServiceGetMatchingServices(kIOMasterPortDefault,
                                 IOServiceMatching("IODisplayConnect"),
                                &iterator);
    
    if (result == kIOReturnSuccess) {
        io_object_t service;
        while ((service = IOIteratorNext(iterator)))
        {
            IODisplaySetFloatParameter(service, kNilOptions, CFSTR(kIODisplayBrightnessKey), lvl);
            
            // Let the object go
            IOObjectRelease(service);
        }
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int lvl;
        if (argc <= 1) {
            printf("bright usage:\n");
            printf("bright [brightness]\n");
            printf("brightness is a integer value between 0 and 100.\n");
            exit(-1);
        }
        else {
            NSString *str = [[NSString alloc] initWithUTF8String:argv[1]];
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            NSNumber *number = [numberFormatter numberFromString:str];
            lvl = [number intValue];
            if (lvl < 0) {
                lvl = 0;
            }
            if (lvl > 100) {
                lvl = 100;
            }
        }
        
        setBrightness(lvl);

    }
    
    return 0;
}

