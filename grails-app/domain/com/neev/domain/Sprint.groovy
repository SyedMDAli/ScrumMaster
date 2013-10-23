package com.neev.domain

class Sprint {
    
    String name
    String description
    String status
    java.sql.Date dateCreated
    java.sql.Date lastUpdated  
    java.sql.Date endDate
    int userId
    
    Release1 release
    
    static hasMany = [ task : Task ]
    static belongsTo = [ release : Release1 ]
    
    static constraints = {
        endDate nullable:true
        
    }
    
     static mapping = {
        autoTimestamp false
        version false
        description type: "text"
    }
}