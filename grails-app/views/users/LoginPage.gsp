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


<!--// added by Rachit for validation of email id on sign up-->

<script type="text/javascript">
   function isSignUpEmailValid()
{
  

var xmlhttp;
var k=document.getElementById("signUpEmail").value;
var urls="http://localhost:8080/iceScrum/users/checkMailSignUp?email="+k;
 
if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
else
  {
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4)
    {
      if(xmlhttp.status=="200")
        {
        document.getElementById("err").innerHTML=xmlhttp.responseText;
        $('#signUpEmail').css('background-color', 'white');
        document.getElementById("signUpEmail").value=""  
        
        }
        else{
          document.getElementById("err").innerHTML=xmlhttp.responseText;
           }
    }
  }
xmlhttp.open("GET",urls,true);
xmlhttp.send();
}
  

function isPasswordValid()
{
  var k=document.getElementById("signUpPassword").value;
  if(k!='')
   {
  if(k.length<6)
    {
      document.getElementById("errorForInvalidPassword").innerHTML= "Password should be atleast 6 characters";
      $('#signUpPassword').css('background-color', 'white');
       document.getElementById("signUpPassword").value=""
         
    }
    else
      document.getElementById("errorForInvalidPassword").innerHTML= "";
   }
}
</script>

  </head>
  <body>
     
     <!--images inserted  -->
    <img  src="${resource(dir: 'images', file: 'siteBackground.jpg')}" class="img1" alt="responsive-image"/>
    <img  src="${resource(dir: 'images', file: 'logo.png')}" class="img2" alt="responsive-image"/>
    <br>
     <!--header -->
    <div class="page-header" style="margin-top:-3%">
      <center>
      <h1 style="color:#2cb544"> <small></small></h1>
      </center>
    </div>
   
    
    <div class="container">
      
      <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-3">
          
          <!--Sign Up form-->
          
         <g:form controller="Users" action="addData" onsubmit="return ValidateUserRecord();">
          <h2 align="center" style="color:#19e1df;">Sign Up</h2>
          <input type="text" name="name" id="signUpName" class="form-control" placeholder="Name*"  autofocus><br>
          <div id="lblNameError" class="alert alert-info" style="display:none"></div>  
          <input type="text" name="email" id="signUpEmail" class="form-control" placeholder="Email Address*" onblur="isSignUpEmailValid()" >
          <h5 id="err" style="color:red"></h5><br>
          <div id="lblEmailError" class="alert alert-info" style="display:none"></div>
          <input type="password" name="password" id="signUpPassword" class="form-control "  placeholder="Password*" onblur="isPasswordValid()">
          <h5 id="errorForInvalidPassword" style="color:red"></h5><br>
          <div id="lblPasswordError" class="alert alert-info" style="display:none"></div>
          <input type="password" id="signUpConfirmPassword" class="form-control "  placeholder="Confirm Password*" >
          <div id="lblConfirmPasswordError" class="alert alert-info" style="display:none"></div><br>
          <button class="btn btn-sm btn-primary" type="submit">Sign up</button>
        </g:form> 
          
        </div>
        <div class="col-md-4">
          <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><div class='flash'> <center>${flash.message}</center></div>
        </div>
        
        <div class="col-md-3">
           
           <!--Sign In form-->
          <g:form controller="Users" action="verifySignIn" onsubmit="return ValidateSignIn();">
              <h2 align="center" style="color:#19e1df;" >Sign in</h2>
              <input id="signInEmail" name="email" type="text" class="form-control" placeholder="Email address">
              <br>
             <input id="signInPassword" name="password" type="password" class="form-control" placeholder="Password" >
             <br>
             <div class="container">
                 <div class="col-md-6" style="margin-left:-13%">
                   <button class="btn btn-sm btn-primary btn-block"  type="submit">Sign in</button>
            </div></div>
                 <a  href="http://localhost:8080/iceScrum/users/enterEmail"><label style="margin-top:6%">Forgot Password</label></a>
                 <div id="lblError" class="alert alert-info" style="display:none"></div>
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