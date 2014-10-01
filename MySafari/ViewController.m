//
//  ViewController.m
//  MySafari
//
//  Created by Amaeya Kalke on 10/1/14.
//  Copyright (c) 2014 Amaeya Kalke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.urlTextField becomeFirstResponder];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma navigation bar
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *urlString = textField.text;

    //Check URL string
    if([textField.text hasPrefix:@"http://"]){
        urlString = urlString;
    }
    else{
        NSString *incompleteURL = urlString;
        urlString = [NSString stringWithFormat:@"http://%@",incompleteURL];
        self.urlTextField.text = urlString;
    }

    NSURL *url = [NSURL URLWithString: urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest:urlRequest];
    return YES;
}


# pragma status indicator

//COMPLETE
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


#pragma navigation
//INCOMPLETE
- (IBAction)onBackButtonPressed:(id)sender {
    if(self.webView.canGoBack == YES){
        [self.webView goBack];
    }
    else{
        [self.backButton setTitle:@"" forState:UIControlStateNormal];
    }
}

//INCOMPLETE
- (IBAction)onForwardButtonPressed:(id)sender {
    if(self.webView.canGoForward == YES){
        [self.webView goForward];
    }
    else{
        [self.forwardButton setTitle:@"" forState:UIControlStateNormal];
    }
}


//Complete
- (IBAction)onStopLoadingButtonPressed:(id)sender{
    [self.webView stopLoading];
}

//Complete
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}


//Complete
- (IBAction)onPlusButtonPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    alertView.title = @"Coming Soon!";
    [alertView addButtonWithTitle:@"OK"];
    [alertView show];

}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
