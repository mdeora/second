//
//  Student.h
//  CoreDataTest
//
//  Created by xubojoy on 15/1/11.
//  Copyright (c) 2015年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Person.h"

@class Teacher;

@interface Student : Person

@property (nonatomic, retain) NSNumber * grade;
@property (nonatomic, retain) NSSet *teachers;
@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addTeachersObject:(Teacher *)value;
- (void)removeTeachersObject:(Teacher *)value;
- (void)addTeachers:(NSSet *)values;
- (void)removeTeachers:(NSSet *)values;

@end
