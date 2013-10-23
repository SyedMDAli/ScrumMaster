<!DOCTYPE html>
<html data-ng-app="iceScrumApp">
  <head>
    <title>SCRUM MASTER</title>

    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/themes/base/jquery-ui.css" type="text/css" media="all" /> 
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.5.min.js" type="text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.min.js" type="text/javascript"></script>

    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <link href="bootstrap-3.0.0/dist/css/bootstrap.css" rel="stylesheet">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>


    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <!--linking with angular file -->
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js"></script>
    <script src="http://code.angularjs.org/1.2.0-rc.2/angular-animate.min.js"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">


    <link rel="stylesheet" href="${resource(dir: 'css', file: 'commonDivStyle.css')}" type="text/css">
    <script src="${resource(dir: 'js', file: 'jquery-2.0.3.js')}"></script>
    <script src="${resource(dir: 'js', file: 'datepicker.js')}"></script>
    <script src="${resource(dir: 'js', file: 'bootstrap-datepicker.js')}"></script>

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.0.8/angular.min.js"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'angular-flash.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.js')}"></script>
  </head>

  <body>

    <!-- for user authentication-->
    <input type="hidden" id="token" value="${params.sessionToken}"/> 


    <!-- Header Part Start here-->
    <div class="wrapper"  style="margin-top:0%;margin-left:0%;background: #3B5998">
      <div class="container pull-left" ><label class="newStyle">Hi ${params.username}</label></div>
      <div class="container pull-left" ><h3 style="color:white"></h3>
      </div>
      <div class="container pull-right" style="margin-right:-1.2%; background-color:  #3B5998">
        <ul class="menu">

          <li><a href="#/dashboardFetch"><button type="button" class="btn btn-link" style="color:#FFFFFF">My Dashboard</button></a></li>
          <li><a href="#/myAccount/${params.username}/${params.email}"><button type="button" class="btn btn-link" style="color:#FFFFFF;">My Account</button></a></li>
          <li><a href="http://localhost:8080/iceScrum/users/signOut?token=${params.sessionToken}"><button type="button" class="btn btn-link" style="color:#FFFFFF;"><i class="icon-white icon-off">Log Out</i></button></a></li>
        </ul>
      </div>
    </div> 
    <!-- Header Part End here-->


    <br><br><br>

    <!-- Changing DIV -->    

    <div ng-view></div>
    <!-- Route configuration -->

     

    <script> 
       var scrumApp = angular.module("iceScrumApp", ['angular-flash.flash-alert-directive']);          
       scrumApp.config(function ($routeProvider){
              $routeProvider
                
              // view and controller mapping for updateAccount---------------------------
              .when('/myAccount/:username/:email',
              {   
                  controller: 'myAccountController',
                  templateUrl: "${resource(dir: 'gspPages', file: 'myAccount.html')}"
              })
                
                
              // new UI is start from here  -----------------------------------------------------
              // for dashboard controller-----------------------------------------------------    
              // view and controller mapping for Dashboard----------------------------------
              .when('/dashboardFetch',
              {   
                  controller: 'dashboardController',
                  templateUrl: "${resource(dir: 'gspPages', file: 'dashboardFetch.html')}"
              })
                
              .when('/releaseBoard/:projectId/:projectName',
              {   
                  controller: 'releaseBoardController',
                  templateUrl: "${resource(dir: 'gspPages', file: 'releaseBoard.html')}"
              })
              .when('/sprintBoard/:releaseId/:releaseName/:projectId/:projectName',
              {   
                  controller: 'sprintBoardController',
                  templateUrl: "${resource(dir: 'gspPages', file: 'sprintBoard.html')}"
              })
              .when('/taskBoard/:sprintId/:sprintName/:releaseId/:releaseName/:projectId/:projectName',
              {   
                  controller: 'taskBoardController',
                  templateUrl: "${resource(dir: 'gspPages', file: 'taskBoard.html')}"
              })
                               
              // default page load 
              .otherwise( {redirectTo: '/dashboardFetch'} );
          }
      );
 
 
        // angular js controller----------------------------------------------------------->
          
         //nitya
          scrumApp.filter('startFrom', function() {
    return function(input, start) {
        start = +start; //parse to int
        return input.slice(start);
    }
});

          
          //myAccount controller for user
          function myAccountController($routeParams,$scope,$http,flash){
              
               var sessionToken = document.getElementById("token")
               this.params = $routeParams;
               $scope.username = this.params.username
                $scope.email = this.params.email
               $scope.changepassword=function(){
                       var temp = '{token='+sessionToken.value+',oldpassword='+$scope.old+',newpassword='+$scope.news+'}'
                
                     $http.post("http://localhost:8080/iceScrum/updateProfile",temp).success(function(data,status,headers,config){
                                 // alert(data.response.status);
                                  //flash.success=data.response.status
                                  if(data.response.code == 200)
                                    {
                                      location.reload()
                                    }
                                   else 
                                           flash.success=data.response.status
                      }).error(function(data,status,headers,config){
                                      alert("Data is not valid !!!!!!!")
                      });
                        
                } 
                          

          }
            
           
          // new controller ---------------------------------------------------------------------------------------
          //dashboard controller for fetch and save and update the data on server
          function dashboardController($location,$routeParams,$scope,$http,flash){
                 
               var sessionToken = document.getElementById("token")
             
               var newArrayColor1 = new Array();
               var newArrayColor2 = new Array();
               var newArrayColor3 = new Array();
          
               var count1 = 0
               var count2 = 0
               var count3 = 0
                 
                 
               // fetch all the tasks which are assigned to this perticular user ----------
               $scope.fetchAssignedTasks = function() {
                       
                     

                     $http.get("http://localhost:8080/iceScrum/dashboardGetAssignTask", {
                                        params: { token: sessionToken.value  }
                      }).success(function(data,status,headers,config){
                               
                                    
                             if( data.response.code == 200)
                               {   
                                   for(var i=0 ; i < data.response.id.length ; i++)
                                   {
                                      if( data.response.status[i] == "Todo")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i],"projectName":data.response.projectName[i]};
                                          newArrayColor1[count1++]= temp
                                       }
                                       else if( data.response.status[i] == "In Progress")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i],"projectName":data.response.projectName[i]};
                                          newArrayColor2[count2++]= temp
                                       }
                                       else if( data.response.status[i] == "Completed")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i],"projectName":data.response.projectName[i]};
                                          newArrayColor3[count3++]= temp
                                       }
                                               
                                   }
                                     
                                   $scope.ArrayColor1 = newArrayColor1
                                   $scope.ArrayColor2 = newArrayColor2
                                   $scope.ArrayColor3 = newArrayColor3
                                   
                               }
             
            
                      }).error(function(data,status,headers,config){
                                      //flash.error="fetching error in assigned task list"
                                      alert("fetching error in assigned task list")
                      });

                   }
                     
                     
                     
                  var projectsName1 = new Array();
                  var projectsName2 = new Array();
                  var projectsName3 = new Array();

                  var count4 = 0
                  var count5 = 0
                  var count6 = 0
                     
                     
                   // fetch all created project for specific user ----------------------            
                  $scope.fetchCreatedProject = function() {
                     $scope.currentPage = 0;
                     $scope.pageSize = 10; 

                    
                     $http.get("http://localhost:8080/iceScrum/dashboardGetCreatedProject", {
                                        params: { token: sessionToken.value  }
                      }).success(function(data,status,headers,config){
                               
                                       
                             if( data.response.code == 200)
                               {$scope.length=data.response.id.length
                                
                               $scope.numberOfPages=Math.ceil($scope.length/$scope.pageSize)


                                    //nitya
                                   // flash.success="in dashboard"
                                     
                                   for(var i=0 ; i < data.response.id.length ; i++)
                                   {
                                      if( data.response.status[i] == "Todo")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"desc": data.response.description[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName1[count4++]= temp
                                            
                                       }
                                       else if( data.response.status[i] == "In Progress")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"desc": data.response.description[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName2[count5++]= temp
                                       }
                                       else if( data.response.status[i] == "Completed")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"desc": data.response.description[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName3[count6++]= temp
                                       }
                                               
                                   }
                                    
                                   $scope.ArrayProject1 = projectsName1
                                   $scope.ArrayProject2 = projectsName2
                                   $scope.ArrayProject3 = projectsName3
                                   
                               }
             
             
            
                      }).error(function(data,status,headers,config){
                                      alert("fetching error in project list")
                                     // flash.success="fetching error in project list"
                                     
                      });

                   }
                     
                    
                   // save the project for this user who is manager of this project --------------
                   $scope.projectStatus = "Todo"
                   $scope.saveProject = function() {
                   var desc= "'"+$scope.projectDescription+"'"
                     
                      
                      var temp = '{token='+sessionToken.value+',name='+$scope.projectName+',description='+desc+',status='+$scope.projectStatus+',startdate='+$scope.projectStartDate+',enddate='+$scope.projectEndDate+'}'

                     $http.post("http://localhost:8080/iceScrum/project",temp).success(function(data,status,headers,config){
                                    
                                    
                                  if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    else
                                      flash.success=data.response.status

                      }).error(function(data,status,headers,config){
                                      alert("Data is not valid !!!!!!!")
                      });
                        
                } 
    
                         
   
                // first fetch the data for update the project   --------------------------------------------------  
                $scope.FetchDataForUpdateProject = function(project_id,name,desc,startDate,endDate) {
                    
                  $scope.projectId = project_id
                  $scope.projectName = name
                  $scope.projectDescription = desc
                  $scope.projectStartDate = startDate
                  $scope.projectEndDate = endDate
          
                } 
   
                // update the project which are created by this perticular user      --------------------------
                $scope.updateProject = function() {
                      
                     var desc= "'"+$scope.projectDescription+"'"
                     var temp = '{token='+sessionToken.value+',project_id='+$scope.projectId+',name='+$scope.projectName+',description='+desc+',startdate='+$scope.projectStartDate+',enddate='+$scope.projectEndDate+'}'
                        
                       
                     $http.put("http://localhost:8080/iceScrum/project",temp).success(function(data,status,headers,config){
                         
                                   if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    else
                                      alert(data.response.status)
                                          
                            }).error(function(data,status,headers,config){
                                            alert("Error"+data)
                            });
                        
                } 
                   
                  
                // first fetch the data for update the task which are assigned to this perticular user   --------------------------------------------------  
                  
                $scope.FetchDataForUpdateTask = function(task_id,name,desc,startDate,endDate) {         
                  var taskStatusArray = new Array();
                  $scope.taskId = task_id
                  $scope.taskName = name
                  $scope.taskDescription = desc
                  $scope.taskStartDate = startDate
                  $scope.taskEndDate = endDate
                  //check the task status ----------------------------------------------
                   $http.get("http://localhost:8080/iceScrum/dashboardGetTaskStatus", {
                                        params: { token: sessionToken.value , tid: task_id }
                      }).success(function(data,status,headers,config){
                               
                                       
                             if( data.response.code == 200)
                               {
                                     
                                    if(data.response.taskStatus == "Todo")
                                    {
                                      $scope.taskStatus = "Todo"
                                      taskStatusArray[0] = "In Progress"
                                      taskStatusArray[1] = "Todo"
                                        
                                    }
                                    else if(data.response.taskStatus == "In Progress")
                                    {
                                      $scope.taskStatus = "In Progress"
                                      taskStatusArray[0] = "Completed"
                                      taskStatusArray[1] = "In Progress"
                                        
                                    }
                                    else if(data.response.taskStatus == "Completed")
                                    {
                                      $scope.taskStatus = "Completed"
                                      taskStatusArray[0] = "Completed"
                                    }
                                   
                                 $scope.myTaskStatusCheckArray = taskStatusArray
                               }
             
                               
            
                      }).error(function(data,status,headers,config){
                                      alert("fetching error for task status")
                      });
          
          
                } 
                  
                 // update the task which are assigned to this user who is logg on      -------------------------
                $scope.updateTask = function() {
           
                   var temp = '{token='+sessionToken.value+',task_id='+$scope.taskId+',status='+$scope.taskStatus+',enddate='+$scope.taskEndDate+'}'

                     $http.put("http://localhost:8080/iceScrum/dashboardUpdateAssignedTask",temp).success(function(data,status,headers,config){
                                    if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    else
                                      alert(data.response.status)
                      }).error(function(data,status,headers,config){
                                      alert("Error")
                      });
                        
                } 
                  
     
              }
               // dashboardController.$inject = ['flash'];
                
                
               // new one     
              // releaseBoard controller ------------------------------------------------
              function releaseBoardController($location,$routeParams,$scope,$http,flash){
                 
               var sessionToken = document.getElementById("token")
             
               this.params = $routeParams;
               var project_id = this.params.projectId 
                 
               $scope.projectNAME =this.params.projectName
               $scope.projectID = project_id
                 
               var newArrayColor1 = new Array();
               var newArrayColor2 = new Array();
               var newArrayColor3 = new Array();
          
               var count1 = 0
               var count2 = 0
               var count3 = 0
                 
                 
               // fetch all the releases which are created by this perticular user ----------
               $scope.fetchCreatedReleases = function() {
                       
                          $http.get("http://localhost:8080/iceScrum/release", {
                                             params: { token: sessionToken.value , pid: project_id }
                         }).success(function(data,status,headers,config){

                               if( data.response.code == 200)
                               {
                                   
                                     
                                   for(var i=0 ; i < data.response.id.length ; i++)
                                   {
                                      if( data.response.status[i] == "Todo")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          newArrayColor1[count1++]= temp
                                       }
                                       else if( data.response.status[i] == "In Progress")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          newArrayColor2[count2++]= temp
                                       }
                                       else if( data.response.status[i] == "Completed")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          newArrayColor3[count3++]= temp
                                       }
                                               
                                   }
                                     
                                   $scope.ArrayColor1 = newArrayColor1
                                   $scope.ArrayColor2 = newArrayColor2
                                   $scope.ArrayColor3 = newArrayColor3
                                   
                               }
                                  
             
                          }).error(function(data,status,headers,config){
                                           alert("fetching error")

                          });

                       
                   }
    
                  var projectsName1 = new Array();
                  var projectsName2 = new Array();
                  var projectsName3 = new Array();

                  var count4 = 0
                  var count5 = 0
                  var count6 = 0
                     
                  // fetch all created project for specific user ----------------------            
                  $scope.fetchCreatedProject = function() {
                      
                    
                     $http.get("http://localhost:8080/iceScrum/dashboardGetCreatedProject", {
                                        params: { token: sessionToken.value  }
                      }).success(function(data,status,headers,config){
                               
                                       
                             if( data.response.code == 200)
                               {
                                   $scope.currentPage = 0;
                                    $scope.pageSize = 10; 

  
                                   for(var i=0 ; i < data.response.id.length ; i++)
                                   { $scope.length=data.response.id.length
                                     // alert($scope.length)
                                       $scope.numberOfPages=Math.ceil($scope.length/$scope.pageSize)

                                      if( data.response.status[i] == "Todo")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName1[count4++]= temp
                                            
                                       }
                                       else if( data.response.status[i] == "In Progress")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName2[count5++]= temp
                                       }
                                       else if( data.response.status[i] == "Completed")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName3[count6++]= temp
                                       }
                                               
                                   }
                                    
                                   $scope.ArrayProject1 = projectsName1
                                   $scope.ArrayProject2 = projectsName2
                                   $scope.ArrayProject3 = projectsName3
                                   
                               }
             
            
                      }).error(function(data,status,headers,config){
                                      alert("fetching error in project list")
                      });

                   }
                   // fetch all the userStory for perticular project
                   // fetch the userStory according to specific project
                  var UserStoryforProject = new Array(); 
                  var countUserStoryforProject = 0
                    
                  $scope.fetchUserStorysForProject= function(){
                         
                         $http.get("http://localhost:8080/iceScrum/fetchUserStorysForProject", {
                                             params: { token: sessionToken.value , project_id: project_id}
                         }).success(function(data,status,headers,config){
                                          if(data.response.code == 200)
                                          {
                                               for(var i=0 ; i < data.response.id.length ; i++)
                                               {
                                                       
                                                         var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i]};
                                                         UserStoryforProject[countUserStoryforProject++]= temp
                                                       
                                               }
                                                 
                                               $scope.UserStoryforProject = UserStoryforProject
                                            
                                                   
                                          }
                                        
                                       
                          }).error(function(data,status,headers,config){
                                           alert("Error"+data)

                          });

                     } 
                    
                   // save the release for this user who is manager of this project --------------
                   $scope.releaseStatus = "Todo"
                   $scope.saveRelease = function() {
                        var desc= "'"+$scope.releaseDescription+"'"
                     var userStoryArrayString = "0-";
                     for(var i=0 ; i<$scope.selectedUserStorys.length ; i++)
                     { 
                         userStoryArrayString += $scope.selectedUserStorys[i].id
                         if (i !=$scope.selectedUserStorys.length-1){
                          userStoryArrayString += "-";
                         }
                     }
                     var temp = '{token='+sessionToken.value+',pid='+project_id+',name='+$scope.releaseName+',descripition='+desc+',status='+$scope.releaseStatus+',startdate='+$scope.releaseStartDate+',enddate='+$scope.releaseEndDate+',userStorys='+userStoryArrayString+'}'

                     $http.post("http://localhost:8080/iceScrum/release",temp).success(function(data,status,headers,config){
                                  if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    else if (data.response.code == 300 || data.response.code == 600 )
                                           flash.success=data.response.status
                                  // alert(data.response.status)
                      }).error(function(data,status,headers,config){
                                      alert("Data is not valid !!!!!!!")
                      });
                        
                }
                                 
                  
                 // first fetch the data for update the release   --------------------------------------------------  
                $scope.FetchDataForUpdateRelease = function(release_id,name,desc,startDate,endDate) {
                    
                  $scope.releaseId = release_id
                  $scope.releaseName = name
                  $scope.releaseDescription = desc
                  $scope.releaseStartDate = startDate
                  $scope.releaseEndDate = endDate
          
                } 
   
                // update the release which are created by this perticular user      --------------------------
                 $scope.updateRelease = function() {
                     var desc= "'"+$scope.releaseDescription+"'"
                     var userStoryArrayString = "0-";
                     for(var i=0 ; i<$scope.selectedUserStorys.length ; i++)
                     { 
                         userStoryArrayString += $scope.selectedUserStorys[i].id
                         if (i !=$scope.selectedUserStorys.length-1){
                          userStoryArrayString += "-";
                         }
                     }
                       
                    
                     var temp = '{token='+sessionToken.value+',rid='+$scope.releaseId+',name='+$scope.releaseName+',description='+desc+',startdate='+$scope.releaseStartDate+',enddate='+$scope.releaseEndDate+',userStorys='+userStoryArrayString+'}'


                     $http.put("http://localhost:8080/iceScrum/release",temp).success(function(data,status,headers,config){
                                  if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    
                                      else if(data.response.code == 300)
                                    flash.success=data.response.status
                      }).error(function(data,status,headers,config){
                                      alert("Error")
                      });
                        
                }   
                   
                 // work in progress------------
                 // fetch all releases for perticular project -----------
                 var releasesArray = new Array();
                 var countRelease = 0
                   
                 $scope.fetchReleasesForSpecificProject= function(){
                         
                           
                         $http.get("http://localhost:8080/iceScrum/ReleasesForSpecificProject", {
                                             params: { token: sessionToken.value , project_id: project_id}
                         }).success(function(data,status,headers,config){
                                          if(data.response.code == 200)
                                          {
                                               for(var i=0 ; i < data.response.id.length ; i++)
                                               {
                                                       

                                                         var temp = {"id": data.response.id[i] , "name":data.response.name[i]};
                                                         releasesArray[countRelease++]= temp

                                                        
                                               }
                                                 
                                               $scope.availableRelease = releasesArray
                                                
                                                   
                                          }
                                        
                                       
                          }).error(function(data,status,headers,config){
                                           alert("Error"+data)

                          });
                            
                       

                     } 
                       
                       
                 //fetch all sprints for perticular release -----------
                   
                 $scope.fetchSprintsForSpecificRelease= function(){
                          var release_name = $scope.selectedRelease
                            
                          var sprintArray = new Array();
                          var countSprint = 0
                          //new
                          $http.get("http://localhost:8080/iceScrum/SprintsForSpecificRelease", {
                                             params: { token: sessionToken.value , release_name: release_name}
                         }).success(function(data,status,headers,config){
                                          if(data.response.code == 200)
                                          {
                                               for(var i=0 ; i < data.response.id.length ; i++)
                                               {
                                                         var temp = {"id": data.response.id[i] , "name":data.response.name[i]};
                                                         sprintArray[countSprint++]= temp
                                                    
                                               }
                                                 
                                               $scope.availableSprint = sprintArray
                                               countSprint = 0
                                                   
                                          }
                                        
                                       
                          }).error(function(data,status,headers,config){
                                           alert("Error"+data)

                          });
                  }
                   
                 // save the userStory for specific release and project
                     $scope.saveUserStory = function() {
                      
                       var desc= "'"+$scope.userStoryDescription+"'"
                     var temp = '{token='+sessionToken.value+',project_id='+project_id+',release_name='+$scope.selectedRelease+',sprint_name='+$scope.selectedSprint+',name='+$scope.userStoryName+',description='+desc+'}'

                     $http.post("http://localhost:8080/iceScrum/UserStoryForSpecificProject",temp).success(function(data,status,headers,config){
                                    if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    else
                                      alert(data.response.status)
                      }).error(function(data,status,headers,config){
                                      alert("Error")
                      });
                        
                  }
                    
                   // first fetch the data for update the userStory   --------------------------------------------------  
                  $scope.FetchDataForUpdateUserStory = function(userStory_id,name,desc) {

                    $scope.userStoryId = userStory_id
                    $scope.userStoryName = name
                    $scope.userStoryDescription = desc

                  } 
                  // update the userStory --------------------------
                   
                  $scope.updateUserStory = function() {
                      
                  var desc= "'"+$scope.userStoryDescription+"'"
                     var temp = '{token='+sessionToken.value+',userStory_id='+$scope.userStoryId+',name='+$scope.userStoryName+',description='+desc+',release_name='+$scope.selectedRelease+',sprint_name='+$scope.selectedSprint+'}'

                     $http.put("http://localhost:8080/iceScrum/updateUserStory",temp).success(function(data,status,headers,config){
                                  if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    else
                                      alert(data.response.status)
                      }).error(function(data,status,headers,config){
                                      alert("client side error !!!!!!!")
                      });
                        
                }      
                    
                    
                  // fetch the userStory according to specific release and project
                    
                  var projectUserStorys = new Array();
                  var countprojectUserStorys = 0
                  $scope.fetchUserStorysForSpecificProject= function(){
                          
                         $http.get("http://localhost:8080/iceScrum/AllUserStoryForSpecificProject", {
                                             params: { token: sessionToken.value , project_id: project_id }
                         }).success(function(data,status,headers,config){
                                          if(data.response.code == 200)
                                          {
                                               for(var i=0 ; i < data.response.id.length ; i++)
                                               {
                                                        
                                                         var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i]};
                                                         projectUserStorys[countprojectUserStorys++]= temp
                                                        
                                               }
                                                 
                                               $scope.projectUserStoryss = projectUserStorys
                                                 
                                                   
                                          }
                                        
                                       
                          }).error(function(data,status,headers,config){
                                           alert("Error"+data)
                                            

                          });

                     }
                    
                 //creation of task ------(work in progress)
                 //fetch all userStories for perticular sprint -----------
                   
                 $scope.fetchUserStoriesForSpecificSprint= function(){
                          var sprint_name = $scope.selectedSprint
                            
                          var userStoriesArray = new Array();
                          var countUserStories = 0
                         
                          $http.get("http://localhost:8080/iceScrum/fetchUserStoriesForSpecificSprint", {
                                             params: { token: sessionToken.value , sprint_name: sprint_name}
                         }).success(function(data,status,headers,config){
                                          if(data.response.code == 200)
                                          {
                                               for(var i=0 ; i < data.response.id.length ; i++)
                                               {
                                                         var temp = {"id": data.response.id[i] , "name":data.response.name[i]};
                                                         userStoriesArray[countUserStories++]= temp
                                                    
                                               }
                                                 
                                               $scope.availableUserStories = userStoriesArray
                                               countUserStories = 0
                                                   
                                          }
                                        
                                       
                          }).error(function(data,status,headers,config){
                                           alert("Error"+data)

                          });
                  }
                 
                  // fetch all registered users for assign the task      
                $scope.fetchUsers= function(){
                           
                         $http.get("http://localhost:8080/iceScrum/fetchUsersForTask", {
                                             params: { token: sessionToken.value}
                         }).success(function(data,status,headers,config){
                                         
                                      $scope.usersArray = data
                                       
                          }).error(function(data,status,headers,config){
                             
                                           alert("Fetching Error")

                          });

                  }  
                  
                  
                  // save the task data on the server
                $scope.taskStatus = "Todo"
                $scope.saveTask = function() {
                      
                    var desc= "'"+$scope.taskDescription+"'"
                   var temp = '{token='+sessionToken.value+',sprint_name='+$scope.selectedSprint+',name='+$scope.taskName+',description='+desc+',status='+$scope.taskStatus+',startdate='+$scope.taskStartDate+',enddate='+$scope.taskEndDate+',userStory='+$scope.taskUserStories+',user='+$scope.taskUsers+'}'

                     $http.post("http://localhost:8080/iceScrum/saveTaskFromReleaseBoard",temp).success(function(data,status,headers,config){
                                    if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                   
                                    else if( data.response.code == 300 || data.response.code == 600 || data.response.code == 800 )
                                      flash.success=data.response.status
                      }).error(function(data,status,headers,config){
                                      alert("Error")
                      });
                        
                } 
                
                
              }
              
           
 
              // sprintboard controller -------------------------------------------------------
              function sprintBoardController($location,$routeParams,$scope,$http,flash){
                 
               var sessionToken = document.getElementById("token")
             
               this.params = $routeParams;
               var project_id = this.params.projectId 
               var release_id = this.params.releaseId
               $scope.projectNAME =this.params.projectName
               $scope.releaseNAME =this.params.releaseName
               $scope.projectID = project_id
               $scope.releaseID = release_id
                
               var newArrayColor1 = new Array();
               var newArrayColor2 = new Array();
               var newArrayColor3 = new Array();
          
               var count1 = 0
               var count2 = 0
               var count3 = 0
                 
                 
               // fetch all the sprints which are created by this perticular user ----------
               $scope.fetchCreatedSprints = function() {
                       
                      $http.get("http://localhost:8080/iceScrum/sprint", {
                                             params: { token: sessionToken.value , rid: release_id }
                         }).success(function(data,status,headers,config){
 
                                
                               if( data.response.code == 200)
                               {
                                     
                                   for(var i=0 ; i < data.response.id.length ; i++)
                                   {
                                        
                                      if( data.response.status[i] == "Todo")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          newArrayColor1[count1++]= temp
                                       }
                                       else if( data.response.status[i] == "In Progress")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          newArrayColor2[count2++]= temp
                                       }
                                       else if( data.response.status[i] == "Completed")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          newArrayColor3[count3++]= temp
                                       }
                                               
                                   }
                                     
                                     
                                   $scope.ArrayColor1 = newArrayColor1
                                   $scope.ArrayColor2 = newArrayColor2
                                   $scope.ArrayColor3 = newArrayColor3
                                   
                               }
                                       
                          }).error(function(data,status,headers,config){
                                           alert("Fetching error")

                          });

                       
                   }
    
                  var projectsName1 = new Array();
                  var projectsName2 = new Array();
                  var projectsName3 = new Array();

                  var count4 = 0
                  var count5 = 0
                  var count6 = 0
                  // fetch all created project for specific user ----------------------            
                  $scope.fetchCreatedProject = function() {
                      
                    
                     $http.get("http://localhost:8080/iceScrum/dashboardGetCreatedProject", {
                                        params: { token: sessionToken.value  }
                      }).success(function(data,status,headers,config){
                               $scope.currentPage = 0;
                                  $scope.pageSize = 10; 


                                       
                             if( data.response.code == 200)
                               {
                                     
                                   for(var i=0 ; i < data.response.id.length ; i++)
                                   {
                                       if( data.response.status[i] == "Todo")
                                       {
                                             $scope.length=data.response.id.length
                                              $scope.numberOfPages=Math.ceil($scope.length/$scope.pageSize)

                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName1[count4++]= temp
                                            
                                       }
                                       else if( data.response.status[i] == "In Progress")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName2[count5++]= temp
                                       }
                                       else if( data.response.status[i] == "Completed")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName3[count6++]= temp
                                       }
                                               
                                   }
                                    
                                   $scope.ArrayProject1 = projectsName1
                                   $scope.ArrayProject2 = projectsName2
                                   $scope.ArrayProject3 = projectsName3
                                   
                               }
             
            
                      }).error(function(data,status,headers,config){
                                      alert("fetching error in project list")
                      });

                   }
                     
                    
                   // save the sprint for this user who is manager of this project --------------
                   $scope.sprintStatus = "Todo"
                   $scope.saveSprint = function() {
                     
                      var desc= "'"+$scope.sprintDescription+"'"
                        
                     var userStoryArrayString = "0-";
                     for(var i=0 ; i<$scope.selectedUserStorys.length ; i++)
                     { 
                         userStoryArrayString += $scope.selectedUserStorys[i].id
                         if (i !=$scope.selectedUserStorys.length-1){
                          userStoryArrayString += "-";
                         }
                     }
                       
                     var temp = '{token='+sessionToken.value+',rid='+release_id+',name='+$scope.sprintName+',description='+desc+',status='+$scope.sprintStatus+',startdate='+$scope.sprintStartDate+',enddate='+$scope.sprintEndDate+',userStorys='+userStoryArrayString+'}'

                     $http.post("http://localhost:8080/iceScrum/sprint",temp).success(function(data,status,headers,config){
                                    if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    else if(data.response.code == 300 || 
                                            data.response.code == 600)
                                    //  alert(data.response.status)
                                      flash.success=data.response.status
                      }).error(function(data,status,headers,config){
                                      alert("Data is not valid !!!!!!!")
                      });
                        
                  } 
                    
                    
                    
                    
                    
                // first fetch the data for update the sprint   --------------------------------------------------  
                $scope.FetchDataForUpdateSprint = function(sprint_id,name,desc,startDate,endDate) {
                    
                  $scope.sprintId = sprint_id
                  $scope.sprintName = name
                  $scope.sprintDescription = desc
                  $scope.sprintStartDate = startDate
                  $scope.sprintEndDate = endDate
          
                } 
   
                // update the sprint which are created by this perticular user      --------------------------
                 $scope.updateSprint = function() {
                     var desc= "'"+$scope.sprintDescription+"'"
                     var userStoryArrayString = "0-";
                     for(var i=0 ; i<$scope.selectedUserStorys.length ; i++)
                     { 
                         userStoryArrayString += $scope.selectedUserStorys[i].id
                         if (i !=$scope.selectedUserStorys.length-1){
                          userStoryArrayString += "-";
                         }
                     }
                     var temp = '{token='+sessionToken.value+',sid='+$scope.sprintId+',name='+$scope.sprintName+',description='+desc+',startdate='+$scope.sprintStartDate+',enddate='+$scope.sprintEndDate+',userStorys='+userStoryArrayString+'}'

                     $http.put("http://localhost:8080/iceScrum/sprint",temp).success(function(data,status,headers,config){
                                    if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                   // alert(data.response.status)
                                    else if(data.response.code == 300 || data.response.code == 600)
                                      flash.success=data.response.status
                      }).error(function(data,status,headers,config){
                                      alert("Error")
                      });
                        
                }     
             
                 $scope.releaseName = this.params.releaseName
                 //fetch all sprints for perticular release -----------
                 $scope.fetchSprintsForSpecificRelease= function(){
                            
                          var release_name = $scope.releaseName
                          var sprintArray = new Array();
                          var countSprint = 0
                          //new
                          $http.get("http://localhost:8080/iceScrum/SprintsForSpecificRelease", {
                                             params: { token: sessionToken.value , release_name: release_name}
                         }).success(function(data,status,headers,config){
                                          if(data.response.code == 200)
                                          {
                                               for(var i=0 ; i < data.response.id.length ; i++)
                                               {
                                                         var temp = {"id": data.response.id[i] , "name":data.response.name[i]};
                                                         sprintArray[countSprint++]= temp
                                                    
                                               }
                                                 
                                               $scope.availableSprint = sprintArray
                                               countSprint = 0
                                                   
                                          }
                                        
                                       
                          }).error(function(data,status,headers,config){
                                           alert("Error"+data)

                          });
                  }
                  
                     // save the userStory for specific release and project
                     $scope.saveUserStory = function() {
                    var desc= "'"+$scope.userStoryDescription+"'"
                     
                     var temp = '{token='+sessionToken.value+',project_id='+project_id+',release_id='+release_id+',sprint_name='+$scope.selectedSprint+',name='+$scope.userStoryName+',description='+desc+'}'

                     $http.post("http://localhost:8080/iceScrum/UserStoryForSpecificRelease",temp).success(function(data,status,headers,config){
                                    if(data.response.code == 200)
                                    {
                                      location.reload()
                                    }
                                    else
                                      alert(data.response.status)
                      }).error(function(data,status,headers,config){
                                      alert("Error")
                      });
                  }  
                    
                   // fetch the userStory according to specific release and project
                  var UserStoryforSprint = new Array();
                  var countUserStoryforSprint = 0
                    
                  $scope.fetchUserStorysForSpecificRelease= function(){
                         
                         $http.get("http://localhost:8080/iceScrum/UserStoryForSpecificRelease", {
                                             params: { token: sessionToken.value , project_id: project_id , release_id:release_id}
                         }).success(function(data,status,headers,config){
                                          if(data.response.code == 200)
                                          {
                                               for(var i=0 ; i < data.response.id.length ; i++)
                                               {
                                                       

                                                         var temp = {"id": data.response.id[i] , "name":data.response.name[i],"desc": data.response.description[i]};
                                                         UserStoryforSprint[countUserStoryforSprint++]= temp

                                                        
                                               }
                                                 
                                               $scope.UserStoryforSprint = UserStoryforSprint
                                                 
                                                   
                                          }
                                        
                                       
                          }).error(function(data,status,headers,config){
                                           alert("Error"+data)

                          });

                     } 
              
                  // first fetch the data for update the userStory   --------------------------------------------------  
                  $scope.FetchDataForUpdateUserStory = function(userStory_id,name,desc) {

                    $scope.userStoryId = userStory_id
                    $scope.userStoryName = name
                    $scope.userStoryDescription = desc

                  } 
                    
                  // update the userStory 
                  $scope.updateUserStory = function() {
                      
                     var desc= "'"+$scope.userStoryDescription+"'"
                     var temp = '{token='+sessionToken.value+',userStory_id='+$scope.userStoryId+',name='+$scope.userStoryName+',description='+desc+',sprint_name='+$scope.selectedSprint+'}'

                     $http.put("http://localhost:8080/iceScrum/UserStoryForSpecificRelease",temp).success(function(data,status,headers,config){
                                  if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    alert(data.response.code)
//                                       else if (data.response.code == 300 || data.response.code == 600 )
//                                           flash.success=data.response.status
                      }).error(function(data,status,headers,config){
                                      alert("client side error !!!!!!!")
                      });
                        
                }      
                       
                       
                 // add task from sprintBoard ------
                 
                 $scope.fetchUserStoriesForSpecificSprint= function(){
                          var sprint_name = $scope.selectedSprint
                            
                          var userStoriesArray = new Array();
                          var countUserStories = 0
                         
                          $http.get("http://localhost:8080/iceScrum/fetchUserStoriesForSpecificSprint", {
                                             params: { token: sessionToken.value , sprint_name: sprint_name}
                         }).success(function(data,status,headers,config){
                                          if(data.response.code == 200)
                                          {
                                               for(var i=0 ; i < data.response.id.length ; i++)
                                               {
                                                         var temp = {"id": data.response.id[i] , "name":data.response.name[i]};
                                                         userStoriesArray[countUserStories++]= temp
                                                    
                                               }
                                                 
                                               $scope.availableUserStories = userStoriesArray
                                               countUserStories = 0
                                                   
                                          }
                                        
                                       
                          }).error(function(data,status,headers,config){
                                           alert("Error"+data)

                          });
                  }
                 
                  // fetch all registered users for assign the task      
                $scope.fetchUsers= function(){
                           
                         $http.get("http://localhost:8080/iceScrum/fetchUsersForTask", {
                                             params: { token: sessionToken.value}
                         }).success(function(data,status,headers,config){
                                         
                                      $scope.usersArray = data
                                       
                          }).error(function(data,status,headers,config){
                             
                                           alert("Fetching Error")

                          });

                  }  
                  
                  
                  // save the task data on the server
                $scope.taskStatus = "Todo"
                $scope.saveTask = function() {
                      
                    var desc= "'"+$scope.taskDescription+"'"
                   var temp = '{token='+sessionToken.value+',sprint_name='+$scope.selectedSprint+',name='+$scope.taskName+',description='+desc+',status='+$scope.taskStatus+',startdate='+$scope.taskStartDate+',enddate='+$scope.taskEndDate+',userStory='+$scope.taskUserStories+',user='+$scope.taskUsers+'}'

                     $http.post("http://localhost:8080/iceScrum/saveTaskFromReleaseBoard",temp).success(function(data,status,headers,config){
                                    if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    else if(data.response.code == 300|| data.response.code == 600 )
                                      flash.success=data.response.status
                      }).error(function(data,status,headers,config){
                                      alert("Error")
                      });
                        
                } 
                 
                   
             }
            
            
            //taskboard controller -------------------------------------------------------------------
             function taskBoardController($location,$routeParams,$scope,$http,flash){
                 
               var sessionToken = document.getElementById("token")
             
               this.params = $routeParams;
               var project_id = this.params.projectId 
               var release_id = this.params.releaseId
               var sprint_id = this.params.sprintId
               $scope.projectNAME =this.params.projectName
               $scope.releaseNAME =this.params.releaseName
               $scope.sprintNAME =this.params.sprintName
               $scope.projectID = project_id
               $scope.releaseID = release_id
               $scope.sprintID = sprint_id
                
               var newArrayColor1 = new Array();
               var newArrayColor2 = new Array();
               var newArrayColor3 = new Array();
          
               var count1 = 0
               var count2 = 0
               var count3 = 0
                 
                 
               // fetch all the tasks which are created by this perticular user ----------
               $scope.fetchCreatedTasks = function() {
                     $http.get("http://localhost:8080/iceScrum/task", {
                                             params: { token: sessionToken.value , sid: sprint_id }
                         }).success(function(data,status,headers,config){

                               if( data.response.code == 200)
                               {
                                     
                                   for(var i=0 ; i < data.response.id.length ; i++)
                                   {
                                        
                                      if( data.response.status[i] == "Todo")
                                       {
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"desc": data.response.description[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i],"assignTo":data.response.assignTo[i],"userStory":data.response.userStory[i]};
                                          newArrayColor1[count1++]= temp
                                       }
                                       else if( data.response.status[i] == "In Progress")
                                       {
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"desc": data.response.description[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i],"assignTo":data.response.assignTo[i],"userStory":data.response.userStory[i]};
                                          newArrayColor2[count2++]= temp
                                       }
                                       else if( data.response.status[i] == "Completed")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"desc": data.response.description[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i],"assignTo":data.response.assignTo[i],"userStory":data.response.userStory[i]};
                                          newArrayColor3[count3++]= temp
                                       }
                                               
                                   }
                                     
                                     
                                   $scope.ArrayColor1 = newArrayColor1
                                   $scope.ArrayColor2 = newArrayColor2
                                   $scope.ArrayColor3 = newArrayColor3
                                   
                               }
                                       
                          }).error(function(data,status,headers,config){
                                           alert("Fetching error")

                          });

                       
                   }
                     
                  var projectsName1 = new Array();
                  var projectsName2 = new Array();
                  var projectsName3 = new Array();

                  var count4 = 0
                  var count5 = 0
                  var count6 = 0
                    
                  // fetch all created project for specific user ----------------------            
                  $scope.fetchCreatedProject = function() {
                      
                    $scope.currentPage = 0;
                       $scope.pageSize = 10; 


                     $http.get("http://localhost:8080/iceScrum/dashboardGetCreatedProject", {
                                        params: { token: sessionToken.value  }
                      }).success(function(data,status,headers,config){
                               
                                       
                             if( data.response.code == 200)
                               {
                                      $scope.length=data.response.id.length
 
                                        $scope.numberOfPages=Math.ceil($scope.length/$scope.pageSize)

                                   for(var i=0 ; i < data.response.id.length ; i++)
                                   {
                                      if( data.response.status[i] == "Todo")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName1[count4++]= temp
                                            
                                       }
                                       else if( data.response.status[i] == "In Progress")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName2[count5++]= temp
                                       }
                                       else if( data.response.status[i] == "Completed")
                                       {
                                            
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i],"status":data.response.status[i],"startDate":data.response.dateCreated[i],"endDate":data.response.endDate[i],"updateDate":data.response.lastUpdated[i]};
                                          projectsName3[count6++]= temp
                                       }
                                               
                                   }
                                    
                                   $scope.ArrayProject1 = projectsName1
                                   $scope.ArrayProject2 = projectsName2
                                   $scope.ArrayProject3 = projectsName3
                                   
                               }
             
            
                      }).error(function(data,status,headers,config){
                                      alert("fetching error in project list")
                      });

                   }
                     
                    
                // fetch all registered users for assign the task      
                $scope.fetchUsers= function(){
                           
                         $http.get("http://localhost:8080/iceScrum/fetchUsersForTask", {
                                             params: { token: sessionToken.value}
                         }).success(function(data,status,headers,config){
                                         
                                      $scope.usersArray = data
                                       
                          }).error(function(data,status,headers,config){
                             
                                           alert("Fetching Error")

                          });

                  }  
                    
                  var tempArrayUserStory = new Array();
                  var counter = 0
                            
                 // fetch all userStorys for this perticular sprint and add this userStory to task
                 $scope.fetchUserStorysForSpecificSprint= function(){
                           
                         $http.get("http://localhost:8080/iceScrum/UserStoryForSpecificSprint", {
                                             params: { token: sessionToken.value , project_id: project_id , release_id : release_id , sprint_id : sprint_id }
                         }).success(function(data,status,headers,config){
                               if( data.response.code == 200)
                               {
                                     
                                   for(var i=0 ; i < data.response.id.length ; i++)
                                   {
                                                  
                                          var temp = {"id": data.response.id[i] , "name":data.response.name[i]};
                                          tempArrayUserStory[counter++]= temp  
                                            
                                   }
                                    
                                   $scope.userStorysArrayForSprint = tempArrayUserStory
                                     
                                   
                               }
                                       
                                       
                          }).error(function(data,status,headers,config){
                             
                                           alert("Fetching Error in userStory")

                          });

                 }  
                       
               // save the task data on the server
                $scope.taskStatus = "Todo"
                $scope.saveTask = function() {
                      
                    var desc= "'"+$scope.taskDescription+"'"
                   var temp = '{token='+sessionToken.value+',sid='+sprint_id+',name='+$scope.taskName+',description='+desc+',status='+$scope.taskStatus+',startdate='+$scope.taskStartDate+',enddate='+$scope.taskEndDate+',userStory='+$scope.taskUserStorys+',user='+$scope.taskUsers+'}'

                     $http.post("http://localhost:8080/iceScrum/task",temp).success(function(data,status,headers,config){
                                    if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    else if(data.response.code == 300 || data.response.code == 600 || data.response.code == 800)
                                     // alert(data.response.status)
                                       flash.success=data.response.status
                      }).error(function(data,status,headers,config){
                                      alert("Error in save ")
                      });
                        
                } 
                  
                  
                  
                // first fetch the data for update the Task   --------------------------------------------------  
                $scope.FetchDataForUpdateTask = function(task_id,name,desc,startDate,endDate,assignTo,userStoryName) {
                    
                  $scope.taskId = task_id
                  $scope.taskName = name
                  $scope.taskDescription = desc
                  $scope.taskStartDate = startDate
                  $scope.taskEndDate = endDate
                  $scope.prevAssign = assignTo
                  $scope.prevUserStory = userStoryName
                  

                } 
   
                // update the task which are created by this perticular user      --------------------------
                $scope.updateTask = function() {
                    var desc= "'"+$scope.taskDescription+"'"
                     var temp = '{token='+sessionToken.value+',tid='+$scope.taskId+',name='+$scope.taskName+',description='+desc+',startdate='+$scope.taskStartDate+',enddate='+$scope.taskEndDate+',userStory='+$scope.taskUserStorys+',user='+$scope.taskUsers+'}'
                      
                     $http.put("http://localhost:8080/iceScrum/task",temp).success(function(data,status,headers,config){
                                    if(data.response.code == 200)
                                    {
                                        
                                      location.reload()
                                          
                                    }
                                    else if(data.response.code == 300)
                                    flash.success=data.response.status
                      }).error(function(data,status,headers,config){
                                      alert("Error ")
                      });
                        
                } 
                
                   
              }
      
    </script>  

  </body>
</html>