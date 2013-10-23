package com.neev.mainservice

import grails.transaction.Transactional
import com.neev.domain.*
import org.slf4j.Logger
import org.slf4j.LoggerFactory

@Transactional
class DashboardInfoService
{
    final Logger logger = LoggerFactory.getLogger(DashboardInfoService.class)
    
    /*
     *Parameters : user
     *Functionality : find all the task assign to this user
     *Return : list of tasks that are been assigned
     */
    def getAllAssignedTask(def user)
    {
        logger.info("Entered into getAllAssignedTask method of DashboardInfoService")
        def list = Task.findAllByUser(user)
        logger.info("Returning list of tasks from getAllAssignedTask method of DashboardInfoService")
        return list
    }
    
    /*
     *Parameters : user
     *Functionality : find all projects created by this user
     *Return : list of projects created by this user
     */
    def getAllCreatedProject( def user )
    {
        logger.info("Entered into getAllCreatedProject method of DashboardInfoService")
        def list  = Project.findAllByUser(user)
        logger.info("Returning list of projects getAllCreatedProject method of DashboardInfoService")
        return list
    }
    
    
    /*
     *Parameters : json with task information
     *Functionality : update the task that has been assigned to some employee. This is done by employee.
     *                  He can update it to InProgress if it is started and Completed if it is in progress
     *Return : true or false depending on the flow of control ans status of update
     */
    boolean updateAssignedTask(def json)
    {     
        logger.info("Entered into updateAssignedTask method of DashboardInfoService")
        def task = Task.findById(json.task_id)
        task.status=json.status
        if( task.save() )
        {  
            logger.info("Task status is updated in updateAssignedTask method of DashboardInfoService")
            def tasks=Task.findAllBySprint(task.sprint) 
            def sprint_id
            boolean status=true
            for(t in tasks)
            {
                sprint_id=t.sprint
                if(t.status!="Completed")
                {
                    status=false
                    break
                }
            }
            if(status==true)
            {
                logger.info("All tasks of this particular srint are completed")
                def sprint=Sprint.findById(sprint_id.id)       
                sprint.status="Completed"
                if(sprint.save())
                {
                    boolean sprintStatus=true
                    def release= Release1.findById(sprint.release.id)
                    def sprints= Sprint.findByRelease(release)
                    for(s in sprints)
                    {
                        if(s.status!="Completed")
                        {
                            sprintStatus=false
                            break
                        }
                    }
                    if(sprintStatus==true)
                    {
                        logger.info("All sprints of this particular release are completed")
                        release.status="Completed"
                        if(release.save())
                        {
                            boolean releaseStatus=true
                            def project= Project.findById(release.project.id)
                            def releases= Release1.findByProject(project)
                            for(r in releases)
                            {
                                if(r.status!="Completed")
                                {
                                    releaseStatus=false
                                    break
                                }
                            }
                            if(releaseStatus==true)
                            {
                                logger.info("All releases of this particular project are completed")
                                project.status="Completed"
                                if(project.save())
                                {
                                    logger.info("Returning true from updateAssignedTask method of DashboardInfoService")
                                    return true
                                }
                            }
                            logger.info("Returning true from updateAssignedTask method of DashboardInfoService")
                            return true
                        }
                    }
                    return true     //return false because release is not changed
                }
            }
            else //if(status==false)          //if not all tasks are completed
            {
                if(task.status=="In Progress")       //if current task is updated to InProgress
                {
                    def sprint = Sprint.findById(task.sprint.id)  //sid sprintId
                    sprint.status="In Progress"
                    if(sprint.save())
                    {
                        def release=Release1.findById(sprint.release.id)
                        release.status="In Progress"
                        if(release.save())
                        {
                            def project= Project.findById(release.project.id)
                            project.status="In Progress"
                            if(project.save())
                            {
                                logger.info("Returning true from updateAssignedTask method of DashboardInfoService after updating the status of project")
                                return true
                            }
                            logger.info("Release status is updated to In Progress")
                        }
                        logger.info("Sprint status is updated to In Progress")
                    }
                }
                logger.info("Returning true from updateAssignedTask method of DashboardInfoService")
                return true
            }
        }
        else
        {
            logger.info("Returning false from updateAssignedTask method of DashboardInfoService")
            return false
        }
    }
    
    /*
     *Parameters : json with task information (taskId)
     *Functionality : get the status of task
     *Return : status of task
     */
    def getTaskStatus(def json)
    {
        logger.info("Entered into getTaskStatus method of DashboardInfoService")
        def Task = Task.findById(json.tid)
        def status = Task.status
        logger.info("Returning the status of task from getTaskStatus method of DashboardInfoService")
        return status
    }
}