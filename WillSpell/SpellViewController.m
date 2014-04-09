//
//  SpellViewController.m
//  WillSpell
//
//  Created by Andy Beck on 9/20/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "SpellViewController.h"
#import "ImageView.h"
#import "LetterScrollView.h"
#import "MysteryWord.h"
#import "GameData.h"
#import "BigLetterScrollView.h"

#import <AVFoundation/AVAudioPlayer.h>

NSString *const WIN_IMAGE = @"my_correct_check_2.png"; //@"fireworks.png"; //@"trophy_large.png"; //@"fireworks_animated_black_background_large-1.gif";

NSString *const WRONG_IMAGE = @"wrong4.png";

@interface SpellViewController () //<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet ImageView *imageView;
@property (weak, nonatomic) IBOutlet LetterScrollView *letterScrollView;

@property (strong, nonatomic) NSArray *letterList;
@property (strong, nonatomic) NSArray *imageList;
@property (strong, nonatomic) NSArray *wordList;
@property (strong, nonatomic) MysteryWord *mysteryWord;

@property (weak, nonatomic) IBOutlet UIButton *scoreText;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *backCollection;
@property (strong, nonatomic) GameData *gameData;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@end

@implementation SpellViewController

@synthesize imageView = _imageView;
@synthesize letterScrollView = _letterScrollView;

- (NSArray *)letterList {
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
}

- (NSArray *) imageList {
    return @[@"green_apple.png", @"bear.png",@"bumble_bee.png",@"camera-photo-5.png", @"cupcake_iced_with_cherry.png",@"dog.png",@"dragon.png",@"egg_sunny.png", @"elephant.png", @"flag-us.png", @"rosa.png", @"ghost.png", @"giraffe.png", @"heart-3.png", @"hippo.png", @"ice_cream_2.png", @"jellyfish.png", @"ladybug.png", @"light_bulb.png", @"lion.png", @"key2.png", @"kite.png", @"mouse.png", @"plant-mushroom.png", @"note.png", @"peanut2.png", @"penguin.png", @"octopus.png", @"owl.png", @"queen_large.png", @"rabbit.png", @"road-sign-us-stop.png", @"shield-2.png", @"train2_large.png", @"umbrella-black.png.png", @"volcano", @"whale.png", @"xylophone.png", @"zebra.png"];
}

- (NSArray *) wordList {
    return @[@"APPLE",@"BEAR",@"BEE",@"CAMERA",@"CUPCAKE",@"DOG",@"DRAGON",@"EGG",@"ELEPHANT",@"FLAG",@"FLOWER",@"GHOST",@"GIRAFFE",@"HEART",@"HIPPO",@"ICE CREAM",@"JELLYFISH",@"LADYBUG",@"LIGHT",@"LION",@"KEY",@"KITE",@"MOUSE",@"MUSHROOM",@"MUSIC",@"NUT",@"PENGUIN",@"OCTOPUS",@"OWL",@"QUEEN",@"RABBIT",@"STOP SIGN",@"SHIELD",@"TRAIN",@"UMBRELLA",@"VOLCANO",@"WHALE",@"XYLOPHONE",@"ZEBRA"];
}

- (NSArray *)colorList {
    return @[@"RED",@"YELLOW",@"GREEN",@"ORANGE"];
}

- (MysteryWord *) mysteryWord {
    if (!_mysteryWord) {
        _mysteryWord = [[MysteryWord alloc] init];
    }
    return _mysteryWord;
}

- (LetterScrollView *) letterScrollView {
    if (!_letterScrollView) {
        _letterScrollView = [[LetterScrollView alloc] init];
    }
    
    if (!_letterScrollView.winnerDelegate) {
        _letterScrollView.winnerDelegate = self;
    }
    
    return _letterScrollView;
}

- (void) setLetterScrollView:(LetterScrollView *)letterScrollView {
    _letterScrollView = letterScrollView;
}

- (ImageView *) imageView {
    if (!_imageView) {
        _imageView = [[ImageView alloc] init];
    }
    return _imageView;
}
- (void)setImageView:(ImageView *)imageView {
    _imageView = imageView;
    [imageView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:imageView action:@selector(pinch:)]];
}

// Get the big view or small view for ipad or iphone respectively
- (LetterScrollView *) getViewLetterScrollView {
    return self.letterScrollView;
}


// Get the big view or small view for ipad or iphone respectively
- (ImageView *) getViewImageView {
    return self.imageView;
}


- (GameData *) gameData {
    if (!_gameData) {
        _gameData = [[GameData alloc] init];
    }
    return _gameData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	   
    // 320, 153
    //[self getViewLetterScrollView].contentSize = CGSizeMake(1640.0, 640.0);
    
    [self setupWord];
    [[self getViewLetterScrollView] setupLetters:self.letterList];
    
    [self updateScore];
    
    for (UIButton *bckBtn in self.backCollection) {
            bckBtn.enabled = NO;
    }
}

- (void) setupWord {
    [[self getViewImageView] changeImage:self.imageList[self.wordIndex]];
    [self refreshWord];
}

- (void) refreshWord {

    if (self) {
        [self.mysteryWord initCurrentWord:self.wordList[self.wordIndex]];
        [self getViewLetterScrollView].mysteryWord = self.mysteryWord;
        [[self getViewLetterScrollView] refreshWord:[self.mysteryWord guessedWord] withMysteryWord:self.mysteryWord];
    }

    // If easy fill out all but first letter, if medium give half word
    if (self.level == 0) {
        [self.mysteryWord hint:self.mysteryWord.actualWord.count-1];
        [[self getViewLetterScrollView] resetWordLetters:[self.mysteryWord guessedWord]];
    } else if (self.level == 1) {
        [self.mysteryWord hint:(self.mysteryWord.actualWord.count/2)];
        [[self getViewLetterScrollView] resetWordLetters:[self.mysteryWord guessedWord]];
    }
    
    [self.gameData saveGameData:self.level forLastIndex:self.wordIndex forNumberCorrect:self.gameData.numberCorrect.integerValue forNumberWrong:self.gameData.numberWrong.integerValue forNumberSkipped:self.gameData.numberSkipped.integerValue];
}
- (IBAction)giveMeAHint:(UIButton *)sender {
    if ([self getViewLetterScrollView]) {
        [self.mysteryWord hint];
        [[self getViewLetterScrollView] resetWordLetters:[self.mysteryWord guessedWord]];
    }
}

- (IBAction)choosePreviousWord:(UIButton *)sender {
    if (self.randomIndex > 0) {
        self.randomIndex--;
    }

    [self updateIndexForView];
}


- (IBAction)chooseNextWord:(UIButton *)sender {
    /*
    if (self.wordIndex >= self.wordList.count-1) {
        self.wordIndex = 0;
    } else {
        self.wordIndex++;
    }
    
    [self.mysteryWord clearWord];
    [self refreshWord];
    [[self getViewImageView] changeImage:self.imageList[self.wordIndex]];
    */
    
    if (!self.gameData.isRandomArrayLoaded) {
        [self.gameData randomizeIndices:self.wordIndex forSize:self.wordList.count];
    }
    
    if (self.randomIndex >= self.wordList.count-1) {
        self.randomIndex = 0;
        self.gameData.randomizedIndices = nil;
        self.gameData.isRandomArrayLoaded = NO;
        [self.gameData randomizeIndices:-1 forSize:self.wordList.count];
    } else {
        self.randomIndex++;
    }
    
    [self updateIndexForView];
}


- (void) updateIndexForView {
        

    NSNumber *num = [self.gameData.randomizedIndices objectAtIndex:self.randomIndex];
    int intnum = [num integerValue];
    self.wordIndex = intnum;
    
    [self.mysteryWord clearWord];
    [self refreshWord];
    [[self getViewImageView] changeImage:self.imageList[intnum]];
    
    if (self.randomIndex > 0) {
        for (UIButton *bckBtn in self.backCollection) {
            bckBtn.enabled = YES;
        }
    }
    
}

- (IBAction)showScore:(id)sender {
    [self updateScore];
    //NSLog([NSString stringWithFormat:@"Correct: %d", self.gameData.numberCorrect.intValue]);
    //NSLog([NSString stringWithFormat:@"Wrong: %d", self.gameData.numberWrong.intValue]);
}

- (void) updateScore {
        [self.scoreText setTitle:[NSString stringWithFormat:@"Correct: %d Wrong: %d", self.gameData.numberCorrect.intValue, self.gameData.numberWrong.intValue] forState:UIControlStateNormal];
        self.scoreText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

- (IBAction)resetScore:(id)sender {
    [self.gameData saveGameData:self.gameData.level.integerValue forLastIndex:self.gameData.wordIndex.integerValue forNumberCorrect:0 forNumberWrong:0 forNumberSkipped:0];
    
    [self updateScore];
}

- (IBAction)exitSpellViewController:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) winner {
    NSLog(@"winner!");
    [[self getViewImageView] changeImage:WIN_IMAGE];
    
    [self.gameData saveGameData:self.gameData.level.integerValue forLastIndex:self.gameData.wordIndex.integerValue forNumberCorrect:self.gameData.numberCorrect.integerValue+1 forNumberWrong:self.gameData.numberWrong.integerValue forNumberSkipped:self.gameData.numberSkipped.integerValue];
    
    [self updateScore];
    
    NSURL* musicFile = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Willben2_v3.m4a",
                                               [[NSBundle mainBundle] resourcePath]]];
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:&error];
    
    if (!error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [self.audioPlayer play];
    
    dispatch_queue_t correctQ = dispatch_queue_create("temporary  correct image", NULL);
    dispatch_async(correctQ, ^{
        [NSThread sleepForTimeInterval:2.0f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self chooseNextWord:nil];
        });
    });
}

- (void) wrong {
    NSLog(@"wrong!");
    [[self getViewImageView] changeImage:WRONG_IMAGE];
    
    dispatch_queue_t wrongQ = dispatch_queue_create("temporary  wrong image", NULL);
    dispatch_async(wrongQ, ^{
        [NSThread sleepForTimeInterval:2.0f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self getViewImageView] changeImage:self.imageList[self.wordIndex]];
        });
    });
    
    [self.gameData saveGameData:self.gameData.level.integerValue forLastIndex:self.gameData.wordIndex.integerValue forNumberCorrect:self.gameData.numberCorrect.integerValue forNumberWrong:self.gameData.numberWrong.integerValue+1 forNumberSkipped:self.gameData.numberSkipped.integerValue];
    
    [self updateScore];
}

@end
