//
//  Bridging-Header.h
//  MyAeroDoc
//
//  Created by Denis Karpenko on 21.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

#ifndef MyAeroDoc_Bridging_Header_h
#define MyAeroDoc_Bridging_Header_h

//configs !
#define URL_AERODOC @"http://192.168.1.43:8080/aerodoc/"
#define URL_UNIFIED_PUSH @"https://push-deniskaprenko.rhcloud.com/ag-push/"
#define VARIANT_ID @"73534f67-790c-4d93-860f-ee3d403562d6"
#define VARIANT_SECRET @"b286c8a5-f7e6-4119-b7b8-171b8b15bfb1"
#define ENDPOINT @"rest"

//Imports
#import "AGPipe.h"
#import "AeroGearPush.h"
#import "AeroGear.h"
#import "AGDeviceRegistration.h"
#endif
