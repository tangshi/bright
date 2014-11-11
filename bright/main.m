//
//  main.m
//  bright
//
//  Created by TangShi on 14/11/11.
//  Copyright (c) 2014年 TangShi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bright : NSObject

- (void)setBrightnessTo:(int)level;

@end

@implementation Bright

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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int lvl;
        if (argc <= 1) {
            printf("bright needs a integer as argument ranging from 0 to 100.\n");
            printf("since there is no input, the bright value will be set to 0 as default.\n");
            lvl = 0;
        }
        else {
            NSString *str = [[NSString alloc] initWithUTF8String:argv[1]];
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            NSNumber *number = [numberFormatter numberFromString:str];
            lvl = [number intValue];
            if (lvl < 0) {
                printf("The input integer ranges from 0 to 100.\n");
                printf("%d is less than 0 and it will be set to the minimum value, 0.", lvl);
                lvl = 0;
            }
            else if (lvl > 100) {
                printf("The input integer ranges from 0 to 100.\n");
                printf("%d is greater than 100 and it will be set to the maximum value, 100.", lvl);
                lvl = 100;
            }
            
        }
        
        Bright *bright = [[Bright alloc] init];
        [bright setBrightnessTo:lvl];
        
    }
    
    return 0;
}

