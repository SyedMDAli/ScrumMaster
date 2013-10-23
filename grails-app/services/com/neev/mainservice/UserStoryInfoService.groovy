package com.neev.mainservice

import grails.transaction.Transactional
import com.neev.domain.*
import org.slf4j.Logger
import org.slf4j.LoggerFactory


@Transactional
class UserStoryInfoService 
{
    final Logger logger = LoggerFactory.getLogger(UserStoryInfoService.class)
    
    /*
     *Parameters : json with userStory information and user
     *Functionality : add the userStory into database
     *Return : true on successfully saving userStory into database, false otherwise 
     */
    boolean add(def json , def user)
    {   
        logger.info("Entered into add method of UserStoryInfoService")
        UserStory newUserStory = new UserStory()
        newUserStory.name=json.name
        newUserStory.description=json.description
        def project = Project.findById(json.project_id)
        def release = Release1.findById(json.release_id)
        def sprint = Sprint.findByName(json.sprint_name)
         println "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"+json.sprint_name
         println "+++++++++++++++++++++kamlesh++++++++++++++++++++++++++++++++++++++++++++"+sprint
        newUserStory.projects = project
        newUserStory.release = release
        newUserStory.sprint = sprint
        newUserStory.user=user
        if(newUserStory.save())
        {
            logger.info("Returning true from add method of UserStoryInfoService")
            return true
        }
        else
        {
            logger.info("Returning false from add method of UserStoryInfoService")
            return false   
        }
    }
   
    /*
     *Parameters : json with userStory information
     *Functionality : update the particular userStory
     *Return : true on successfully updating userStory, false otherwise
     */
    boolean update(def json)
    {
        logger.info("Entered into update method of UserStoryInfoService")
        def userStory = UserStory.findById(json.userStory_id)
        userStory.name=json.name
        userStory.description = json.description
        def sprint = Sprint.findByName(json.sprint_name) 
        userStory.sprint = sprint
        
        if(userStory.save())
        {   
            logger.info("Returning true from update method of UserStoryInfoService")
            return true 
        }
        else
        {
            logger.info("Returning false from update method of UserStoryInfoService")
            return false
        }
    }
   
    /*
     *Parameters : json with release information
     *Functionality : find userStory of particular release
     *Return : list of userStorys of particular release
     */
    def getUserStoryForSpecificRelease(def json)
    {
        logger.info("Entered into getUserStoryForSpecificRelease method of UserStoryInfoService")
        def release = Release1.findById(json.release_id)
        List list = UserStory.findAllByRelease(release)
        return list
    }
   
    /*
     *Parameters : json object with sprint information
     *Functionality : find sprints by sprintId
     *Return : list of userStory of the sprint 
     */
    def getUserStoryForSpecificSprint(def json)
    {
        logger.info("Entered into getUserStoryForSpecificSprint method of UserStoryInfoService")
        def sprint = Sprint.findById(json.sprint_id)
        List list = UserStory.findAllBySprint(sprint)
        return list
    }
 
    /*
     *Parameters : user, json with project information
     *Functionality : find project by project id and check it is created by this user
     *Return : true if project is created by user, false otherwise
     */
    //verification
    boolean isHasProject(def user , def json)
    {
        logger.info("Entered in isHasProject method of UserStoryInfoService")
        def project = Project.findById(json.project_id)
        if(project.user==user)
        {
            logger.info("Returning true from isHasProject method of UserStoryInfoService")
            return true
        }
        logger.info("Returning false from isHasProject method of UserStoryInfoService")
        return false
    }
    
    /*
     *Parameters : user, json with userStory information
     *Functionality : check if userStory is created by this user
     *Return : true if userStory is created by user, false otherwise
     */
    boolean isHasUserStory(def user , def json)
    {
        logger.info("Entered in isHasUserStory method of UserStoryInfoService")
        def userStory = UserStory.findById(json.userStory_id)
        if(userStory.user == user)
        {
            logger.info("Returning true from isHasUserStory method of UserStoryInfoService")
            return true
        }
        logger.info("Returning false from isHasUserStory method of UserStoryInfoService")
        return false
    }
    
    
    def saveUserStoryForSpecificProject(def json , def user)
    {
        logger.info("Entered into add method of UserStoryInfoService")
        UserStory newUserStory = new UserStory()
        newUserStory.name=json.name
        newUserStory.description=json.description
        def project = Project.findById(json.project_id)
        
        def release = Release1.findByName(json.release_name)
        def sprint = Sprint.findByName(json.sprint_name)
        newUserStory.projects = project
        newUserStory.release = release
        newUserStory.sprint = sprint
        newUserStory.user=user
        if(newUserStory.save())
        {
            logger.info("Returning true from add method of UserStoryInfoService")
            return true
        }
        else
        {
            logger.info("Returning false from add method of UserStoryInfoService")
            return false   
        }
    }
    
    
    def getUserStoryForSpecificProject(def json)
    {
        def project = Project.findById(json.project_id)
        def list = UserStory.findAllByProjects(project)
        return list
    }
    
   
    def updateUserStory(def json)
    {
        def userStory = UserStory.findById(json.userStory_id)
        userStory.release = Release1.findByName(json.release_name)
        userStory.sprint = Sprint.findByName(json.sprint_name)
        userStory.description = json.description
        userStory.name = json.name
    }
    
    def fetchUserStoriesForSpecificSprint(def json)
    {
        logger.info("Entered into fetchUserStoriesForSpecificSprint method of UserStoryInfoService")
        def sprint = Sprint.findByName(json.sprint_name)
        List list = UserStory.findAllBySprint(sprint)
        return list 
    }
}