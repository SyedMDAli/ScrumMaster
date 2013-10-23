<!doctype html>
<html lang="en">
<head>

<meta charset="utf-8" />
<title>Login Page</title>

<!-- jquery configuration -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css" />

<!-- bootstrap configuration -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">


<style type="text/css">
    <!--  overridding some properties in bootstrap -->
    
    .nav{
      background-color: #00FFFF;
    } 
    .navbar{
      background-color: #00FFFF;
    } 
</style>


<script>
  $(function() {
    $( "#dialog" ).dialog();
  });
  </script>


</head>
<body>
<br>

<div class="container">
   <div class="row">
    <nav class="navbar navbar-default" role="navigation">
               <div class="collapse navbar-collapse navbar-ex1-collapse">
    
                  <ul class="nav navbar-nav navbar-right"> 

                            
                             
		      	    
                                             
                  </ul>
  
               </div><!-- /.navbar-collapse -->
         </nav>
      
    </div>
 </div>   

<div id="dialog" title="Verification confirmation">
<p>
  
<h3>You are already verified !!!!!!! </h3>

</p>
</div>


<!--<div class="container">

   <div class="row">
   
         <img src="${resource(dir: 'images', file: 'asd.jpeg')}" alt="Grails" class="img-responsive"/>
      
    </div>
 </div>   


<div class="container">

   <div class="row">
 
         <img src="${resource(dir: 'images', file: 'bg.jpg')}" alt="Grails" class="img-responsive"/>
         
      
    </div>
 </div>  -->



</div>

</body>
</html>