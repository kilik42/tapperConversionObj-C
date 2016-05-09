//
//  ViewController.m
//  tapperConversionObj-C
//
//  Created by marvin evins on 5/9/16.
//  Copyright © 2016 marvin evins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

{
    int numberOfTapsToWin;
    int currentTaps;
}


@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UITextField *howManyTextField;
@property (weak, nonatomic) IBOutlet UILabel *howManyLabel;
@property (weak, nonatomic) IBOutlet UIButton *coinButton;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    numberOfTapsToWin = 0;
    currentTaps = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButtonTapped:(id)sender {
    if (![self.howManyTextField.text  isEqual: @""]) {
        
        numberOfTapsToWin = [self.howManyTextField.text intValue];
        if (numberOfTapsToWin) {
            
            [self playGame];
            
        } else {
            
            [self showAlert:@"Number Required" alertMessage:@"Please enter a number to continue"];
            
            self.howManyTextField.text = @"";
            [self reloadInputViews];
        }
        
    } else {
        
        [self showAlert:@"No Value Entered" alertMessage:@"Please enter a number of taps to win!"];
    }
}

- (IBAction)coinButtonTapped:(id)sender {
    
    currentTaps++;
    
    if (currentTaps < numberOfTapsToWin) {
        self.howManyLabel.text = [NSString stringWithFormat:@"%d Taps", currentTaps];
    } else {
        
        [self gameOver];
        
    }
    
}

- (void)startGame {
    
    self.playButton.hidden = NO;
    self.titleImage.hidden = NO;
    self.howManyTextField.hidden = NO;
    self.howManyTextField.text = @"";
    self.coinButton.hidden = YES;
    self.howManyLabel.text = @"";
    self.howManyLabel.hidden = YES;
    
    numberOfTapsToWin = 0;
    currentTaps = 0;
}

- (void)playGame {
    self.playButton.hidden = YES;
    self.titleImage.hidden = YES;
    self.howManyTextField.hidden = YES;
    self.coinButton.hidden = NO;
    self.howManyLabel.hidden = NO;
    self.howManyLabel.text = @"0 Taps";
}

- (void)gameOver {
    self.playButton.hidden = YES;
    self.titleImage.hidden = YES;
    self.howManyTextField.hidden = YES;
    self.coinButton.hidden = YES;
    self.howManyLabel.hidden = YES;
    self.howManyLabel.text = @"";
    
    [self showAlert:@"YOU WIN!" alertMessage:@"Game over, click ok to restart"];
}

- (void)showAlert:(NSString*)alertTitle alertMessage:(NSString*)alertMessage {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle: alertTitle
                                  message: alertMessage
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [self startGame];
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion: nil];
}

@end
