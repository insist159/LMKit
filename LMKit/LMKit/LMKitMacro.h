//
//  LMKitMacro.h
//  LMKit
//
//  Created by lm on 2018/3/1.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <sys/time.h>
#import <pthread.h>

#ifndef LMKitMacro_h
#define LMKitMacro_h

#endif /* LMKitMacro_h */

/**
 在ios开发过程中，有时候会用到第三方的静态库(.a文件)，OC没有为每个函数（或者方法）定义链接符号，它只为每个类创建链接符号。这样当在一个静态库中使用类别来扩展已有类的时候，链接器不知道如何把类原有的方法和类别中的方法整合起来，就会导致你调用类别中的方法时，会出现selector not recognized的错误，从而导致app闪退。使用这段宏定义他可以虚拟新建一个与名字category 相同.h.m 让编译器 编译通过。即可解决上面的问题。
 More info: http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html .
 *******************************************************************************
 Example:
 LMSYNTH_DUMMY_CLASS(classname)
 */
#ifndef LMSYNTH_DUMMY_CLASS
#define LMSYNTH_DUMMY_CLASS(_name_) \
@interface LMSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation LMSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif


/**
 在@implementation作用域中合成动态对象属性。 它允许我们将自定义属性添加到类别中的现有类。
 @param association  ASSIGN / RETAIN / COPY / RETAIN_NONATOMIC / COPY_NONATOMIC
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
 @interface NSObject (LMAdd)
 @property (nonatomic, retain) UIColor *myColor;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (LMAdd)
 LMSYNTH_DYNAMIC_PROPERTY_OBJECT(myColor, setMyColor, RETAIN, UIColor *)
 @end
 */
#ifndef LMSYNTH_DYNAMIC_PROPERTY_OBJECT
#define LMSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

/**
 在@implementation作用域中合成动态c类型属性。
   它允许我们将自定义属性添加到类别中的现有类。
 
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
 @interface NSObject (MyAdd)
 @property (nonatomic, retain) CGPoint myPoint;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (MyAdd)
 LMSYNTH_DYNAMIC_PROPERTY_CTYPE(myPoint, setMyPoint, CGPoint)
 @end
 */
#ifndef LMSYNTH_DYNAMIC_PROPERTY_CTYPE
#define LMSYNTH_DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
_type_ cValue = { 0 }; \
NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
[value getValue:&cValue]; \
return cValue; \
}
#endif

/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

/*
 Create UIColor with a hex string.
 Example: LMColorHex(0xF0F), LMColorHex(66ccff), LMColorHex(#66CCFF88)
 
 Valid format: #RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
 The `#` or "0x" sign is not required.
 */
#ifndef LMColorHex
#define LMColorHex(_hex_)   [UIColor lm_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif
