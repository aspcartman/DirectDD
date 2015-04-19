//
// Created by ASPCartman on 09/02/15.
// Copyright (c) 2015 ASPCartman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASPDD : NSObject
- (void) executeWithInputPath:(NSString *)inputPath outputPath:(NSString *)outputPath blockSize:(NSUInteger)blockSize count:(NSUInteger)count;
@end