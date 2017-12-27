//
//  CuteTouchID.m
//  CuteTouchID
//
//  Created by wangzhe on 2017/12/26.
//  Copyright © 2017年 libcafe.com. All rights reserved.
//

#import "CuteTouchID.h"

@implementation CuteTouchID

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(isSupported:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    
    LAContext *context = [[LAContext alloc] init];
    NSError *e;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&e]) {
        resolve(@"SUPPORTED");
    } else {
        reject(nil, @"NOT SUPPORTED", nil);
    }
    
}


RCT_EXPORT_METHOD(authenticate: (NSString *) reason
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    
    LAContext *context = [[LAContext alloc] init];
    NSError *e;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&e]){
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                NSData *oldDomainState = [defaults objectForKey:@"domainTouchID"];
                
                NSData *domainState = [context evaluatedPolicyDomainState];
                
                if (oldDomainState != nil) {
                    
                    if ([oldDomainState isEqual:domainState]) {
                        
                        oldDomainState = [context evaluatedPolicyDomainState];
                        [defaults setObject:oldDomainState forKey:@"domainTouchID"];
                        [defaults synchronize];
                        
                        resolve(@"SUCCESS");
                        
                    } else {
                        
                        oldDomainState = [context evaluatedPolicyDomainState];
                        [defaults setObject:oldDomainState forKey:@"domainTouchID"];
                        [defaults synchronize];
                        
                        reject(nil, @"TOUCH ID CHANGED", nil);
                        
                    }
                    
                } else {
                    
                    oldDomainState = [context evaluatedPolicyDomainState];
                    [defaults setObject:oldDomainState forKey:@"domainTouchID"];
                    [defaults synchronize];
                    resolve(@"SUCCESS");
                    
                }
                
            } else {
                
                if (error != nil) {
                    
                    switch (error.code) {
                            
                        case LAErrorAuthenticationFailed:
                            reject(nil, @"AUTHENTICATION FAILED", nil);
                            break;
                            
                        case LAErrorAppCancel:
                            reject(nil, @"APP CENCEL", nil);
                            break;
                            
                        case LAErrorInvalidContext:
                            reject(nil, @"INVALID CONTEXT", nil);
                            break;
                            
                        case LAErrorNotInteractive:
                            reject(nil, @"NOT INTERACTIVE", nil);
                            break;
                        
                        case LAErrorPasscodeNotSet:
                            reject(nil, @"PASSCODE NOT SET", nil);
                            break;
                            
                        case LAErrorSystemCancel:
                            reject(nil, @"SYSTEM CANCEL", nil);
                            break;
                        
                        case LAErrorUserCancel:
                            reject(nil, @"USER CANCEL", nil);
                            break;
                        
                        case LAErrorUserFallback:
                            reject(nil, @"USER FALLBACK", nil);
                            break;
                            
                        case LAErrorBiometryLockout:
                            reject(nil, @"BIOMETRY LOCKOUT", nil);
                            break;
                        
                        case LAErrorBiometryNotEnrolled:
                            reject(nil, @"BIOMETRY NOT ENROLLED", nil);
                            break;
                            
                        case LAErrorBiometryNotAvailable:
                            reject(nil, @"BIOMETRY NOT AVAILABLE", nil);
                            break;
                     
                        default:
                            reject(nil, @"UNKNOWN ERROR", nil);
                            break;
                    }
                    
                } else {
                    
                    reject(nil, @"UNKNOWN ERROR", nil);
                    
                }
                
                
                
            }
            
            
        }];
        
    } else {
        
        reject(nil, @"NOT SUPPORTED", nil);
        
    }
    
}
@end
