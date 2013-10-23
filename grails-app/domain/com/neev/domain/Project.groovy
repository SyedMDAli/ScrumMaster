package com.neev.domain

class Project {

    String name
    String description
    String status
    java.sql.Date dateCreated
    java.sql.Date lastUpdated
    java.sql.Date endDate
    
    User user
    static hasMany = [ release : Release1 ]
    static belongsTo = [user:User]
    
    static constraints = {
        endDate nullable:true
        
    }
    
    
    static mapping = {
        autoTimestamp false
        version false
        description type: "text"
    }
}