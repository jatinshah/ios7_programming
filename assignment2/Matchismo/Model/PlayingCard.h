//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jatin Shah on 9/29/14.
//  Copyright (c) 2014 Jatin Shah. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
