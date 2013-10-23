package com.neev.controller

import grails.converters.*
import groovy.json.JsonBuilder
import com.neev.domain.*
import com.neev.mainservice.ProjectInfoService
import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject
import com.neev.mainservice.*
import com.neev.userservice.*
import org.slf4j.Logger
import org.slf4j.LoggerFactory


class DashboardController {

    final Logger logger = LoggerFactory.getLogger(DashboardController.class)
    JsonBuilder builder = new JsonBuilder()
    def dashboardInfoService
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
     *Functionality : Call getAllAssignedTask method of DashboardInfoService
     *Return :
     */
    def getAllAssignedTask()
    {
       def json = params
       def user = commonUserValidationService.verifySessionToken(json.token)
       
       if(user)
       {
              List list = dashboardInfoService.getAllAssignedTask(user) 
              JSONArray id = new JSONArray(list.id)
              JSONArray name = new JSONArray(list.name)
              JSONArray description = new JSONArray(list.description)
              JSONArray status = new JSONArray(list.status)
              JSONArray dateCreated = new JSONArray(list.dateCreated.toString())
              JSONArray lastUpdated = new JSONArray(list.lastUpdated.toString())
              JSONArray endDate = new JSONArray(list.endDate.toString())
              JSONArray projectName = new JSONArray()
              for ( def i = 0 ; i < list.size() ; i++)
              {
                  def sprint = Sprint.findById(list.sprint.id[i])
                  def release = Release1.findById(sprint.release.id)
                  def project = Project.findById(release.project.id)
                  projectName[i] = project.name
              }
              builder.response("code": 200,"id": id,"name": name,"description":description ,"status":status ,"dateCreated":dateCreated,"endDate":endDate,"lastUpdated":lastUpdated,"projectName":projectName)
              render builder.toString()
       }
       else
       {
           builder.response(status:"user authentication fail",code:"500")
       }   
    }
    
    /*
     *Parameters : No Parameters
     *Functionality : Call getAllCreatedProject method of DashboardInfoService
     *Return :
    */
    def getAllCreatedProject()
    {
        def json = params
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {
            List list = dashboardInfoService.getAllCreatedProject(user) 
              
            JSONArray id = new JSONArray(list.id)
            JSONArray name = new JSONArray(list.name)
            JSONArray description = new JSONArray(list.description)
            JSONArray status = new JSONArray(list.status)
            JSONArray dateCreated = new JSONArray(list.dateCreated.toString())
            JSONArray lastUpdated = new JSONArray(list.lastUpdated.toString())
            JSONArray endDate = new JSONArray(list.endDate.toString())
            builder.response("code": 200,"id": id,"name": name,"status":status ,"description":description,"dateCreated":dateCreated,"endDate":endDate,"lastUpdated":lastUpdated)
            render builder.toString()
        }
        else
        {
            builder.response(status:"user authentication fail",code:"500")
        }   
    }
    
    
    /*
    *Parameters : No Parameters
    *Functionality : Call updateAssignedTask method of DashboardInfoService
    *Return :
    */
    def updateAssignedTask()
    {
        def json = request.JSON
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {       
            if( dashboardInfoService.updateAssignedTask(json) )
            {
                builder.response(status:"user authentication success and Data updated",code:"200")
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
     *Functionality : Call getTaskStatus method of DashboardInfoService
     *Return :
    */
    def getTaskStatus()
    {
        def json = params
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {
            def status = dashboardInfoService.getTaskStatus(json)              
            builder.response("code": 200,"taskStatus":status)
            render builder.toString()
        }
        else
        {
            builder.response(status:"user authentication fail",code:"500")      
        }
    }
}