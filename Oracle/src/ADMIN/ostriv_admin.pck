CREATE OR REPLACE PACKAGE ostriv_admin IS

/*==========================================================
  Package Name :
      OSTRIV_ADMIN
  Description:
        This package provide procedures for common administator
        routines
  History:
         1.00  2019-07-10  Ostriv  Creation
  ==========================================================*/

END ostriv_admin;
/
CREATE OR REPLACE PACKAGE BODY ostriv_admin IS

  /*==========================================================
  Package Name :
      OSTRIV_ADMIN
  Description:
        This package provide procedures for common administator
        routines
  History:
         1.00  2019-07-10  Ostriv  Creation
  ==========================================================*/

  /*==============================================================================
  *   FUNCTION / PROCEDURE
  *   NAME :
  *       get_locked_objects
  *   DESCRIPTION: 
  *       This program provides APIs to 
  *       Get all locked objects of current session
  *   ARGUMENT:                                               
  *       it_obj_list                       : Object List ID
  *       it_privileges                     : Object Priviledge List
  *       it_users                          : Grant to users
  *   Return:    
  *   History: 
  *       1.00  2019-07-10 Ostriv  Creation
  ==============================================================================*/
  FUNCTION get_locked_objects RETURN dbms_sql.number_table IS
  
  BEGIN
  
    NULL;
  END get_locked_objects;

  /*==============================================================================
  *   FUNCTION / PROCEDURE
  *   NAME :
  *       get_locked_objects
  *   DESCRIPTION: 
  *       This program provides APIs to 
  *       Unlock given objects
  *   ARGUMENT:                                               
  *       it_obj_list                       : Object List ID
  *   Return:    
  *   History: 
  *       1.00  2019-07-10 Ostriv  Creation
  ==============================================================================*/
  PROCEDURE unlock_objects(it_obj_list IN dbms_sql.number_table) IS
  
  BEGIN
    NULL;
  END unlock_objects;

END ostriv_admin;
/
