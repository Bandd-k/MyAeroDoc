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
#define URL_AERODOC @"http://192.168.0.104:8080/aerodoc/"
#define URL_UNIFIED_PUSH @"https://push-deniskaprenko.rhcloud.com/ag-push/"
#define VARIANT_ID @"76a2fc33-efbb-4e71-9271-231fb85981c4"
#define VARIANT_SECRET @"fc64a8e5-32c2-42e8-9778-125062cbc835"

#define ENDPOINT @"rest"
#import "AGPipe.h"
#import "AeroGearPush.h"
#import "AeroGear.h"
#endif
