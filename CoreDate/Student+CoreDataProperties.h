//
//  Student+CoreDataProperties.h
//  CoreDateNew
//
//  Created by cts on 2018/5/18.
//  Copyright © 2018年 cts. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nonatomic) int16_t height;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t number;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nonatomic) int16_t width;
@property (nullable, nonatomic, retain) NSData *image;

@end

NS_ASSUME_NONNULL_END
