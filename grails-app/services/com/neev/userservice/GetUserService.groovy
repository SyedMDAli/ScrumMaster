package com.neev.userservice

import com.neev.domain.User;
import grails.transaction.Transactional
import org.slf4j.Logger
import org.slf4j.LoggerFactory

@Transactional
class GetUserService 
{
    final Logger logger = LoggerFactory.getLogger(GetUserService.class)
    
    /*
     *Parameters : No Parameters
     *Functionality : fetch all users
     *Return : list of users
     */
    def getAllUsers()
    {
        logger.info("Entered into getAllUsers method of GetUserService")
        User user= new User()
        List list = user.findAll()
        logger.info("Returning list of user from getAllUsers method of GetUserService")
        return list
    }
}