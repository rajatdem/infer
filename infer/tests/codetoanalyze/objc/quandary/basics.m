/*
 * Copyright (c) 2017 - present Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/NSObject.h>

@interface InferTaint : NSObject {
}

+ (NSObject*)source;
+ (void)sink:(NSObject*)param;
+ (void)notASink:(NSObject*)param;
@end

void callSinkDirectBad() {
  NSObject* source = [InferTaint source];
  [InferTaint sink:source];
}

void callSinkOnNonSourceOk() {
  NSObject* source = [NSObject new];
  [InferTaint sink:source];
}

void callNonSinkOnSourceOk() {
  NSObject* source = [InferTaint source];
  [InferTaint notASink:source];
}
