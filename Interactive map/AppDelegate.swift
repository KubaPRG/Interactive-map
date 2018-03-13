//
//  AppDelegate.swift
//  Interactive map
//
//  Created by Jakub Kulakowski on 12/7/17.
//  Copyright © 2017 Jakub Kulakowski. All rights reserved.
//

import UIKit
import CoreData

let signInStatus = GIDSignIn.sharedInstance().hasAuthInKeychain()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        if (configureError != nil) {
            print ("We have an error \(String(describing: configureError))")
        }
        
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().hostedDomain = "lemoyne.edu"
        
        print ("This is the sign-in status: \(signInStatus)")
        if signInStatus == true {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let homePage = sb.instantiateViewController(withIdentifier: "HomePage") as? UIViewController {
                window?.rootViewController = homePage}
            
        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let loginPage = sb.instantiateViewController(withIdentifier: "LoginPage") as? UIViewController {
                window?.rootViewController = loginPage}
        }
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil){
            print("Looks like we got a sign-in error: \(error)")
        } else {
            if user.hostedDomain != "lemoyne.edu" {
                GIDSignIn.sharedInstance().signOut()
                print("The user used an email that is not @lemoyne.edu")
                
                //Notify the user to use a lemoyne.edu email
                let alert = UIAlertController(title: "Unauthorized User", message:"Please use a lemoyne.edu email.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                let sb = UIStoryboard(name: "Main", bundle: nil)
                if let loginPage = sb.instantiateViewController(withIdentifier: "LoginPage") as? UIViewController {
                    window?.rootViewController = loginPage}
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            } else {
                print("Wow, our user signed-in! User: \(user)")
                
                let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
                if launchedBefore  {
                    self.setHomePage()
                    
                    print("This is not first launch.")
                } else {
                    self.setHomePage()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let tvc = sb.instantiateViewController(withIdentifier: "TutorialPage")
                    self.window?.rootViewController?.present(tvc, animated: true, completion: nil)
                    
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                    UserDefaults.standard.synchronize()
                    print("This is first launch.")
                }
            }
            
        }
    }
 
    func setHomePage(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        window!.rootViewController = sb.instantiateViewController(withIdentifier: "HomePage")
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Sign_In")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
