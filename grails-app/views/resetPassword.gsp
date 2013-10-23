<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Ice Scrum</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">  
    
    <!-- jquery css and javascript file -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
    

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.css">
    

    <!--linking with separate iceScrum.js file -->
    <script type="text/javascript" src="${resource(dir: 'js', file: 'iceScrum.js')}"></script>
   
    <!--linking with separate iceScrum.css file -->    
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'iceScrum.css')}" type="text/css">
    
    
    <script type="text/javascript" >
      $(document).ready(function(){
         setTimeout(function(){
         $(".flash").fadeOut("slow", function () {
         $(".flash").remove();
      }); }, 2000);
      });
    </script>



    <style type="text/css">
      .flash{
          width:759px;
          padding-top:8px;
          padding-bottom:8px;
          background-color: #fff;
          font-weight:bold;
          font-size:20px;-moz-border-radius: 6px;-webkit-border-radius: 6px;

        }
</style>
     
  </head>
  <body>
     
     <!--images inserted  -->
    <img  src="${resource(dir: 'images', file: '123.jpg')}" class="img1" alt="responsive-image"/>
    <img  src="${resource(dir: 'images', file: 'logo.png')}" class="img2" alt="responsive-image"/>
     
     <!--header -->
    <div class="page-header" style="margin-top:-3%">
      <center>
      <h1 style="color:#2cb544"> <small></small></h1>
      </center>
    </div>
   
    
    <div class="container">
      
      <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-3">
          
          <!--Sign Up form-->
          
         <g:form controller="Users" action="setPassword" onsubmit="return ValidateUserRecord();">
          <h2 align="center" style="color:#19e1df;">New Password !!!! </h2>
      
          <input type="password" name="new_password" id="signUpPassword" class="form-control "  placeholder="Password*" ><br>
          <div id="lblPasswordError" class="alert alert-info" style="display:none"></div>
          <input type="password" id="signUpConfirmPassword" class="form-control "  placeholder="Confirm Password*" ><br>
          <div id="lblConfirmPasswordError" class="alert alert-info" style="display:none"></div><br>
          <input type="hidden" name="email" value="${email}"/>
          <button class="btn btn-lg btn-primary btn-block" type="submit">Change Password</button>
        </g:form> 
          
        </div>
       
        
        
      </div>
    </div> <!-- /container -->

    <!--footer -->
    <br>
    <div class="page-footer " style="margin-top:11%">
      <center>
      <h1> <small></small></h1>
      </center>
    </div>
    
  </body>
</html>