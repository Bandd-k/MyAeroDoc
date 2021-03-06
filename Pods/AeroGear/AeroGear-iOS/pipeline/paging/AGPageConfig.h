/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>
#import "AGPageParameterExtractor.h"
#import "AGConfig.h"

/**
 * Represents the public API to configure Paging.
 */
@protocol AGPageConfig <AGConfig>

/**
 * A dictionary containing all the HTTP request parameters and their values,
 * that are passed to the server, used when issuing paging requests.
 *
 * If no "parameter provider" has been provided, the values for
 * limit/offset are used
 */
@property (copy, nonatomic) NSDictionary* parameterProvider;

/**
 * The offset of the first element that should be included in the
 * returned collection (default: 0)
 *
 * If a parameter provider has been given, the offset value is ignored.
 */
@property (copy, nonatomic) NSString* offset;

/**
 * The maximum number of results the server should return (default: 10)
 *
 * If a parameter provider has been given, the limit value is ignored.
 */
@property (strong, nonatomic) NSNumber* limit;

/**
 * Indicates whether paging information (see identifiers) is received
 * from the response 'header', the response 'body' or via RFC 5988 ('webLinking'),
 * which is the default. Other values are ignored and the default is being used.
 *
 * Note: if the pageExtractor option is not set, the library will default to use
 *       an appropriate pagination strategy according to the metadataLocation. If set
 *       this option is not required and is ignored if set. See pageExtraction
 *       configuration property for more information.
 */
@property (copy, nonatomic) NSString* metadataLocation;

/**
 * The next identifier name (default: 'next').
 */
@property (copy, nonatomic) NSString* nextIdentifier;

/**
 * The previous identifier name (default: 'previous').
 */
@property (copy, nonatomic) NSString* previousIdentifier;

/**
 * An extension point to override the default strategies provided by the library. If set,
 * the library will use this strategy to determine server paging. The strategy should
 * conform to the protocol AGPageParameterExtractor.
 *
 * Note: If this config setting is NOT set, the library will default to use an internal
 *       defined paging extractor implementation as defined by the metadataLocation
 *       configuration setting. See AGNSMutableArray+Paging API doc for example usage.
 *       See internal AGPageWebLinkingExtractor, AGPageHeaderExtractor and
 *       AGPageBodyExtractor for example pagination strategies.
 *
 */
@property (strong, nonatomic) id<AGPageParameterExtractor> pageExtractor;

@end
