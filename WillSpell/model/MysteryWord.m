//
//  MysteryWord.m
//  WillSpell
//
//  Created by Andy Beck on 11/4/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "MysteryWord.h"

@interface MysteryWord()

@end

@implementation MysteryWord

- (NSArray *)wordList {
    return @[@"APPLE",@"BANANA",@"PEAR"];
}

- (NSMutableArray *) guessedWord {
    if (!_guessedWord) {
        _guessedWord = [[NSMutableArray alloc] init];
    }
    return _guessedWord;
}

- (NSMutableArray *) actualWord {
    if(!_actualWord) {
        _actualWord = [[NSMutableArray alloc] init];
    }
    return _actualWord;
}
- (void) initCurrentWordByIndex:(NSInteger)wordIndex {
    [self initCurrentWord:self.wordList[wordIndex]];
}
- (void) initCurrentWord:(NSString *)word {
    for (NSUInteger currentLetterIndex = 0; currentLetterIndex < [word length]; currentLetterIndex++) {
        
        NSRange range = NSMakeRange (currentLetterIndex, 1);
        NSString *currentLetter = [word substringWithRange:range];
        
        //_actualWord[currentLetterIndex] = currentLetter;
        [self.actualWord addObject:currentLetter];
        //_guessedWord[currentLetterIndex] = @"-";
        [self.guessedWord addObject:@"-"];
    }
}

- (BOOL) makeGuess:(NSString *)letter atIndex:(NSUInteger) index {
    
    if ([letter isEqualToString:_actualWord[index]]) {
        _guessedWord[index] = letter;
        return YES;
    }
    
    return NO;
}


@end
