//
// Created by ASPCartman on 09/02/15.
// Copyright (c) 2015 ASPCartman. All rights reserved.
//

#import "ASPDD.h"
#import "NSString+CString.h"
#import <sys/time.h>

static void SmartPError(BOOL condition, NSString *format, ...)
{
	if (condition == 0)
	{
		va_list args;
		va_start(args, format);
		NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
		va_end(args);
		perror(string.cStringU8);
		@throw [NSException new];
	}
}

static double currentTime()
{
	struct timeval tv;
	struct timezone tz;
	gettimeofday(&tv,&tz);
	double res = 0;
	res += tv.tv_sec;
	res += tv.tv_usec / 1000000.0;
	return res;
}

@implementation ASPDD

- (void) executeWithInputPath:(NSString *)inputPath outputPath:(NSString *)outputPath blockSize:(NSUInteger)blockSize count:(NSUInteger)count
{
	NSParameterAssert(inputPath);
	NSParameterAssert(outputPath);
	NSParameterAssert(blockSize);

	int inputFD  = [self open:inputPath withFlags:O_RDONLY];
	int outputFD = [self open:outputPath withFlags:O_WRONLY];

	double start = currentTime();
	NSUInteger bytes = [self transfer:inputFD to:outputFD blockSize:blockSize count:count ? : ~count];
	double seconds = currentTime() - start;

	NSLog(@"Total: %@", [NSByteCountFormatter stringFromByteCount:(long long int) bytes countStyle:NSByteCountFormatterCountStyleFile]);
	NSLog(@"Time: %.4f s", seconds);
	NSLog(@"Speed: %@/s", [NSByteCountFormatter stringFromByteCount:(long long int) (bytes / seconds) countStyle:NSByteCountFormatterCountStyleFile]);
}


- (int) open:(NSString *)path withFlags:(int)flags
{
	int fd = open(path.cStringU8, flags);
	SmartPError(fd != -1, @"Can't open %@", path);

	int res = fcntl(fd, F_NOCACHE, 1);
	SmartPError(res != -1, @"Can't set F_NOCACHE for %@", path);
	return fd;
}

- (NSUInteger) transfer:(int)in to:(int)out blockSize:(NSUInteger)bs count:(NSUInteger)blocksToTransfer
{
	uint8      *buffer          = valloc(bs);
	ssize_t    currentCount;
	NSUInteger blocksTransfered = 0;
	NSUInteger bytesTransfered = 0;
	while ((currentCount = read(in, buffer, bs)) > 0 && (blocksTransfered < blocksToTransfer))
	{
		ssize_t res = write(out, buffer, (size_t) currentCount);
		SmartPError(res == currentCount, @"Error writing data");

		blocksTransfered += 1;
		bytesTransfered += currentCount;
	}
	SmartPError(currentCount > 0, @"Error transferring data");
	return bytesTransfered;
}
@end