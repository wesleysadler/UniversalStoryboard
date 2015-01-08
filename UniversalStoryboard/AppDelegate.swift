//
//  AppDelegate.swift
//  UniversalStoryboard
//
//  Created by Wesley Sadler on 1/6/15.
//  Copyright (c) 2015 Digital Sadler. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    
    let objects: [String: [String]] = ["Loons": ["Red-throated Loon", "Arctic Loon", "Pacific Loon", "Common Loon", "Yellow-billed Loon"], "Owls": ["Western Screech Owl", "Eastern Screech Owl", "Whiskered Screech Owl", "Great Horned Owl", "Snowy Owl", "Burrowing Owl", "Spotted Owl", "Barred Owl", "Great Grey Owl", "Long-eared Owl", "Short-eared Owl", "Northern Saw-whet Owl"], "Hawks and Eagles": ["Bald Eagle", "Northern Harrier", "Sharp-shinned Hawk", "Coopers Hawk", "Northern Goshawk", "Red-tailed Hawk", "Swainson's Hawk", "Rough-legged Hawk", "Golden Eagle"]]

    let backyardBirds: [String] = ["American Robin", "Mourning Dove", "White-Breasted Nuthatch", "Downy Woodpecker", "House Finch", "American Goldfinch", "American Crow", "European Starling", "House Sparrow"]
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.        
        
        let splitViewController = self.window!.rootViewController as UISplitViewController
        splitViewController.delegate = self
        splitViewController.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        
        // get tab bar contoller so can set variables in other view controller of tab bar
        let tabBarController = splitViewController.viewControllers[0] as UITabBarController
        tabBarController.delegate = self
        let tabBarControllers = tabBarController.viewControllers
        // set families view controller variables
        if let familiesNavigationController = tabBarControllers?[0] as? UINavigationController {
            let controller = familiesNavigationController.topViewController as FamiliesViewController
            controller.objects = self.objects
            controller.rows = [String](self.objects.keys)
        }
        // set backyard birds view controller variables
        if let birdsNavigationController = tabBarControllers?[1] as? UINavigationController {
            let controller = birdsNavigationController.topViewController as BackyardBirdsViewController
            controller.objects = backyardBirds
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Split view
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController {
                if topAsDetailController.detailItem == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        return false
    }
    
    func splitViewController(splitViewController: UISplitViewController, showDetailViewController vc: UIViewController, sender: AnyObject?) -> Bool {
        if splitViewController.collapsed {
            let tabBarViewController = splitViewController.viewControllers[0] as UITabBarController
            let masterViewController = tabBarViewController.selectedViewController as UINavigationController
            masterViewController.showViewController(vc, sender: sender)
            
            return true
        }
        return false
    }

}

