//
//  Note.swift
//  MarkProject
//
//  Created by boehrer nicolas on 07/02/2020.
//  Copyright © 2020 Boehrer Nicolas. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Note{
    var title: String
    var content: String
    var date: String
    var local: CLLocation
    var photo: String
    
    
    init(title: String, content: String, date: String, photo: String) {
        self.title=title
        self.content=content
        self.date=date
        self.local=CLLocation(latitude: 47.6, longitude: 6.8)
        self.photo=photo
    }
    
    init(title: String, content: String, date: String, local: CLLocation, photo: String) {
        self.title=title
        self.content=content
        self.date=date
        self.local=local
        self.photo=photo
    }
}
