
<html ng-app>
<head>
    <title>Hello World, AngularJS - ViralPatel.net</title>
    <script type="text/javascript"
        src="https://ajax.googleapis.com/ajax/libs/angularjs/1.0.8/angular.min.js"></script>
 
 <script type="text/javascript">

//for project
function project1($scope,$http) {
    
    $scope.save = function() {
       
       $http.post("http://localhost:8080/iceScrum/project",$scope.json1).success(function(data,status,headers,config){
                    alert(data.response.status);
	}).error(function(data,status,headers,config){
			alert("Error"+data)
	});
  
  }
  
}
 
function project2($scope,$http) {
  
  $scope.update = function() {  
        $http.put("http://localhost:8080/iceScrum/project",$scope.json2).success(function(data,status,headers,config){
                    alert(data.response.status);
	}).error(function(data,status,headers,config){
			alert("Error"+data)
	});
  
  }
}

//for release

function release1($scope,$http) {
  $scope.save = function() {
        $http.post("http://localhost:8080/iceScrum/release",$scope.json1).success(function(data,status,headers,config){
                    alert(data.response.status);
	}).error(function(data,status,headers,config){
			alert("Error"+data)
	});
  
  }
  
}
 
function release2($scope,$http) {
  
  $scope.update = function() {  
        $http.put("http://localhost:8080/iceScrum/release",$scope.json2).success(function(data,status,headers,config){
                    alert(data.response.status);
	}).error(function(data,status,headers,config){
			alert("Error"+data)
	});
  
  }
}


//for sprint
function sprint1($scope,$http) {
  $scope.save = function() {
        $http.post("http://localhost:8080/iceScrum/sprint",$scope.json1).success(function(data,status,headers,config){
                    alert(data.response.status);
	}).error(function(data,status,headers,config){
			alert("Error"+data)
	});
  
  }
  
}
 
function sprint2($scope,$http) {
  
  $scope.update = function() {  
        $http.put("http://localhost:8080/iceScrum/sprint",$scope.json2).success(function(data,status,headers,config){
                    alert(data.response.status);
	}).error(function(data,status,headers,config){
			alert("Error"+data)
	});
  
  }
}

//for task

function task1($scope,$http) {
  $scope.save = function() {
        $http.post("http://localhost:8080/iceScrum/task",$scope.json1).success(function(data,status,headers,config){
                    alert(data.response.status);
	}).error(function(data,status,headers,config){
			alert("Error"+data)
	});
  
  }
  
}
 
function task2($scope,$http) {
  
  $scope.update = function() {  
        $http.put("http://localhost:8080/iceScrum/task",$scope.json2).success(function(data,status,headers,config){
                    alert(data.response.status);
	}).error(function(data,status,headers,config){
			alert("Error"+data)
	});
  
  }
}

//for backlog
function backlog1($scope,$http) {
  $scope.save = function() {
        $http.post("http://localhost:8080/iceScrum/backlog",$scope.json1).success(function(data,status,headers,config){
                    alert(data.response.status);
	}).error(function(data,status,headers,config){
			alert("Error"+data)
	});
  
  }
  
}
 
function backlog2($scope,$http) {
  
  $scope.update = function() {  
        $http.put("http://localhost:8080/iceScrum/backlog",$scope.json2).success(function(data,status,headers,config){
                    alert(data.response.status);
	}).error(function(data,status,headers,config){
			alert("Error"+data)
	});
  
  }
}


</script>
</head>
<body>
  <h1>project operation</h1>
    <div ng-controller="project1">
     
      <form ng-submit="save()"> 
        <label> Project creation use POST </label>
        JSON <textarea ng-model="json1" rows="5" cols="20"></textarea><br/>
        <input class="btn-primary" type="submit" value="add project">
      </form>
    </div>
  
  <div ng-controller="project2">
      <form ng-submit="update()"> 
        <label> Project updation use PUT</label>
        JSON <textarea ng-model="json2" rows="5" cols="20"></textarea><BR/>
        <input class="btn-primary" type="submit" value="update project">
      </form>
  </div>
  
  
  
  <h1>release operation</h1>
    <div ng-controller="release1">
     
      <form ng-submit="save()"> 
        <label> release creation use POST </label>
        JSON <textarea ng-model="json1" rows="5" cols="20"></textarea><BR/>
        <input class="btn-primary" type="submit" value="add release">
      </form>
    </div>
  
  <div ng-controller="release2">
      <form ng-submit="update()"> 
        <label> release updation use PUT</label>
        JSON <textarea ng-model="json2" rows="5" cols="20"></textarea><BR/>
        <input class="btn-primary" type="submit" value="update release">
      </form>
  </div>
  
  
  
  <h1>sprint operation</h1>
    <div ng-controller="sprint1">
     
      <form ng-submit="save()"> 
        <label> sprint creation use POST </label>
        JSON <textarea ng-model="json1" rows="5" cols="20"></textarea><BR/>
        <input class="btn-primary" type="submit" value="add sprint">
      </form>
    </div>
  
  <div ng-controller="sprint2">
      <form ng-submit="update()"> 
        <label> sprint updation use PUT</label>
        JSON <textarea ng-model="json2" rows="5" cols="20"></textarea><BR/>
        <input class="btn-primary" type="submit" value="update sprint">
      </form>
  </div>
  
  
  
  
  <h1>task operation</h1>
    <div ng-controller="task1">
     
      <form ng-submit="save()"> 
        <label> task creation use POST </label>
        JSON <textarea ng-model="json1" rows="5" cols="20"></textarea><BR/>
        <input class="btn-primary" type="submit" value="add task">
      </form>
    </div>
  
  <div ng-controller="task2">
      <form ng-submit="update()"> 
        <label> task updation use PUT</label>
        JSON <textarea ng-model="json2" rows="5" cols="20"></textarea><BR/>
        <input class="btn-primary" type="submit" value="update task">
      </form>
  </div>
  
  
  
  
  
  <h1>backlog operation</h1>
    <div ng-controller="backlog1">
     
      <form ng-submit="save()"> 
        <label> backlog creation use POST </label>
        JSON <textarea ng-model="json1" rows="5" cols="20"></textarea><BR/>
        <input class="btn-primary" type="submit" value="add backlog">
      </form>
    </div>
  
  <div ng-controller="backlog2">
      <form ng-submit="update()"> 
        <label> backlog updation use PUT</label>
        JSON <textarea ng-model="json2" rows="5" cols="20"></textarea><BR/>
        <input class="btn-primary" type="submit" value="update backlog">
      </form>
  </div>
     
</body>
</html>
