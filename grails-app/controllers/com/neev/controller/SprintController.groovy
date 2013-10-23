package com.neev.controller

import grails.converters.*
import groovy.json.JsonBuilder
import com.neev.domain.Sprint
import com.neev.domain.User
import com.neev.mainservice.SprintInfoService
import org.codehaus.groovy.grails.web.json.JSONArray
import com.neev.mainservice.*
import com.neev.userservice.*
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class SprintController {

    final Logger logger = LoggerFactory.getLogger(SprintController.class)
    JsonBuilder builder = new JsonBuilder();
    def sprintInfoService
    def commonUserValidationService
    
    /*
     *Parameters : No Parameters
     *Functionality :
     *Return :
    */
    def index() 
    {
       
    }
    
    /*
     *Parameters : No Parameters
     *Functionality : Call add method of SprintInfoService
     *Return :
    */
    def add()
    {
        def json = request.JSON
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {   
            if(sprintInfoService.isHasRelease(user,json))
            {   
                def result = sprintInfoService.add(json,user)
                if( result == "dateNotCorrect"  )
                {
                    builder.response(status:"End date should be greater than equal to start date", code:"600")
                    render builder.toString()
                }
                else if( result == "notSave" )
                {
                    builder.response(status:"Your data is not save .!!!!! some information is wrong !!!!!",code:"400");    
                    render builder.toString();
                }
                else if( result == "save" )
                {
                    builder.response(status:"Your data is save !!!!!",code:"200")
                    render builder.toString()
                } 
                else
                {
                    builder.response(status:result,code:"300")
                    render builder.toString()
                }  
            }
            
            else
            {
                builder.response(status:"user doesnt have this release",code:"200")
                render builder.toString()
            }
    }
        else
        {
           builder.response(status:"user authentication fail",code:"500")
           render builder.toString()
        }
    }
    
    /*
     *Parameters : No Parameters
     *Functionality : Call update method of SprintInfoService
     *Return :
     */
    def update()
    {
        def json = request.JSON
        def user = commonUserValidationService.verifySessionToken(json.token)
        
        if(user)
        {   
            if(sprintInfoService.isHasSprint(user,json))
            {
                def result = sprintInfoService.update(json , user)
                println result
                if( result == "update" )
                {
                    builder.response(status:"user authentication success and Data updated",code:"200");    
                    render builder.toString();
                }
                else if( result == "notUpdate" )
                {
                    builder.response(status:"some information is wrong !!! data not updated",code:"600");    
                    render builder.toString();
                }
                
                else if( result == "notValidDate" )
                {
                    builder.response(status:"your date is invalid",code:"600");    
                    render builder.toString();
                }  
                   else
            {
                builder.response(status:result,code:"300")
                render builder.toString()
            }
            }
            else
            {
                builder.response(status:"user doesnt have this sprint",code:"200")
                render builder.toString()
            }
        }
        else
        {
            builder.response(status:"user authentication fail",code:"500")
            render builder.toString()
        }
    }
    
    /*
     *Parameters : No Parameters
     *Functionality : Call get method of SprintInfoService
     *Return :
    */
    def get()
    {
        def json = params
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {   
            if(sprintInfoService.isHasRelease(user,json))
            {   
                List list = sprintInfoService.get(json)
                JSONArray id = new JSONArray(list.id)
                JSONArray name = new JSONArray(list.name)
                JSONArray description = new JSONArray(list.description)
                JSONArray status = new JSONArray(list.status)
                JSONArray dateCreated = new JSONArray(list.dateCreated.toString())
                JSONArray lastUpdated = new JSONArray(list.lastUpdated.toString())
                JSONArray endDate = new JSONArray(list.endDate.toString())
                builder.response("code": 200,"id": id,"name": name,"description": description ,"status":status ,"dateCreated":dateCreated,"endDate":endDate,"lastUpdated":lastUpdated)
                render builder.toString()
            }
            else
            {
                builder.response(status:"user doesnt have this release",code:"200")
                render builder.toString()
            }
        }
        else
        {
            builder.response(status:"user authentication fail",code:"500")
            render builder.toString()
        }   
    }
    
    
    def getSprintsForSpecificRelease()
    {
        def json = params
        def user = commonUserValidationService.verifySessionToken(json.token)
        println "****************************************************************************"
        if(user)
        {   
               
                List list = sprintInfoService.getSprintsForSpecificRelease(json)
                println list
                JSONArray id = new JSONArray(list.id)
                JSONArray name = new JSONArray(list.name)
               
                builder.response("code": 200,"id": id,"name": name)
                render builder.toString()
           
        }
        else
        {
            builder.response(status:"user authentication fail",code:"500")
            render builder.toString()
        }   
    }
}