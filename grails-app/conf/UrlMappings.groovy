class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.${format})?"{
            constraints {
                // apply constraints here
            }
        }

        "/user"(controller: "users", parseRequest: true)
        {
              action = [GET: "getAllUsers"]
        }
        
        "/dashboardGetAssignTask"(controller: "dashboard", parseRequest: true)
        {
              action = [GET: "getAllAssignedTask"]
        }
        
        "/dashboardGetCreatedProject"(controller: "dashboard", parseRequest: true)
        {
              action = [GET: "getAllCreatedProject"]
        }
        
        "/dashboardUpdateAssignedTask"(controller: "dashboard", parseRequest: true)
        {
             action = [PUT : "updateAssignedTask"]
            
        }
        
        "/dashboardGetTaskStatus"(controller: "dashboard", parseRequest: true)
        {
             action = [GET : "getTaskStatus"]
            
        }
        
       "/project"(controller: "project", parseRequest: true)
        {
              action = [POST: "add" , PUT : "update" , GET: "get"]
        }
        
        "/AllUserStoryForSpecificProject"(controller: "userStory", parseRequest: true)
        {
              action = [GET: "getUserStoryForSpecificProject"]
        }
        
        "/updateUserStory"(controller: "userStory", parseRequest: true)
        {
              action = [PUT: "updateUserStory"]
        }
        "/fetchUserStorysForProject"(controller: "userStory", parseRequest: true)
        {
              action = [GET: "getfetchUserStorysForProject"]
        }
        "/release"(controller: "release", parseRequest: true)
        {
            action = [POST: "add" , PUT : "update", GET: "get"]      
        }
        
        "/ReleasesForSpecificProject"(controller: "release", parseRequest: true)
        {
            action = [GET: "getReleasesForSpecificProject"]      
        }
        
        "/sprint"(controller: "sprint", parseRequest: true)
        {
             action = [POST: "add" , PUT : "update" , GET: "get"]
           
        }
        
        "/SprintsForSpecificRelease"(controller: "sprint", parseRequest: true)
        {
             action = [GET: "getSprintsForSpecificRelease"]
           
        }
        
        "/task"(controller: "task", parseRequest: true)
        {
             action = [POST: "add" , PUT : "update" , GET: "get"]
            
        }
        "/fetchUsersForTask"(controller: "task", parseRequest: true)
        {
             action = [GET: "getAllUsers"]
            
        }
        
        "/UserStoryForSpecificRelease"(controller: "userStory", parseRequest: true)
        {
            action = [POST: "add" , PUT : "update" , GET: "getUserStoryForSpecificRelease"]
            
        }
        "/UserStoryForSpecificSprint"(controller: "userStory", parseRequest: true)
        {
            action = [GET: "getUserStoryForSpecificSprint"]
            
        }
        
        "/UserStoryForSpecificProject"(controller: "userStory", parseRequest: true)
        {
            action = [POST: "saveUserStoryForSpecificProject"]
            
        }
        
         "/updateProfile"(controller:"users",parseRequest: true)
        {
             action = [POST: "updateProfile"]
        }
        
        "/checkMailSignUp"(controller: "users", parseRequest: true)
        {
            action = [POST: "checkMailSignUp" , GET: "checkMailSignUp"]
            
        }
        
        "/fetchUserStoriesForSpecificSprint"(controller: "userStory", parseRequest: true)
        {
            action = [GET: "fetchUserStoriesForSpecificSprint"]
            
        }
        "/saveTaskFromReleaseBoard"(controller: "task", parseRequest: true)
        {
            action = [POST: "addTaskFromReleaseBoard"]
            
        }
        

        "/"(view:"/users/LoginPage")
        "500"(view:'/error')
	}   
}