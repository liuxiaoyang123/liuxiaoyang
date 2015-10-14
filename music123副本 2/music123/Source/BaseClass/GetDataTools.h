//
//  GetDataTools.h
//  music123
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^PassValue)(NSArray *array);
@interface GetDataTools : NSObject

@property (nonatomic,strong)NSMutableArray *dataArr;

+ (instancetype)shareMusicData;

- (void)getModelWithURL:(NSString *)URL PassValue:(PassValue)passValue;

- (Music *)getModelWithIndex:(NSInteger)index;

@end
