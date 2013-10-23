package com.neev.domain

class User {

    String email
    String name
    String password
    String status
    java.sql.Date dateCreated
    java.sql.Date lastUpdated 
    String verify_code_for_signIn
    String forgotPassword_token
    String session_token
    
    static hasMany = [ task : Task, project : Project ]
    
    static constraints = 
    {
      email( nullable:false , minSize:1 , maxSize:50 , unique: true)
      name( nullable:false , minSize:3 , maxSize:50)
      password( nullable:false , minSize:6 , maxSize:25)
      verify_code_for_signIn( nullable:false )
      forgotPassword_token( nullable:true )
      session_token( nullable:true )  
    }
    
    static mapping = {
        version false
    }
}