import Foundation
import UIKit

func fixtureData(filename: String) -> NSData? {
    let pathExtension = (filename as NSString).pathExtension
    let pathPrefix = (filename as NSString).stringByDeletingPathExtension
    if let bundle = NSBundle(identifier: "com.pivotal.brighton.Spec"),
        fixtureURL = bundle.URLForResource(pathPrefix, withExtension: pathExtension)
    {
        return NSData(contentsOfURL: fixtureURL)
    }
    return nil
}

extension UIViewController {
    func renderInNavController() {
        let navController = UINavigationController(rootViewController: self)
        if let window = UIApplication.sharedApplication().delegate?.window {
            window!.rootViewController = navController
            NSRunLoop.mainRunLoop().runUntilDate(NSDate())
        }
    }
}
