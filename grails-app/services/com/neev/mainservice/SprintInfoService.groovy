package com.neev.mainservice

import grails.transaction.Transactional
import com.neev.domain.Sprint
import com.neev.domain.User
import com.neev.domain.*
import java.text.SimpleDateFormat
import org.slf4j.Logger
import org.slf4j.LoggerFactory

@Transactional
class SprintInfoService 
{
    final Logger logger = LoggerFactory.getLogger(SprintInfoService.class)
    
    /*
     *Parameters :
     *Functionality :
     *Return :
     */
    def add(def json , def user)
    {
        logger.info("Entered into add method of SprintInfoService")
        Sprint newSprint = new Sprint()
        
        newSprint.name=json.name
        newSprint.description=json.description
        newSprint.status=json.status
        
        def release = Release1.findById(json.rid)
        newSprint.release=release
        newSprint.userId= user.id
        try
        {
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd")
            java.util.Date releasestartdate = sdf1.parse(release.dateCreated.toString())
            java.sql.Date sqlReleaseStartDate = new java.sql.Date(releasestartdate.getTime())
            java.util.Date releaseenddate = sdf1.parse(release.endDate.toString())
            java.sql.Date sqlReleaseEndDate = new java.sql.Date(releaseenddate.getTime())
            String startDate=json.startdate
            String endDate=json.enddate
            
            java.util.Date startdate = sdf1.parse(json.startdate)
            java.sql.Date sqlStartDate = new java.sql.Date(startdate.getTime())
           
            java.util.Date enddate = sdf1.parse(json.enddate) 
            java.sql.Date sqlEndDate = new java.sql.Date(enddate.getTime())
            
            String str="Date Should be between "+sqlReleaseStartDate.toString()+" and "+sqlReleaseEndDate.toString()+""
            int x=sqlStartDate.compareTo(sqlEndDate)
            if(x<=0)
            {
                logger.info("Start date is less than end date in add methos of SprintInfoService")
                if((startdate.after(releasestartdate) && enddate.before(releaseenddate)||(startdate.compareTo(releasestartdate)>=0 && enddate.compareTo(releaseenddate)<=0)))
                {
                    newSprint.dateCreated=sqlStartDate
                    newSprint.lastUpdated=sqlStartDate
                    newSprint.endDate=sqlEndDate

                    if(newSprint.save())
                    {
                        def UserStoryString = json.userStorys
                        def myTemp = UserStoryString.split("-")
                        for(def i = 1 ; i < myTemp.length ; i++)
                        {
                            def userStory = UserStory.findById(myTemp[i])
                            userStory.sprint = Sprint.findById(newSprint.id)
                        }
                        logger.info("Returning save from add methos of SprintInfoService")
                        return "save"
                    }
                    else
                    {
                        logger.info("Returning notSave from add methos of SprintInfoService")
                        return "notSave"
                    }  
                }
                else
                {
                    logger.info("Returning notMatch from add methos of SprintInfoService")
                    return str
                }
            }
            else
            {
                logger.info("Returning dateNotCorrect from add methos of SprintInfoService")
                return "dateNotCorrect"
            }
        }
        catch(Exception e)
        {
            logger.info("Exception in add methos of SprintInfoService")
            println e
        }
   }
   
   /*
    *Parameters :
    *Functionality :
    *Return :
    */
   def update(def json , def user)
   {
        logger.info("Entered into update method of SprintInfoService")
        def newSprint = Sprint.findById(json.sid)
        def release = newSprint.release
        newSprint.name=json.name
        newSprint.description=json.description
        newSprint.userId= user.id
        try
        {
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd")
            
            java.util.Date releasestartdate = sdf1.parse(release.dateCreated.toString())
            java.sql.Date sqlReleaseStartDate = new java.sql.Date(releasestartdate.getTime())

            java.util.Date releaseenddate = sdf1.parse(release.endDate.toString())
            java.sql.Date sqlReleaseEndDate = new java.sql.Date(releaseenddate.getTime())

            String startDate=json.startdate
            String endDate=json.enddate
            
            java.util.Date startdate = sdf1.parse(json.startdate)
            java.sql.Date sqlStartDate = new java.sql.Date(startdate.getTime())
           
            
            java.util.Date enddate = sdf1.parse(json.enddate)
            java.sql.Date sqlEndDate = new java.sql.Date(enddate.getTime())
            String str="Date Should be between "+sqlReleaseStartDate.toString()+" and "+sqlReleaseEndDate.toString()+""

            int x=sqlStartDate.compareTo(sqlEndDate)
            
            if(x<=0)
            {
               
                if((startdate.after(releasestartdate) && enddate.before(releaseenddate)||(startdate.compareTo(releasestartdate)>=0 && enddate.compareTo(releaseenddate)<=0)))
                {
                    newSprint.dateCreated=sqlStartDate
                    newSprint.lastUpdated=sqlStartDate
                    newSprint.endDate=sqlEndDate   
                    
                    if(newSprint.save())
                    {
                        def UserStoryString = json.userStorys
                        def myTemp = UserStoryString.split("-")
                        for(def i = 1 ; i < myTemp.length ; i++)
                        {
                            def userStory = UserStory.findById(myTemp[i])
                            userStory.sprint = Sprint.findById(newSprint.id)
                        }
                        logger.info("Returning save from add methos of SprintInfoService")
                        return "update"
                    }
                    else
                    {
                        logger.info("Returning notUpdate from update method of SprintInfoService")
                        return "notUpdate"
                    }  
                }
                else
                {
                    logger.info("Returning notMatch from update method of SprintInfoService")
                    return str
                }
            }
            else
            {
                logger.info("Returning notValidDate from update method of SprintInfoService")
                return "notValidDate"
            }
        }
        catch(Exception e)
        {
            println e
            logger.info("Exception in update method of SprintInfoService")
        }
    }
    
    /*
     *Parameters :
     *Functionality :
     *Return :
     */
    def get(def json)
    {  
        logger.info("Entered into get method of SprintInfoService")
        def release=Release1.findById(json.rid)
        List list = Sprint.findAllByRelease(release)
        logger.info("Returning list of sprints from get method of SprintInfoService")
        return list
    }
  
    /*
     *Parameters :
     *Functionality :
     *Return :
     */
    //varification all
    boolean isHasRelease(def user , def json)
    {  
        logger.info("Entered into isHasRelease method of SprintInfoService")
        def release = Release1.findById(json.rid)
        if(release.userId==user.id)
        {
            logger.info("Returning true from isHasRelease method of SprintInfoService")
            return true
        }
        logger.info("Returning false from isHasRelease method of SprintInfoService")
        return false
    }
    
    
    
   /*
    *Parameters :
    *Functionality :
    *Return :
    */
    boolean isHasSprint(def user,def json)
    {
        logger.info("Entered into isHasSprint method of SprintInfoService")
        def sprint = Sprint.findById(json.sid)
        if(sprint.userId==user.id)
        {
            logger.info("Returning true from isHasSprint method of SprintInfoService")
            return true
        }
        logger.info("Returning false from isHasSprint method of SprintInfoService")
        return false
    } 
    
    def getSprintsForSpecificRelease(def json)
    {
        def releaseName = Release1.findByName(json.release_name)
        println "*************************************************"+releaseName
        def list = Sprint.findAllByRelease(releaseName)
        return list
    }
}