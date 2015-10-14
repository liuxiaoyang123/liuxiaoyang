//
//  GetDataTools.m
//  music123
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "GetDataTools.h"
static GetDataTools *data = nil;
@implementation GetDataTools

+ (instancetype)shareMusicData
{
    if (data == nil) {
        static dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            data = [[GetDataTools alloc]init];
        });
    }
    return data;
}

- (void)getModelWithURL:(NSString *)URL PassValue:(PassValue)passValue
{
    
    dispatch_queue_t glob_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(glob_t, ^{
         self.dataArr = [NSMutableArray array];
    NSArray *arr = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:URL]];
    for (NSDictionary *dict in arr) {
        Music *m = [[Music alloc]init];
        [m setValuesForKeysWithDictionary:dict];
        [self.dataArr addObject:m];
    }
    passValue(self.dataArr);

    });
    
}

- (Music *)getModelWithIndex:(NSInteger)index
{
    return self.dataArr[index];
}


@end
