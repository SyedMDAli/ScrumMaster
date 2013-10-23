package com.neev.mainservice
import grails.transaction.Transactional
import com.neev.domain.Release1
import com.neev.domain.Project
import com.neev.domain.User
import com.neev.domain.*
import java.text.SimpleDateFormat
import org.slf4j.Logger
import org.slf4j.LoggerFactory

@Transactional
class ReleaseInfoService 
{       
    final Logger logger = LoggerFactory.getLogger(ReleaseInfoService.class)
    def userStoryInfoServices

    /*
     *Parameters : json with reease information and user
     *Functionality : add release into database 
     *Return : status of adding the release into database or failed message if something goes wrong
     */
    def add(def json , def user)
    {   
        logger.info("Enterd into add method of ReleaseInfoService")
        def project = Project.findById(json.pid)  
        def newRelease = new Release1()
        newRelease.name=json.name
        newRelease.description=json.descripition
        newRelease.status=json.status
        
        try
        {
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd")
            java.util.Date projectstartdate = sdf1.parse(project.dateCreated.toString())
            java.sql.Date sqlProjectStartDate = new java.sql.Date(projectstartdate.getTime())

            java.util.Date projectenddate = sdf1.parse(project.endDate.toString())
            java.sql.Date sqlProjectEndDate = new java.sql.Date(projectenddate.getTime())
     
            String startDate=json.startdate
            String endDate=json.enddate

            java.util.Date startdate = sdf1.parse(json.startdate)
            java.sql.Date sqlStartDate = new java.sql.Date(startdate.getTime());
            
            java.util.Date enddate = sdf1.parse(json.enddate)
            java.sql.Date sqlEndDate = new java.sql.Date(enddate.getTime());
            
            
            
            String str="Date Should be between "+sqlProjectStartDate.toString()+" and "+sqlProjectEndDate.toString()+""
            int x=sqlStartDate.compareTo(sqlEndDate)
            if(x<=0)
            {    
                if((startdate.after(projectstartdate) && enddate.before(projectenddate)||(startdate.compareTo(projectstartdate)>=0 && enddate.compareTo(projectenddate)<=0)))
                {    
                    newRelease.project=project
                    
                    newRelease.userId= user.id
                    newRelease.dateCreated=sqlStartDate
                    newRelease.endDate=sqlEndDate
                    newRelease.lastUpdated=sqlStartDate
                    if(newRelease.save())
                    {
                        def UserStoryString = json.userStorys
                        def myTemp = UserStoryString.split("-")
                        for(def i = 1 ; i < myTemp.length ; i++)
                        {
                            def userStory = UserStory.findById(myTemp[i])
                            userStory.release = Release1.findById(newRelease.id)
                        }
                        logger.info("Returning save from add methos of SprintInfoService")
                        return "save"
                    }
                    else
                    {
                        logger.info("Returning notSave from add method of ReleaseInfoService")
                        return "notSave"
                    }
                }
                else
                {
                    logger.info("Returning notMatch from add method of ReleaseInfoService")
                    return str
                }
            }
            else
            {
                logger.info("Returning dateNotCorrect from add method of ReleaseInfoService")
                return "dateNotCorrect"
            }
        }
        catch(Exception e)
        {       
            println e
        }
    }
   
    
    /*
     *Parameters : json with release information and user
     *Functionality : update the release information and save the same into database
     *Return : status of update int database or failed message if somethinf goes wrong
     */
    def update(def json , def user)
    {
        logger.info("Enterd into update method of ReleaseInfoService")
        def newRelease = Release1.findById(json.rid) 
        def project = newRelease.project
         
        newRelease.name=json.name
        newRelease.description=json.description
        
        try
        {
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
            
            java.util.Date projectstartdate = sdf1.parse(project.dateCreated.toString())
            java.sql.Date sqlProjectStartDate = new java.sql.Date(projectstartdate.getTime())      

            java.util.Date projectenddate = sdf1.parse(project.endDate.toString())
            java.sql.Date sqlProjectEndDate = new java.sql.Date(projectenddate.getTime())
            
            String startDate=json.startdate
            String endDate=json.enddate

            java.util.Date startdate = sdf1.parse(json.startdate)
            java.sql.Date sqlStartDate = new java.sql.Date(startdate.getTime())
            
            java.util.Date enddate = sdf1.parse(json.enddate)
            java.sql.Date sqlEndDate = new java.sql.Date(enddate.getTime())
           String str="Date Should be between "+sqlProjectStartDate.toString()+" and "+sqlProjectEndDate.toString()+""
 
            int x=sqlStartDate.compareTo(sqlEndDate)
            if(x<=0)
            {    
                if((startdate.after(projectstartdate) && enddate.before(projectenddate)||(startdate.compareTo(projectstartdate)>=0 && enddate.compareTo(projectenddate)<=0)))
                {              
                    newRelease.userId= user.id
                    newRelease.dateCreated=sqlStartDate
                    newRelease.endDate=sqlEndDate
                    newRelease.lastUpdated=sqlStartDate
                    
                    if(newRelease.save())
                    {
                        def UserStoryString = json.userStorys
                        def myTemp = UserStoryString.split("-")
                        for(def i = 1 ; i < myTemp.length ; i++)
                        {
                            def userStory = UserStory.findById(myTemp[i])
                            userStory.release = Release1.findById(newRelease.id)
                        }
                        logger.info("Returning save from add methos of SprintInfoService")
                        return "update"
                    }
                    else
                    {   
                        logger.info("Returning notUpdate from update method of ReleaseInfoService")
                        return "notUpdate"
                    }  
                }
                else
                {
                    logger.info("Returning notMatch from update method of ReleaseInfoService")
                    return str
                }
            }
            else
            {
                logger.info("Returning notValidDate from update method of ReleaseInfoService")
                return "notValidDate"
            }
        }
        catch(Exception e)
        {
            println e
            logger.info("Exception in update method of ReleaseInfoService")
        }         
    }
   
    /*
     *Parameters :
     *Functionality :
     *Return :
     */
    def get(def json)
    {  
        logger.info("Enterd into get method of ReleaseInfoService")
        def project=Project.findById(json.pid)
        List list = Release1.findAllByProject(project)
        logger.info("Returning list of releases from get method of ReleaseInfoService")
        return list
    }

    /*
     *Parameters : user and json with project id
     *Functionality : check if user has this project
     *Return : true if user has project, false otherwise 
     */
    boolean isHasProject(def user , def json)
    {
        logger.info("Enterd into isHasProject method of ReleaseInfoService")
        def pid = json.pid
        def project = Project.findById(pid)
        if(project.user==user)
        {
            logger.info("Returning true from isHasProject method of ReleaseInfoService")
            return true
        }
        logger.info("Returning false from isHasProject method of ReleaseInfoService")
        return false
    }
    
    /*
     *Parameters : json with release information and user
     *Functionality : 
     *Return :
     */
    def verifyRelease(def json , def user)
    {
        logger.info("Enterd into verifyRelease method of ReleaseInfoService")
        def user_id = user.id
        def release = Release1.findById(json.rid)
        if(release.userId == user_id)
        {
            logger.info("Returning true from verifyRelease method of ReleaseInfoService")
            return true
        }
        else
        {
            logger.info("Returning false from verifyRelease method of ReleaseInfoService")
            return false
        }
    }
    
    /*
     *Parameters :
     *Functionality :
     *Return :
     */
    def fetchUserStoryForRelease(def pid)
    {
        logger.info("Enterd into fetchUserStoryForRelease method of ReleaseInfoService")
        def project=Project.findById(pid)
        List list= UserStory.findAllByProjects(project)
        logger.info("Returning list of BAcklogs from fetchUserStoryForRelease method of ReleaseInfoService")
        return list
    }
    
    
    
    def getReleasesForSpecificProject(def json)
    {
        def project = Project.findById(json.project_id)
        def list = Release1.findAllByProject(project)
        return list
    }
}