//
// Created by ASPCartman on 09/02/15.
// Copyright (c) 2015 ASPCartman. All rights reserved.
//

#import "NSString+CString.h"

@implementation NSString (CString)
+ (NSString*) stringWithCStringU8:(const char *)cstring
{
	return [NSString stringWithCString:cstring encoding:NSUTF8StringEncoding];
}

- (const char *) cStringU8
{
	return [self cStringUsingEncoding:NSUTF8StringEncoding];
}
@end