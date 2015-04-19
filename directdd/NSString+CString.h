//
// Created by ASPCartman on 09/02/15.
// Copyright (c) 2015 ASPCartman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CString)
+ (NSString*) stringWithCStringU8:(const char *)cstring;
- (const char *) cStringU8;
@end