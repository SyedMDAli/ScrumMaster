package com.neev.userservice

import grails.transaction.Transactional
import com.neev.domain.User
import org.slf4j.Logger
import org.slf4j.LoggerFactory

//this service i used only for validation
class ValidationService 
{
    final Logger logger = LoggerFactory.getLogger(ValidationService.class)
    //verification for the Status of user
    
    /*
     *Parameters : email
     *Functionality : verify the status of user
     *Return : true if user account is active, false otherwise
     */
    boolean verifyStatus(String email)
    {
        logger.info("Entered into verifyStatus method of ValidationService")
        def user = new User()
        user = User.findByEmail(email)
        if(user.status=="ACTIVE")
        {
            logger.info("Returning true from verifyStatus method of ValidationService")
            return true
        }
        logger.info("Returning false from verifyStatus method of ValidationService")
        return false
    }
    
    /*
     *Parameters : email and password
     *Functionality : verify the password while log in
     *Return : true is password is correct, false otherwise
     */
    boolean verifyPassword(String email , String password)
    {   
        logger.info("Entered into verifyPassword method of ValidationService")
        def user = new User()
        user = User.findByEmail(email)
        if(password)
        {           
            if(user.password == password )
            {
                logger.info("Returning true from verifyPassword method of ValidationService")
                return true;
            }                    
        }
        logger.info("Returning false from verifyPassword method of ValidationService")
        return false
    }
    
    
    /*
     *Parameters : email
     *Functionality : verity email Id of user while log in
     *Return :true if email is registered, false otherwise
     */
    boolean verifyEmail(String email)
    {
        logger.info("Entered into verifyEmail method of ValidationService")
        def user = new User()
        try
        {
            if(email)
            {
                user = User.findByEmail(email)
                if(user)
                {
                    logger.info("Returning  true from verifyEmail method of ValidationService")
                    return true
                } 
                else
                {
                    logger.info("Returning  false from verifyEmail method of ValidationService")
                    return false;
                }
            }
        }
        catch(Exception e)
        {
            logger.info("Exception in verifyEmail method of ValidationService")
            return false;
        }
    }
    
    /*
     *Parameters : token
     *Functionality : verify the token that has been sent to user's email id on registering and set ACTIVE on clicking link for first time
     *Return : status of token verification
     */
    def verifyToken(String token)
    {   
        logger.info("Entered into verifyToken method of ValidationService")
        User user = User.findByVerify_code_for_signIn(token);
        if(user)
        {
            String status = user.status
            if( status.equals("ACTIVE") )
            {
                logger.info("Returning alreadyVerified from verifyToken method of ValidationService")
                return "alreadyVerified";
            }
            else
            {
                user.setStatus("ACTIVE")
                user.save()
                logger.info("Returning verify-success from verifyToken method of ValidationService")
                return "verify-success"
            }
        }
        else
        {
            logger.info("Returning verify-failure from verifyToken method of ValidationService")
            return "verify-failure";
        }
    }
    
    /*
     *Parameters : password token
     *Functionality : verify the password token that has been sent to user's mail Id
     *Return : user object if user exist with the token passed
     */
    def verifyForgetPasswordToken(String passwordToken)
    {
        logger.info("Entered into verifyForgetPasswordToken method of ValidationService")
        if(passwordToken)
        {
            User user = new User()
            user = User.findByForgotPassword_token(passwordToken)
            if(user)
            {
                user.setForgotPassword_token(null)
                user.save()
                logger.info("Returning user object from verifyForgetPasswordToken method of ValidationService")
                return user
            }
            else
            {
                logger.info("Returning null from verifyForgetPasswordToken method of ValidationService")
                return null
            }
        }
    }
    
    /*
     *Parameters : email
     *Functionality : find user by email id
     *Return : user if user exist with the emil Id passed, null otherwise
     */
    def getUserByEmail(String email)
    {
        logger.info("Entered into getUserByEmail method of ValidationService")
        User user = User.findByEmail(email.trim())
        if(user)
        {
            logger.info("Returning user object from getUserByEmail method of ValidationService")
            return user
        }
        logger.info("Returning null from getUserByEmail method of ValidationService")
        return null
    }
}