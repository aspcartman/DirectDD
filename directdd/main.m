//
//  main.m
//  directdd
//
//  Created by ASPCartman on 09/02/15.
//  Copyright (c) 2015 ASPCartman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASPDD.h"
#import "NSString+CString.h"

NSMutableDictionary *parseArgs(int argc, char const *argv[]);

int main(int argc, const char *argv[])
{
	NSMutableDictionary *args = parseArgs(argc, argv);

	ASPDD *dd = [ASPDD new];
	[dd executeWithInputPath:args[@"if"] ? : @"/dev/zero"
				  outputPath:args[@"of"] ? : @"/dev/null"
				   blockSize:(NSUInteger) ([args[@"bs"] integerValue] ? : 4096)
					   count:(NSUInteger) [args[@"count"] integerValue] ? : 10];

	return 0;
}

NSMutableDictionary *parseArgs(int argc, char const *argv[])
{
	NSMutableDictionary *args = [NSMutableDictionary new];
	for (int            i     = 1; i < argc; ++i)
	{
		NSString *arg      = [NSString stringWithCStringU8:argv[i]];
		NSArray  *splitted = [arg componentsSeparatedByString:@"="];
		args[splitted[0]] = splitted[1];
	}
	return args;
}