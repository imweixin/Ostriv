CREATE OR REPLACE PACKAGE ostriv_api IS

  /*==============================================================================
  Package Name :
      OSTRIV_API
  Description:
        This package provide procedures for common api
  History:
         1.00  2019-07-10  Ostriv  Creation
  ==============================================================================*/

  --Exception handling
  e_unexpected_error EXCEPTION;
  e_error            EXCEPTION;

  --Global constant
  --Return status
  gc_rtn_sts_warning     CONSTANT VARCHAR2(1) := 'W';
  gc_rtn_sts_success     CONSTANT VARCHAR2(1) := 'S';
  gc_rtn_sts_error       CONSTANT VARCHAR2(1) := 'E';
  gc_rtn_sts_unexp_error CONSTANT VARCHAR2(1) := 'U';

END ostriv_api;
/
CREATE OR REPLACE PACKAGE BODY ostriv_api IS

/*==============================================================================
  Package Name :
      OSTRIV_API
  Description:
        This package provide procedures for common api
  History:
         1.00  2019-07-10  Ostriv  Creation
  ==============================================================================*/

END ostriv_api;
/
