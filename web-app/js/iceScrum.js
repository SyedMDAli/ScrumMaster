$(document).ready(function () {
   //Header animation    
   setInterval(function () {
       
       if ($('#lblNameError').css('display') != 'none') {     
           $('#lblNameError').hide('slow');
       }
       if ($('#lblEmailError').css('display') != 'none') {
           $('#lblEmailError').hide('slow');
       }
       if ($('#lblPasswordError').css('display') != 'none') {
           $('#lblPasswordError').hide('slow');
       }
       if ($('#lblConfirmPasswordError').css('display') != 'none') {
           $('#lblConfirmPasswordError').hide('slow');
       }
       if ($('#lblError').css('display') != 'none') {
           $('#lblError').hide('slow');
       }
      
   }, 2000);
   
    //Validations
    //Email Validation
    
    $('#signUpEmail').change(function () {
        var validEmail = /[a-z0-9!#$%&'*+/=?^{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in)\b/
        if (!validEmail.test(this.value)) {
            $('#signUpEmail').css('background-color', 'white');
            $('#signUpEmail').val('');
            $('#signUpEmail').focus();
        }
        else {
            if ($('#signUpEmail').val().length > 0)
                $('#signUpEmail').css('background-color', 'orange');
            else
                $('#signUpEmail').css('background-color', 'white');
           
        }
    });


    //Validation for Password
    $('#signUpPassword').change(function () {
        if (($('#signUpConfirmPassword').val().length > 0) && ($('#signUpPassword').val() != $('#signUpConfirmPassword').val())) {
            $('#signUpConfirmPassword').css('background-color', 'white');
            $('#signUpConfirmPassword').val('');
            $('#signUpConfirmPassword').focus();
        }
        if ($('#signUpPassword').val().length > 0)
            $('#signUpPassword').css('background-color', 'orange');
        else
            $('#signUpPassword').css('background-color', 'white');
    });
    
    
    //Validation for Confirm Password
    $('#signUpConfirmPassword').change(function () {
        var password = $('#signUpPassword').val()
        var confirmpassword = $('#signUpConfirmPassword').val();
        if (password != confirmpassword) {
            $('#signUpConfirmPassword').css('background-color', 'white');
            $('#signUpConfirmPassword').val('');
            $('#signUpConfirmPassword').focus();
        }
        else {
            
            if($('#signUpPassword').val().length>0)
                $('#signUpPassword').css('background-color', 'orange');
            else
                $('#signUpPassword').css('background-color', 'white');
            if ($('#signUpConfirmPassword').val().length > 0)
                $('#signUpConfirmPassword').css('background-color', 'orange');
            else
                $('#signUpConfirmPassword').css('background-color', 'white');
        }
    });
    
    
    
    //Change background color of username
    $('#signUpName').change(function () {
      var validName = /^[a-zA-Z](([\' '\][a-zA-Z])|[a-zA-Z])*[a-z]$/
       if (!validName.test(this.value)) {
            $('#signUpName').css('background-color', 'white');
            $('#signUpName').val('');
            $('#signUpName').focus();
        }
        else {
            if ($('#signUpName').val().length > 0)
                $('#signUpName').css('background-color', 'orange');
            else
                $('#signUpName').css('background-color', 'white');
           
        }
    });

});

//Required field validation for signUp
function ValidateUserRecord() {
    //alert("Hi");
    var username, userpassword, confirmuserpassword, useremail;
    username = userpassword = confirmuserpassword = useremail = null;
    username = $('#signUpName').val();
    userpassword = $('#signUpPassword').val();
    confirmuserpassword = $('#signUpConfirmPassword').val();
    useremail = $('#signUpEmail').val();
   
    if ((username == null || username.length == 0)){
        $('#signUpName').focus();
        $('#lblNameError').css('display','block');
        $('#lblNameError').text(' Name field is required.');
        
        return false;
    }
    else if((useremail == null || useremail.length == 0))
    {
        $('#signUpEmail').focus();
        $('#lblEmailError').css('display','block');
        $('#lblEmailError').text(' Email field is required.');
        return false;
    }
    else if((userpassword == null || userpassword.length == 0))
    {
        $('#signUpPassword').focus();
        $('#lblPasswordError').css('display','block');
        $('#lblPasswordError').text(' Password field is required.');
        return false;
    }
    else if((confirmuserpassword == null || confirmuserpassword.length == 0))
    {
        $('#signUpConfirmPassword').focus();
        $('#lblConfirmPasswordError').css('display','block');
        $('#lblConfirmPasswordError').text(' Please confirm password.');
        return false;
    }
     
}

//Required field validation for signIn
function ValidateSignIn()
{
  
    var useremail, userpassword  ;
    userpassword = useremail = null;
    userpassword = $('#signInPassword').val();
    useremail = $('#signInEmail').val();
    if((useremail == null || useremail.length == 0))
    {
        $('#signInEmail').focus();
        $('#lblError').css('display','block');
        $('#lblError').text(' Email field is required.');
        return false;
    }
    else if((userpassword == null || userpassword.length == 0))
    {
        $('#signInPassword').focus();
        $('#lblError').css('display','block');
        $('#lblError').text(' Password field is required.');
        return false;
    }
    
}



