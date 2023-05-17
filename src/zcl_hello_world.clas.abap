class ZCL_HELLO_WORLD definition
  public
  final
  create public .

public section.

  class-methods SAY_SOMETHING
    importing
      !IV_WORDS type STRING default 'Hello World' .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HELLO_WORLD IMPLEMENTATION.


  METHOD say_something.

    "Say something
    MESSAGE iv_words TYPE 'I'.

  ENDMETHOD.
ENDCLASS.
