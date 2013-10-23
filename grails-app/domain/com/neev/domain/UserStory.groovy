package com.neev.domain

class UserStory {
     String name
     String description
     Project projects
     User user
     Release1 release
     Sprint sprint
     
     static hasMany = [ task : Task ]
         
     static constraints = {
         sprint nullable:true 
         release nullable:true
        
     }
     
     static mapping = {
        version false
        description type: "text"
    }
}