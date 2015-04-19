//
// Created by ASPCartman on 09/02/15.
// Copyright (c) 2015 ASPCartman. All rights reserved.
//

#import "NSException+Quick.h"

@implementation NSException (Quick)
+ (NSException*) quick:(NSString *)whatHappened
{
	return [NSException exceptionWithName:NSGenericException
								   reason:whatHappened
								 userInfo:nil];
}
@end