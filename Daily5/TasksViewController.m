//
//  TasksViewController.m
//  Daily5
//
//  Created by Mohammad Azam on 10/2/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "TasksViewController.h"

@interface TasksViewController ()

@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) IBOutlet UIImageView *settingsImageView;

@end

@implementation TasksViewController

NSString *const CURRENT_DATE = @"CurrentDate";

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
    [self setup];
}

-(void) registerGestureRecognizers
{
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingsTapped:)];
    
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    
    [self.settingsImageView addGestureRecognizer:singleTapGestureRecognizer];
}

-(void) settingsTapped:(UITapGestureRecognizer *) recognizer
{
    [self performSegueWithIdentifier:@"SettingsSegue" sender:nil];
}

-(void) scrollToCurrentDate
{
     self.scrollView.contentOffset = CGPointMake(self.view.bounds.size.width * 5, 0);
}

-(TaskView *) createTaskView
{
    TaskView *taskView = [[TaskView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    return taskView;
}

-(void) initializeScrollViewWithTasks
{
    // remove all subviews
    [[self.scrollView subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    int offsetX = 0;
    
    for(int day = -5; day <= 5; day++)
    {
        TaskView *taskView = [self createTaskView];
        taskView.frame = CGRectMake(offsetX, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        taskView.tag = day;
        taskView.tasks = [_taskService getByTaskDate:[TaskHelper getTaskDateByDay:day]];
        
        [taskView setup];
        
        [self.scrollView addSubview:taskView];
        
        offsetX+= self.view.bounds.size.width; // returns 320 for iPhone
        
    }
    
    [self scrollToCurrentDate];
}

-(void) performRefreshForCurrentDay:(void (^)(UIBackgroundFetchResult))completionHandler;
{
    // fire every hour!
    [_taskService updateBadgeNumber];
    
    if(completionHandler)
    {
        completionHandler(UIBackgroundFetchResultNewData);
    }
    // do not fire the following evey hour
    else
    {
       [self initializeScrollViewWithTasks];
    }
    
}

-(void) refreshForCurrentDay
{
    [self performRefreshForCurrentDay:nil];
}

-(void) registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshForCurrentDay) name:UIApplicationSignificantTimeChangeNotification object:nil];
}

-(void) setup
{
    _taskService = [[TaskService alloc] init];
    
    self.scrollView.contentSize = CGSizeMake(320 * 11, self.view.bounds.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    
    _taskViews = [NSMutableArray array];
    
    [self hideStatusBar];
    [self initializeScrollViewWithTasks];
    [self registerGestureRecognizers];
    
    // register for notification
    
    [self registerForNotifications];
}

-(void) hideStatusBar
{
     [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
