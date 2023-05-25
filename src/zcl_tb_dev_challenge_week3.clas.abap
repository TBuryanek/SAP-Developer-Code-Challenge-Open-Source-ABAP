CLASS zcl_tb_dev_challenge_week3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    "NOTE: Interface to execute CLass without SAP GUI + enable Console output from class
    "      ADT: Run As => ABAP Application (Console)
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.

    TYPES: BEGIN OF gty_email_people_s,
             first_name TYPE string,
             last_name  TYPE string,
           END OF gty_email_people_s.

    TYPES: gty_email_people_t TYPE TABLE OF gty_email_people_s WITH EMPTY KEY.

    TYPES: BEGIN OF gty_email_data_s,
             title  TYPE string,
             people TYPE gty_email_people_t,
           END OF gty_email_data_s.

    CLASS-METHODS:
      get_email_data RETURNING VALUE(rv_email_data) TYPE gty_email_data_s,
      get_email_html IMPORTING is_email_data  TYPE gty_email_data_s
                     EXPORTING ev_error       TYPE string
                               ev_html_string TYPE string.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tb_dev_challenge_week3 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "Get e-mail HTML using ABAP Mustache template
    get_email_html( EXPORTING is_email_data  = get_email_data( )
                        IMPORTING ev_error       = DATA(lv_error)
                                  ev_html_string = DATA(lv_html_string) ).
    IF lv_error IS NOT INITIAL.
      out->write( lv_error ).
    ELSE.
      out->write( lv_html_string ).
    ENDIF.

  ENDMETHOD.

  METHOD get_email_html.

    CONSTANTS: lc_nl TYPE c VALUE cl_abap_char_utilities=>newline.

    TRY.
        DATA(lo_mustcahe) = NEW zcl_mustache(
          '<!DOCTYPE html>'                                 && lc_nl &&
          '<html>'                                          && lc_nl &&
          '  <head>'                                        && lc_nl &&
          '    <title>{{title}}</title>'                    && lc_nl &&
          '  </head>'                                       && lc_nl &&
          '  <body>'                                        && lc_nl &&
          '    <h1>{{title}}</h1>'                          && lc_nl &&
          '    <ul>'                                        && lc_nl &&
          '      {{#people}}'                               && lc_nl &&
          '      <li>{{first_name}} {{last_name}}</li>'     && lc_nl &&
          '      {{/people}}'                               && lc_nl &&
          '    </ul>'                                       && lc_nl &&
          '  </body>'                                       && lc_nl &&
          '</html>' ).

        ev_html_string = lo_mustcahe->render( is_email_data ).
      CATCH zcx_mustache_error INTO DATA(lo_exception).
        ev_error = lo_exception->get_text( ).
    ENDTRY.

  ENDMETHOD.

  METHOD get_email_data.
    rv_email_data = VALUE gty_email_data_s(
        title = 'Hello, here is the list of customers'
        people = VALUE gty_email_people_t(
         ( first_name = 'Marilyn'   last_name = 'Monroe' )
         ( first_name = 'John'      last_name = 'Wick' )
         ( first_name = 'Tomáš'     last_name = 'Masaryk' )
        )
    ).
  ENDMETHOD.

ENDCLASS.
