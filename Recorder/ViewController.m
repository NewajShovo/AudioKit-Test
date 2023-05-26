//
//  ViewController.m
//  Recorder
//
//  Created by Shovo on 26/5/23.
//

#import "ViewController.h"
#import "Recorder-Swift.h"
//@import AudioKit;
//@import AVFoundation;
//@import AudioKitEX;

@interface ViewController (){
    RecorderConductor *conductor;
//    Recor
}
@property (strong, nonatomic) IBOutlet UIButton *recordBnt;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    conductor = [[RecorderConductor alloc] init];
    [conductor startEngine];
//    conductor 
    NSLog(@"%@",conductor);

}

- (IBAction)recordButtonPressed:(id)sender {
    if([self.recordBnt.titleLabel.text isEqualToString:@"Recording..."]||[self.playBtn.titleLabel.text isEqualToString:@"Playing..."]){
        [self.recordBnt setTitle:@"Start Recording" forState:UIControlStateNormal];
        [self.playBtn setTitle:@"Play Recording" forState:UIControlStateNormal];
        [conductor stopEverything];
    }else{
        [self.recordBnt setTitle:@"Recording..." forState:UIControlStateNormal];
        [self.playBtn setTitle:@"Play Recording" forState:UIControlStateNormal];
        [conductor record];
    }
}

- (IBAction)playButtonPressed:(id)sender {
    NSLog(@"Play button pressed.");
    if([self.recordBnt.titleLabel.text isEqualToString:@"Recording..."]||[self.playBtn.titleLabel.text isEqualToString:@"Playing..."]){
        [self.recordBnt setTitle:@"Start Recording" forState:UIControlStateNormal];
        [self.playBtn setTitle:@"Play Recording" forState:UIControlStateNormal];
        
        [conductor stopEverything];
        
    }else{
        [self.recordBnt setTitle:@"Start Recording" forState:UIControlStateNormal];
        [self.playBtn setTitle:@"Playing..." forState:UIControlStateNormal];
        [conductor playAudio];
    }
}



@end
