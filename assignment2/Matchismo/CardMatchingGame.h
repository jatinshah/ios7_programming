//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jatin Shah on 10/6/14.
//  Copyright (c) 2014 Jatin Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck;

- (void) dealWithCardCount:(NSUInteger)count
                 usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger cardMatchCount;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@property (nonatomic) NSInteger lastMatchScore;
@end
