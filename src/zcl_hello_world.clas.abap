class ZCL_HELLO_WORLD definition
  public
  final
  create public .

public section.

  class-methods SAY_HELLO .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HELLO_WORLD IMPLEMENTATION.


  METHOD say_hello.

    "Say Hello World
    MESSAGE 'Hello World'(t01) TYPE 'I'.

  ENDMETHOD.
ENDCLASS.
