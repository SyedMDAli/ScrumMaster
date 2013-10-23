package com.neev.userservice

import grails.transaction.Transactional
import com.neev.domain.*
import org.slf4j.Logger
import org.slf4j.LoggerFactory

@Transactional
class CommonUserValidationService 
{
    final Logger logger = LoggerFactory.getLogger(CommonUserValidationService.class)
 
    /*
     *Parameters : session token 
     *Functionality : verify user by the session token
     *Return : user object if user exist with the token that has been passed otherwise null
     */
    def verifySessionToken(def sessionToken)
    {
        logger.info("Entered into verifySessionToken method of CommonUserValidationService")
        def user = User.findBySession_token(sessionToken)
        if(user)
        {
            logger.info("Returning true from verifySessionToken method of CommonUserValidationService")
            return user
        }
        logger.info("Returning false from verifySessionToken method of CommonUserValidationService")
        return null
    }
}