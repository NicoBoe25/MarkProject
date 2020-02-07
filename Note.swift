//
//  Note.swift
//  MarkProject
//
//  Created by boehrer nicolas on 07/02/2020.
//  Copyright © 2020 Boehrer Nicolas. All rights reserved.
//

import Foundation

class Note{
    var title: String
    var content: String
    var date: String
    var local: String
    
    
    init(title: String, content: String, date: String, local: String) {
        self.title=title
        self.content=content
        self.date=date
        self.local=local
    }
}
