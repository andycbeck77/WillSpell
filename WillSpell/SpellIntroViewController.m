//
//  SpellIntroViewController.m
//  WillSpell
//
//  Created by Andy Beck on 11/14/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "SpellIntroViewController.h"
#import "SpellViewController.h"
#import "GameData.h"

@interface SpellIntroViewController ()

@property (strong, nonatomic) SpellViewController *spellViewController;
@property (nonatomic) NSUInteger level;
@property (strong, nonatomic) GameData *gameData;
@end

@implementation SpellIntroViewController

@synthesize spellViewController = _spellViewController;

- (GameData *) gameData {
    if (!_gameData) {
        _gameData = [[GameData alloc] init];
    }
    return _gameData;
}

- (SpellViewController *) spellViewController {
    //if (!_spellViewController) {
    //    _spellViewController = [[SpellViewController alloc] init];
    //}
    return _spellViewController;
}

- (void) setSpellViewController:(SpellViewController *) spellViewController {
    _spellViewController = spellViewController;
}

- (IBAction)playGame:(UIButton *)sender {
    self.spellViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"spellviewcontroller"];
    self.spellViewController.level = self.level;
    [self presentViewController:self.spellViewController animated:YES completion:nil];
    
    NSString *def = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
    NSLog(@"%@", def);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.gameData loadGameData];
    NSString *level = @"-";
    NSString *lastIndex = @"-";
    
    if (!self.gameData.level) {
        level = self.gameData.level;
    }
    if (!self.gameData.wordIndex) {
        lastIndex = self.gameData.wordIndex;
    }
    NSLog(@"level:%d lastIndex:%d",level,lastIndex);

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)levelSelect:(UISegmentedControl *)sender {
    self.level = sender.selectedSegmentIndex;
    if (self.spellViewController) {
        self.spellViewController.level = sender.selectedSegmentIndex;
    } 
}

@end
