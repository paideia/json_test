//
//  ViewController.m
//  json_test
//
//  Created by Balaji Rajan on 24/05/14.
//  Copyright (c) 2014 Whatbig. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<NSURLConnectionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSData *data = [[NSData alloc] initWithContentsOfURL:
                              [NSURL URLWithString:@"http://json.vellakovil.info"]];
    
    
    NSError *error;
    NSMutableDictionary *dict = [NSJSONSerialization
                                       JSONObjectWithData:data
                                       options:NSJSONReadingMutableContainers
                                       error:&error];
    
    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        NSArray *users = dict[@"users"];
        NSLog(@"users array::%@",users);
        for ( NSDictionary *entity in users )
        {
            NSLog(@"----");
            NSLog(@"id: %@", entity[@"id"] );
            NSLog(@"name: %@", entity[@"name"] );
            NSLog(@"pass: %@", entity[@"pass"] );
                  }
    }
    
    [self postMethod];


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)postMethod{
    
    

    NSString *post=[NSString stringWithFormat:@"&id=8&name=hai&pass=bye"];
    NSData *postData=[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://json.vellakovil.info/add.php"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
     [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSURLConnection *conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (conn) {
        NSLog(@"connect successfully");
        
    }else{
        NSLog(@"error in connection");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
    NSLog(@"receive data");
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"fail connection");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"connection finish");
}
@end
