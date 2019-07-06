CREATE OR REPLACE PACKAGE ostriv_common_utl IS

  /*==============================================================================
  Package Name :
      OSTRIV_COMMON_UTL
  Description:
        This package provide procedures for common usage
  History:
         1.00  2019-07-10  Ostriv  Creation
  ==============================================================================*/

  /*==============================================================================
  *   FUNCTION / PROCEDURE
  *   NAME :
  *       get_object_type
  *   DESCRIPTION: 
  *       This program provides APIs to get specific object's type
  *       You must specify object id or both owner and object name to get right result
  *   ARGUMENT:                                               
  *       in_object_id                      : Object ID
  *       iv_owner                          : Object Owner
  *       iv_object_name                    : Object Name
  *   Return:    
  *   History: 
  *       1.00  2019-07-10 Ostriv  Creation
  ==============================================================================*/
  FUNCTION get_object_type(in_object_id   IN NUMBER DEFAULT NULL,
                           iv_owner       IN VARCHAR2 DEFAULT USER,
                           iv_object_name IN VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2;

  /*==============================================================================
  *   FUNCTION / PROCEDURE
  *   NAME :
  *       grant_objects
  *   DESCRIPTION: 
  *       This program provides APIs to get specific object list
  *   ARGUMENT:                                               
  *       iv_owner                          : Object Owner
  *       iv_name_pattern                   : Object Name Pattern
  *       iv_object_type                    : Object Type
  *       id_created_from                   : Creation Date From
  *       id_created_to                     : Creation Date To
  *       id_last_ddl_from                  : Last DDL Time From
  *       id_last_ddl_to                    : Last DDL Time To
  *       iv_status                         : Object Status
  *   Return:    
  *   History: 
  *       1.00  2019-07-10 Ostriv  Creation
  ==============================================================================*/
  FUNCTION get_object_list(iv_owner         IN VARCHAR2 DEFAULT USER,
                           iv_name_pattern  IN VARCHAR2 DEFAULT '%',
                           iv_object_type   IN VARCHAR2 DEFAULT NULL,
                           id_created_from  IN DATE DEFAULT NULL,
                           id_created_to    IN DATE DEFAULT SYSDATE,
                           id_last_ddl_from IN DATE DEFAULT NULL,
                           id_last_ddl_to   IN DATE DEFAULT SYSDATE,
                           iv_status        IN VARCHAR2 DEFAULT 'VALID')
    RETURN dbms_sql.number_table;

  /*==============================================================================
  *   FUNCTION / PROCEDURE
  *   NAME :
  *       grant_objects
  *   DESCRIPTION: 
  *       This program provides APIs to grant selected priviledges to sepecific users
  *       
  *   ARGUMENT:                                               
  *       it_obj_list                       : Object List ID
  *       it_privileges                     : Object Priviledge List
  *       it_users                          : Grant to users
  *   Return:    
  *   History: 
  *       1.00  2019-07-10 Ostriv  Creation
  ==============================================================================*/
  PROCEDURE grant_objects(it_obj_list IN dbms_sql.number_table,
                          --it_privileges    IN dbms_sql.varchar2a DEFAULT 1,
                          --it_users         IN dbms_sql.varchar2a DEFAULT 1,
                          ov_return_status OUT VARCHAR2,
                          ov_msg_data      OUT VARCHAR2);

END ostriv_common_utl;
/
CREATE OR REPLACE PACKAGE BODY ostriv_common_utl IS

  /*==============================================================================
  Package Name :
      OSTRIV_COMMON_UTL
  Description:
        This package provide procedures for common usage
  History:
         1.00  2019-07-10  Ostriv  Creation
  ==============================================================================*/

  /*==============================================================================
  *   FUNCTION / PROCEDURE
  *   NAME :
  *       get_object_type
  *   DESCRIPTION: 
  *       This program provides APIs to get specific object's type
  *       You must specify object id or both owner and object name to get right result
  *   ARGUMENT:                                               
  *       in_object_id                      : Object ID
  *       iv_owner                          : Object Owner
  *       iv_object_name                    : Object Name
  *   Return:    
  *   History: 
  *       1.00  2019-07-10 Ostriv  Creation
  ==============================================================================*/
  FUNCTION get_object_type(in_object_id   IN NUMBER DEFAULT NULL,
                           iv_owner       IN VARCHAR2 DEFAULT USER,
                           iv_object_name IN VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2 IS
    lv_object_type all_objects.object_type%TYPE;
  
  BEGIN
  
    IF in_object_id IS NULL AND iv_owner IS NULL AND iv_object_name IS NULL THEN
      RETURN NULL;
    END IF;
  
    SELECT ao.object_type
      INTO lv_object_type
      FROM all_objects ao
     WHERE 1 = 1
       AND ao.object_id = nvl(in_object_id, ao.object_id)
       AND ao.owner = nvl(iv_owner, ao.owner)
       AND ao.object_name = nvl(iv_object_name, ao.object_name);
  
    RETURN lv_object_type;
  
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
    WHEN too_many_rows THEN
      RETURN NULL;
    WHEN OTHERS THEN
      RETURN NULL;
  END get_object_type;

  /*==============================================================================
  *   FUNCTION / PROCEDURE
  *   NAME :
  *       get_object_list
  *   DESCRIPTION: 
  *       This program provides APIs to get specific object list
  *       If not specify any parameter then returns all valid object id list of
  *       current user
  *   ARGUMENT:                                               
  *       iv_owner                          : Object Owner
  *       iv_name_pattern                   : Object Name Pattern
  *       iv_object_type                    : Object Type
  *       id_created_from                   : Creation Date From
  *       id_created_to                     : Creation Date To
  *       id_last_ddl_from                  : Last DDL Time From
  *       id_last_ddl_to                    : Last DDL Time To
  *       iv_status                         : Object Status
  *   Return:    
  *   History: 
  *       1.00  2019-07-10 Ostriv  Creation
  ==============================================================================*/
  FUNCTION get_object_list(iv_owner         IN VARCHAR2 DEFAULT USER,
                           iv_name_pattern  IN VARCHAR2 DEFAULT '%',
                           iv_object_type   IN VARCHAR2 DEFAULT NULL,
                           id_created_from  IN DATE DEFAULT NULL,
                           id_created_to    IN DATE DEFAULT SYSDATE,
                           id_last_ddl_from IN DATE DEFAULT NULL,
                           id_last_ddl_to   IN DATE DEFAULT SYSDATE,
                           iv_status        IN VARCHAR2 DEFAULT 'VALID')
    RETURN dbms_sql.number_table IS
  
    CURSOR csr_obj IS
      SELECT do.object_id
        FROM all_objects do
       WHERE 1 = 1
         AND do.owner LIKE iv_owner
         AND do.object_name LIKE iv_name_pattern
         AND do.created BETWEEN nvl(id_created_from, do.created) AND
             nvl(id_created_to, SYSDATE)
         AND do.last_ddl_time BETWEEN nvl(id_last_ddl_from, do.last_ddl_time) AND
             nvl(id_last_ddl_to, SYSDATE)
         AND do.status LIKE iv_status;
  
    lt_obj_list dbms_sql.number_table;
  
  BEGIN
    /*FOR rec_obj IN csr_obj LOOP
      lt_obj_list(lt_obj_list.count) := rec_obj.object_id;
      dbms_output.put_line(rec_obj.object_id || ';');
    END LOOP;*/
    OPEN csr_obj;
    FETCH csr_obj BULK COLLECT
      INTO lt_obj_list;
    CLOSE csr_obj;
  
    RETURN lt_obj_list;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN lt_obj_list;
      dbms_output.put_line(SQLERRM);
    
  END get_object_list;

  /*==============================================================================
  *   FUNCTION / PROCEDURE
  *   NAME :
  *       grant_objects
  *   DESCRIPTION: 
  *       This program provides APIs to grant selected priviledges to sepecific users
  *       
  *   ARGUMENT:                                               
  *       it_obj_list                       : Object List ID
  *       it_privileges                     : Object Priviledge List
  *       it_users                          : Grant to users
  *   Return:    
  *   History: 
  *       1.00  2019-07-10 Ostriv  Creation
  ==============================================================================*/
  PROCEDURE grant_objects(it_obj_list IN dbms_sql.number_table,
                          --it_privileges    IN dbms_sql.varchar2a DEFAULT 1,
                          --it_users         IN dbms_sql.varchar2a DEFAULT 1,
                          ov_return_status OUT VARCHAR2,
                          ov_msg_data      OUT VARCHAR2) IS
  
    lt_sql         dbms_sql.varchar2a;
    lv_object_type all_objects.object_type%TYPE;
  
  BEGIN
  
    IF it_obj_list.count = 0 THEN
      RETURN;
    END IF;
  
    FOR i IN it_obj_list.first .. it_obj_list.last LOOP
      CASE get_object_type(in_object_id => it_obj_list(i))
        WHEN 'TABLE' THEN
          NULL;
      END CASE;
    
      dbms_output.put_line(it_obj_list(i) || '!' || lv_object_type);
    END LOOP;
  
  END grant_objects;

  /*==============================================================================
  *   FUNCTION / PROCEDURE
  *   NAME :
  *       transfer_objects
  *   DESCRIPTION: 
  *       This program provides APIs to 
  *       Transfer specified object list to specific database
  *   ARGUMENT:                                               
  *       it_obj_list                       : Object List ID
  *       it_privileges                     : Object Priviledge List
  *       it_users                          : Grant to users
  *   Return:    
  *   History: 
  *       1.00  2019-07-10 Ostriv  Creation
  ==============================================================================*/
  PROCEDURE transfer_objects(it_obj_list IN dbms_sql.number_table) IS
  BEGIN
    NULL;
  END transfer_objects;

END ostriv_common_utl;
/
