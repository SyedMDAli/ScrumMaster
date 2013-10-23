package com.neev.domain

class Release1 {
 
    String name
    String description
    String status
    java.sql.Date dateCreated
    java.sql.Date lastUpdated
    java.sql.Date endDate
    int userId
    
    Project project
    
     static hasMany = [ sprint : Sprint ]
     static belongsTo = [project : Project]
     
    static constraints = {
        endDate nullable:true
        
    }
    
     static mapping = {
        autoTimestamp false
        version false
        description type: "text"
    }
}