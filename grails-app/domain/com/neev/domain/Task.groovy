package com.neev.domain

class Task {
    String name
    String description
    String status
    java.sql.Date dateCreated
    java.sql.Date lastUpdated  
    java.sql.Date endDate
    
    Sprint sprint
    User user
    UserStory userStory
    
    static belongsTo = [ sprint : Sprint , user:User , userStory : UserStory]
   
    static constraints = {
        endDate nullable:true
        user nullable:true
    }
    
     static mapping = {
        autoTimestamp false
        version false
        description type: "text"
    }
}