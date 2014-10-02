//
//  ViewController.m
//  MySafari
//
//  Created by Amaeya Kalke on 10/1/14.
//  Copyright (c) 2014 Amaeya Kalke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;
@property (strong, nonatomic) IBOutlet UILabel *pageName;
@property (assign, nonatomic) CGFloat *previousPoint;
@property (strong, nonatomic) IBOutlet UIView *topNav;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.urlTextField becomeFirstResponder];
    [self setDefaultPlaceholderURLText];
    [self.webView.scrollView setDelegate:self];

    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma navigation bar
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self checkURLString];
    return YES;
}

- (IBAction)onClearButtonPressed:(id)sender {
    self.urlTextField.text = @"";
}

//INCOMPLETE
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIGestureRecognizer *scrolled = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(scrollDirection):];

    if(self.webView.scrollView.contentOffset.y > 0){
        NSLog(@"Scrolling");
        self.topNav.alpha = 0.5;
    }
}

-(void)scrollDirection:(UIGestureRecognizer *)sender{

}

#pragma topnav helper methods
-(void)setDefaultPlaceholderURLText{
    self.urlTextField.placeholder = @"Please enter a URL";
}

-(void)displayURL{
    NSURL *url = self.webView.request.URL;
    NSString *urlString = url.absoluteString;
    self.urlTextField.text = urlString;
}

-(void)displayPageName{
    NSString *webName = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.pageName.text = webName;
}

-(void)checkURLString{
    NSString *urlString = self.urlTextField.text;
    if([self.urlTextField.text hasPrefix:@"http://"]){
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
}

# pragma status indicator
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self displayURL];
    [self displayPageName];
    [self showHideNavButtons];
}


#pragma navigation
- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    [self.webView goForward];
}

-(void)showHideNavButtons{
    //This method shows and hides the back and forward navigation items depending on if the browser has the ability to go back/forward a page.
    if(self.webView.canGoBack == YES){
        [self.backButton setTitle:@"<" forState:UIControlStateNormal];
    }
    else{
        [self.backButton setTitle:@"" forState:UIControlStateNormal];
    }

    if(self.webView.canGoForward == YES){
        [self.forwardButton setTitle:@">" forState:UIControlStateNormal];
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
