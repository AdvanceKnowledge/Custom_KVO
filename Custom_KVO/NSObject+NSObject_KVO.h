//
//  NSObject+NSObject_KVO.h
//  Custom_KVO
//
//  Created by 王延磊 on 2018/11/8.
//  Copyright © 2018 追@寻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSObject_KVO)
- (void)custom_KVO:(NSObject *_Nullable)Observer forKeyPath:(NSString *_Nonnull)keyPath options: (NSKeyValueObservingOptions)options context:(nullable void *)context block:(void (^_Nullable)(id _Nullable objc1, NSDictionary * _Nullable objc2))block;


//- (void)custom_KVO2forKeyPath:(NSString *_Nonnull)keyPath block:(void (^_Nullable)(id _Nullable objc1, NSDictionary * _Nullable objc2))block;
@end
