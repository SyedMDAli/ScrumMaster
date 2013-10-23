package com.neev.controller
import grails.converters.*
import groovy.json.JsonBuilder
import com.neev.domain.User
import com.neev.userservice.*
import grails.converters.JSON
import com.neev.mainservice.*
import org.slf4j.Logger
import org.slf4j.LoggerFactory


class UsersController {
    
    final Logger logger = LoggerFactory.getLogger(UsersController.class)
    JsonBuilder builder = new JsonBuilder();
    def saveDataService
    def validationService
    def setForgetPasswordService
    def getUserService
    def commonUserValidationService
    def projectInfoService
    
    
    /*
     *Parameters : No Parameters
     *Functionality : Redirect to LoginPage
     *Return :
     */
    def index() 
    {
        redirect(action:"/users/LoginPage")
    }
    
    /*
     *Parameters : No Parameters
     *Functionality : Check if user already exist, otherwise call saveData method of SaveDataService
     *Return :
     */
    def addData()
    {
        logger.info("Entered into addData method of UserController")
        if( User.findByEmail(params.email) )
        {
            flash.message="This user already Registered!!"
            render(view:"/users/LoginPage")
        }
        else
        {
            String status = saveDataService.saveData(params.name , params.email , params.password)
            if(status=="vailidData")
            {
                flash.message="SignUp Successfully !!"
                redirect(action:"LoginPage")
            }
            else if(status=="msgSendingFail")
            {
                flash.message="Email-Id is Invalid"
                render(view:"/users/LoginPage")
            }
            else if(status=="dataNotValid")
            {
                flash.message="Information Invalid"
                render(view:"/users/LoginPage")
            }
        }       
    }
    
    /*
     *Parameters : No Parameter
     *Functionality : Call verifyToken method of ValidationService
     *Return :
     */
    def verify()
    {
        logger.info("Entered into verify method of UserController")
        String status = validationService.verifyToken(params.token)
        render(view:"/users/${status}")
    }
    
    /*
     *Parameters : No Parameter
     *Functionality : Call verifyStatus method of ValidationService if email and password are valid
     *Return :
     */
    def verifySignIn()
    {
        logger.info("Entered into verifySignIn method of UserController")
        if( validationService.verifyEmail(params.email) )
        {
            if( validationService.verifyPassword( params.email ,params.password) )
            {
                if( validationService.verifyStatus(params.email) )
                {
                    flash.message="You are successfully Login !!!!!" 
                    def sessionToken = saveDataService.getSessionToken(params.email)
                    def username = saveDataService.saveSessionToken(params.email , sessionToken)
                    def email = saveDataService.getEmailId(sessionToken)
                    
                    redirect(action:"home" , controller:"project", params:[sessionToken:sessionToken, username:username ,email:email])
                }
                else
                {
                    flash.message="First verify your account !!!!!"
                    render(view:"/users/LoginPage")
                }
            }
            else
            {
                flash.message="Password is incorrect!!!!!"
                render(view:"/users/LoginPage")
            }
        }
        else
        {
            flash.message="Email-Id is Invalid !!!!!"
            render(view:"/users/LoginPage") 
        }
    }
    
  
    /*
     *Parameters : No Parameter
     *Functionality : Call setForgetPasswordToken method of SetForgetPasswordService
     *Return :
     */
    def sendEmail()
    {   
        logger.info("Entered into sendMail method of UserController")
        if( validationService.verifyEmail(params.email)   )
        { 
            setForgetPasswordService.setForgetPasswordToken(params.email)
            flash.message="check your email for reset your password"
            render(view:"/users/LoginPage")
        }
        else
        {
            flash.message="Email-Id is invalid !!"
            render(view:"/users/getEmailForPassword")
        }    
    }
    

   /*
    *Parameters : No Parameter
    *Functionality : render getEmailForPassword
    *Return :
    */
    def enterEmail()
    {
        render(view:"/users/getEmailForPassword")
    }
    
    
    /*
     *Parameters : No Parameter
     *Functionality : Call verifyForgetPasswordToken method of ValidationService
     *Return :
     */
    def newPassword()
    {    
        logger.info("Entered into newPassword method of UserController")
        def user = validationService.verifyForgetPasswordToken(params.passwordtoken)
        if(user)
        {
            render(view:"/users/resetPassword",model: [email:user.email])
        }
        else
        {
            render(view:"/users/alreadyVerifiedForPassword")
        }
    } 
    

    /*
     *Parameters : No Parameter
     *Functionality : Call updatePassword method of SaveDataService
     *Return :
     */
    def setPassword()
    {
        logger.info("Entered into setPassword method of UserController")
        if(  saveDataService.updatePassword(params.new_password,params.email))
        {
            flash.message="Your password has been changed !!"
            render(view:"/users/LoginPage")
        }
        else
        {
            flash.message="password should be minimum 6 character"
            render(view:"/users/resetPassword")
        }  
    }
    
    
    /*
     *Parameters : No Parameter
     *Functionality : call nullSessionToken method of SaveDataService
     *Return :
     */
    def signOut()
    {  
        logger.info("Entered into sugnOut method of UserController")
        saveDataService.nullSessionToken(params.token)
        flash.message="LogOut Successfully !!!!!!!"
        redirect(action:"LoginPage")
    }
   
    
    /*
     *Parameters : No Parameter
     *Functionality :
     *Return :
     */
    def LoginPage()
    {
        
    }
    
    
    /*
     *Parameters : No Parameter
     *Functionality : Call updateProfile method of SaveDataService if user exist with the specified token
     *Return : 
     */
   def updateProfile()
   {  
        logger.info("Entered into updateProfile method of UserController")
        def json=request.JSON  
        def user = commonUserValidationService.verifySessionToken(json.token)
        if(user)
        {
            if(saveDataService.updateProfile(json))
            { 
                builder.response(status:"password changed",code:"200")   
                render builder.toString()    
            }
            else 
            {  
                builder.response(status:"Incorrect Password entered",code:"500")
                render builder.toString()
            }
        }
        else
        {
            logger.warn("Session Expired")
            builder.response(status:"session expired",code:"500")   
            render builder.toString()
        }
    }

    
    /*
     *Parameters : No Parameter
     *Functionality : Call verifyEmail method of ValidationService
     *Return : 
     */
    def checkMailSignUp()
    {
        def email=params.email        
        if(email!="")
        {
            def status= validationService.verifyEmail(email)
            if(status)
            {   
                render(text: "Email already exist!", status:"200")               
            }
            else
            {
                render(text:" ", status:"500") 
            }
        }
        else
        {    
            render(" ") 
        }
    }
}