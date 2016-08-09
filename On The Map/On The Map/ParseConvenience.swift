//
//  ParseConvenience.swift
//  On The Map
//
//  Created by lily on 8/5/16.
//  Copyright © 2016 Seab Jackson. All rights reserved.
//

import Foundation

extension ParseClient {
    
    func getStudentLocation(completionHandlerForStudentLocation: (success: Bool, error: NSError?) -> Void) {
        
        let parameters = [String: AnyObject]()
        taskForGETMethod(Methods.StudentLocation, parameters: parameters) { (results, error) in
            if let error = error {
                print(error)
                completionHandlerForStudentLocation(success: false, error: error)
            } else {
                guard let locations = results["results"] as? [[String: AnyObject]] else {
                   completionHandlerForStudentLocation(success: false, error: error)
                    print("didn't get the results am looking for")
                    return
                }
                completionHandlerForStudentLocation(success: true, error: error)
                
                
                // loop through all the student locations
                for location in locations {
                    var studentLocation = StudentLocation()
                    studentLocation.firstName = location["firstName"] as? String
                    studentLocation.lastName = location["lastName"] as? String
                    studentLocation.latitude = location["latitude"] as? Double
                    studentLocation.longitude = location["longitude"] as? Double
                    studentLocation.mapString = location["mapString"] as? String
                    studentLocation.mediaURL = location["mediaURL"] as? String
                    studentLocation.objectId = location["objectId"] as? String
                    studentLocation.uniqueKey = location["uniqueKey"] as? String
                    
                    // load up the student location array
                    StudentLocations.sharedInstance.sharedLocations.append(studentLocation)
                    
                }
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
}