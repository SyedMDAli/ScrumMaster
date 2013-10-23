package com.neev.mainservice

import grails.transaction.Transactional
import com.neev.domain.Project
import com.neev.domain.User
import java.text.SimpleDateFormat
import org.slf4j.Logger
import org.slf4j.LoggerFactory

@Transactional
class ProjectInfoService 
{
    final Logger logger = LoggerFactory.getLogger(ProjectInfoService.class)
    
    /*
     *Parameters : json with project information and user
     *Functionality : save the project details by verifying proper dates
     *Return : saved status of project or failed message if somthing goes wrong
     */
    def add(def json , def user)
    {
        logger.info("Entered into add method of ProjectInfoService")
        Project newProject = new Project()
        newProject.name=json.name
        newProject.description=json.description
        newProject.status=json.status
        
        try
        {
            String startDate=json.startdate
            String endDate=json.enddate
        
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
        
            java.util.Date startdate = sdf1.parse(json.startdate)
            java.sql.Date sqlStartDate = new java.sql.Date(startdate.getTime());  
             
            java.util.Date enddate = sdf1.parse(json.enddate)
            java.sql.Date sqlEndDate = new java.sql.Date(enddate.getTime());  
        
            int x=sqlStartDate.compareTo(sqlEndDate)
            if(x<=0)
            {
                logger.info("Start date is less than end date in add method of ProjectInfoService")
                newProject.dateCreated=sqlStartDate
                newProject.lastUpdated=sqlStartDate
                newProject.endDate=sqlEndDate
            }
            else
            {
                logger.info("Returning dateNotCorrect from add method of ProjectInfoService")
                return "dateNotCorrect"
            }
        }
        catch(Exception e)
        {
            logger.info("Exception in add method of ProjectInfoService")
            println e
        }  
        newProject.user=user
        
        if(newProject.save())
        {
            logger.info("Returning save from add method of ProjectInfoService")
            return "save"
        }
        else
        {
            logger.info("Returning notSave from add method of ProjectInfoService")
            return "notSave"  
        }
    }
   
   
    /*
     *Parameters : user
     *Functionality : get all projects of this user
     *Return : return all projects of this user
     */
    def get(def user)
    {  
        logger.info("Entered into get method of ProjectInfoService")
        List list = Project.findAllByUser(user)
        
        return list
    }
   
    
    /*
     *Parameters : user and json with project information
     *Functionality : update the project information
     *Return : status of update or failed message if something goes wrong
     */
    def update(def user , def json)
    {     
        logger.info("Entered into update method of ProjectInfoService")
        def newProject = Project.findById(json.project_id)
        newProject.name=json.name
        newProject.description=json.description
        
        try
        {
            String startDate=json.startdate
            String endDate=json.enddate 
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
        
            java.util.Date startdate = sdf1.parse(json.startdate) 
            java.sql.Date sqlStartDate = new java.sql.Date(startdate.getTime());  
              
            java.util.Date enddate = sdf1.parse(json.enddate)
            java.sql.Date sqlEndDate = new java.sql.Date(enddate.getTime());  
          
            int x=sqlStartDate.compareTo(sqlEndDate)
            if(x<=0)
            {
                logger.info("start date is less than end date in ProjectInfoService while adding project")
                newProject.dateCreated=sqlStartDate
                newProject.lastUpdated=sqlStartDate
                newProject.endDate=sqlEndDate
            }
            else
            {
                logger.info("Returning DateNotValid from update method of ProjectInfoService")
                return "DateNotValid"
            }
        }
        catch(Exception e)
        {
            logger.info("Exception in update method of ProjectInfoService")
            println e
        }
      
        newProject.user=user
        
        if(newProject.save())
        {
            logger.info("Returning update from update method of ProjectInfoService")
            return "update"
        }
        else
        {
            logger.info("Returning notUpdate from update method of ProjectInfoService")
            return "notUpdate"   
        }
    }
    
    /*
     *Parameters : user, json with project information
     *Functionality : verify if the user has this particular project or not
     *Return : true if user has this project, false otherwise
     */
    boolean isHasProject(def user , def json)
    {
        logger.info("Entered into isHasProject method of ProjectInfoService")
        def project = Project.findById(json.project_id)
        if(project.user==user)
        {
            logger.info("Returning true from isHasProject method of ProjectInfoService")
            return true
        }   
        logger.info("Returning false from isHasProject method of ProjectInfoService")
        return false
    }
}