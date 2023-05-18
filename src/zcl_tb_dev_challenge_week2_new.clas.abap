CLASS zcl_tb_dev_challenge_week2_new DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_serializable_object .
    INTERFACES z2ui5_if_app .

    DATA: gv_user TYPE sy-uname,
          gv_date TYPE sy-datum.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tb_dev_challenge_week2_new IMPLEMENTATION.


  METHOD z2ui5_if_app~main.
*   NOTE: TBURYANEK - Test handler for ABAP2UI5
*         SAP Developer Code Challenge – Open-Source ABAP (Week 2)
*         https://groups.community.sap.com/t5/application-development/sap-developer-code-challenge-open-source-abap-week-2/td-p/260727

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      gv_date = sy-datum.
      gv_user = 'Tomas'.
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        DATA(lv_date_out) = |{ gv_date DATE = USER }|.
        client->popup_message_toast(
            |Response from server, values: { lv_date_out } { gv_user }|
          ).
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-id_prev_app_stack  ) ).
    ENDCASE.

    client->set_next( VALUE #( xml_main = z2ui5_cl_xml_view=>factory(
        )->shell(
        )->page(
                title          = 'abap2UI5 - ABAP Week 2 challenge'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = abap_true
            )->header_content(
                )->link(
                    text = 'Source_Code'
                    href = z2ui5_cl_xml_view=>hlp_get_source_code_url( app = me get = client->get( ) )
                    target = '_blank'
            )->get_parent(
            )->simple_form( title = 'Enter values and send them to SAP server (ABAP)' editable = abap_true
                )->content( 'form'
                    )->title( 'Input'
                    )->label( 'User'
                    )->input( value = client->_bind( gv_user )
                    )->label( 'Date'
                    )->input( value = client->_bind( gv_date )
                    )->button(
                        text  = 'post'
                        press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ) ).

  ENDMETHOD.
ENDCLASS.
