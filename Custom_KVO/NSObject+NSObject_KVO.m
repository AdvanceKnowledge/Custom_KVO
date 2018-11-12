//
//  NSObject+NSObject_KVO.m
//  Custom_KVO
//
//  Created by 王延磊 on 2018/11/8.
//  Copyright © 2018 追@寻. All rights reserved.
//

#import "NSObject+NSObject_KVO.h"
#import <objc/message.h>
@implementation NSObject (NSObject_KVO)
- (void)custom_KVO:(NSObject *_Nullable)Observer forKeyPath:(NSString *_Nonnull)keyPath options: (NSKeyValueObservingOptions)options context:(nullable void *)context block:(void (^_Nullable)(id _Nullable objc1, NSDictionary * _Nullable objc2))block{
    
    //创建一个子类
    NSString *oldName = NSStringFromClass([self class]);
    NSString *newName = [NSString stringWithFormat:@"KVO_%@",oldName];
    
    //添加类
    Class myClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
    //注册类
    objc_registerClassPair(myClass);
    
    //动态修改self类型
    object_setClass(self, myClass);
    //重写set方法,给myClass添加setName方法
    NSString *selector_name = [NSString stringWithFormat:@"set%@:",[keyPath capitalizedString]];
        SEL method = NSSelectorFromString(selector_name);
    class_addMethod(myClass, method, (IMP)setName, "v@:@");
    //给分类添加一个block属性
    objc_setAssociatedObject(self, @"block", block, OBJC_ASSOCIATION_COPY);
    
}

//OC所有方法都会有两个隐藏参数self与命令
void setName(id self,SEL _cmd,NSString *newName){
    struct objc_super superClass = {self,class_getSuperclass([self class])};
    //修改name属性
    objc_msgSendSuper(&superClass,_cmd,newName);
    //取出全局属性block
    void(^block)(id,NSDictionary *) = objc_getAssociatedObject(self, @"block");
    if (block) {
        block([self superclass],@{@"key":newName});
    }
}






//- (void)custom_KVO2forKeyPath:(NSString *_Nonnull)keyPath block:(void (^_Nullable)(id _Nullable objc1, NSDictionary * _Nullable objc2))block{
//    NSString *selector_name = [NSString stringWithFormat:@"set%@:",[keyPath capitalizedString]];
//    SEL method = NSSelectorFromString(selector_name);
//    Method oldMethod = class_getInstanceMethod([self class], method);
//    Method newMethod = class_getInstanceMethod([self class], @selector(wylAttribute:));
//    method_exchangeImplementations(oldMethod, newMethod);
//    //给分类添加一个block属性
//    objc_setAssociatedObject(self, @"block", block, OBJC_ASSOCIATION_COPY);
//    
//}
//
//- (void)wylAttribute:(NSString *)newValue{
//    [self wylAttribute:newValue];
//    //取出全局属性block
//    void(^block)(id,NSDictionary *) = objc_getAssociatedObject(self, @"block");
//    if (block) {
//        block([self superclass],@{@"key":newValue});
//    }
//}



@end
