//
//  Student+CoreDataProperties.m
//  CoreDateNew
//
//  Created by cts on 2018/5/18.
//  Copyright © 2018年 cts. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic age;
@dynamic height;
@dynamic name;
@dynamic number;
@dynamic sex;
@dynamic width;
@dynamic image;

@end
