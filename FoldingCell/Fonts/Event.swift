//
//  Event.swift
//  FoldingCell
//
//  Created by Ulises Giacoman on 2/4/16.
//  Copyright © 2016 Alex K. All rights reserved.
//


import Foundation

class Event {
    
    var numStudents:[String]
    var course:[String]
    var start_t:[String]
    var image_name:[String]
    var end_t:[String]
    var edescription:[String]
    var faculty:[String]
    var organizer:[String]
    var created_at:[String]
    var user_id:[String]
    var location:[String]
    var updated_at:[String]
    var department:[String]
    var name:[String]
    
    
    
    init(numStudents:[String], course:[String], start_t:[String], image_name:[String], end_t:[String], edescription:[String], faculty:[String], organizer:[String], created_at:[String], user_id:[String], location:[String], updated_at:[String], department:[String], name:[String]) {
            
        self.course = course
        self.numStudents = numStudents
        self.start_t = start_t
        self.image_name = image_name
        self.end_t = end_t
        self.edescription = edescription
        self.faculty = faculty
        self.organizer = organizer
        self.created_at = created_at
        self.user_id = user_id
        self.location = location
        self.updated_at = updated_at
        self.department = department
        self.name = name
    }
}