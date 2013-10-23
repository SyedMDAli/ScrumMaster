package com.neev.controller

import grails.converters.*
import groovy.json.JsonBuilder
import com.neev.domain.*
import com.neev.mainservice.TaskInfoService
import com.neev.mainservice.*
import com.neev.userservice.*
import org.codehaus.groovy.grails.web.json.JSONArray
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class TaskController 
{
    final Logger logger = LoggerFactory.getLogger(TaskController.class)
    JsonBuilder builder = new JsonBuilder();
    def taskInfoService
    def commonUserValidationService
    def getUserService
    
    /*
     *Parameters : No Parameters
     *Functionality : 
     *Return :
    */
    def index() { }
    
    /*
     *Parameters : No Parameters
     *Functionality : Call add method of TaskInfoService
     *Return :
     */
    def add()
    {
        def json = request.JSON
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {    
            if(taskInfoService.isHasSprint(user,json))
            {
                def result = taskInfoService.add(json,user)
                if( result == "dateNotCorrect"  )
                {
                    builder.response(status:"End date should be greater than equal to start date", code:"600")
                    render builder.toString()
                }
                else if( result == "notSave" )
                {
                    builder.response(status:"please fill the mandatory field",code:"600");    
                    render builder.toString();
                }
                else if( result == "save" )
                {
                    builder.response(status:"Your data is save !",code:"200")
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
                builder.response(status:"user doesnt have this Sprint",code:"300")
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
     *Functionality : Call update method of TaskInfoService
     *Return :
     */
    def update()
    {
        println "In taskUpdate Controller"
        def json = request.JSON
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {
            def result = taskInfoService.update(json)
            if( result == "update" )
            {
                builder.response(status:"user authentication success and Data updated",code:"200")
                render builder.toString()
            }
            else if( result == "notUpdate" )
            {
                builder.response(status:"some information is wrong !!! data not updated",code:"600")
                render builder.toString()
            }
            
            else if( result == "notValidDate" )
            {
                builder.response(status:"your date is invalid",code:"600")
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
            builder.response(status:"user authentication fail",code:"500")
            render builder.toString()
        }
    }
    
    /*
     *Parameters : No Parameters
     *Functionality : Call get method of TaskInfoService
     *Return :
     */
    def get()
    {
        def json = params
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {   
            if(taskInfoService.isHasSprint(user,json))
            {   
                List list = taskInfoService.get(json) 
                JSONArray id = new JSONArray(list.id)
                JSONArray name = new JSONArray(list.name)
                JSONArray description = new JSONArray(list.description)
                JSONArray status = new JSONArray(list.status)
                JSONArray dateCreated = new JSONArray(list.dateCreated.toString())
                JSONArray lastUpdated = new JSONArray(list.lastUpdated.toString())
                JSONArray endDate = new JSONArray(list.endDate.toString())
                JSONArray assignTo = new JSONArray(list.user.email)
                JSONArray userStory = new JSONArray(list.userStory.name)
                builder.response("code": 200,"id": id,"name": name,"description":description, "status":status ,"dateCreated":dateCreated,"endDate":endDate,"lastUpdated":lastUpdated,"assignTo":assignTo,"userStory":userStory)
                render builder.toString()                  
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
     *Functionality : Call getAllUsers method of GetUserService if user exist with the sesionToken
     *Return :
     */
    def getAllUsers()
    {
        def json = params
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {
            List list = getUserService.getAllUsers()
            render list as JSON
        }
        else
        {
            builder.response(status:"user authentication fail",code:"500")
            render builder.toString()
        }   
    }
    
    def addTaskFromReleaseBoard()
    {
        def json = request.JSON
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {    
            
                def result = taskInfoService.addTaskFromReleaseBoard(json,user)
                if( result == "dateNotCorrect"  )
                {
                    builder.response(status:"End date should be greater than equal to start date", code:"600")
                    render builder.toString()
                }
                else if( result == "notSave" )
                {
                    builder.response(status:"please select sprint and user story!!!!!",code:"800");    
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
            builder.response(status:"user authentication fail",code:"500")
            render builder.toString()
       }
    }
}