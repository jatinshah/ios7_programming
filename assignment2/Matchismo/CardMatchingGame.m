//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jatin Shah on 10/6/14.
//  Copyright (c) 2014 Jatin Shah. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)chosenCards
{
    if(!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        [self dealWithCardCount:count usingDeck:deck];
    } else {
        self = nil;
    }
    return self;
}

- (void)dealWithCardCount:(NSUInteger)count
                usingDeck:(Deck *)deck
{
    [self.cards removeAllObjects];
    self.lastMatchScore = 0;
    [self.chosenCards removeAllObjects];
    for (int i=0; i < count; i++) {
        Card *card = [deck drawRandomCard];
        if (card) {
            [self.cards addObject:card];
        } else {
            break;
        }
    }
    self.cardMatchCount = 2;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
            if([self.chosenCards count] == self.cardMatchCount) {
                [self.chosenCards removeAllObjects];
            } else {
                [self.chosenCards removeObject:card];
            }
        } else {
            NSMutableArray *otherChosenCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched) {
                    [otherChosenCards addObject:otherCard];
                }
            }
            
            if ([otherChosenCards count] == self.cardMatchCount - 1) {
                int matchScore = [card match:otherChosenCards];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    self.lastMatchScore = MATCH_BONUS * matchScore;
                    card.matched = YES;
                    for (Card *otherCard in otherChosenCards) {
                        otherCard.matched = YES;
                    }
                } else {
                    self.score -= MISMATCH_PENALTY;
                    self.lastMatchScore = (-1) * MISMATCH_PENALTY;
                    for (Card *otherCard in otherChosenCards) {
                        otherCard.chosen = NO;
                    }
                    card.chosen = NO;
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            
            if([self.chosenCards count] == self.cardMatchCount) {
                Card *card = [self.chosenCards lastObject];
                [self.chosenCards removeLastObject];
                int matchScore = [card match:self.chosenCards];
                [self.chosenCards removeAllObjects];
                if(!matchScore) {
                    [self.chosenCards addObject:card];
                }
            }
            [self.chosenCards addObject:card];
        }
    }
}
@end
