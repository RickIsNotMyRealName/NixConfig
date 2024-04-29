''
      /*

      # Colors
        The  colors  file should be formatted as new line separated hex values. These values should  be  in the  standard  HTML format and begin with a hash. These colors will be loaded however wofi  doesn't know  what  color  should be used for what so you must reference them from your CSS.

        You can reference these from your  CSS  by  doing --wofi-color<n> where <n> is the line number - 1. For  example to reference the color on line 1 you would do --wofi-color0.

        The  colors  can  also  be  referenced  by  doing --wofi-rgb-color<n>  where <n> is the line number - 1. The difference between these is  the  format used to replace the macro.

        --wofi-color<n>  is  replaced  with an HTML color code in the format  #FFFFFF.  --wofi-rgb-color<n> is  replaced  with  comma separated rgb values in the format 255, 255, 255. The  correct  usage  of --wofi-rgb-color<n>  is  to  wrap  it in rgb() or rgba(). Note that it does  not  return  an  alpha value  so combining it with rgba() should be done like so rgba(--wofi-rgb-color0, 0.8). This  would set the color to line 1 with an opacity of 80%.

        # CSS SELECTORS
             Any  GTK widget can be selected by using the name of its CSS node, these however might change  with updates  and are not guaranteed to stay constant.
             Wofi also provides certain widgets with names and classes which can be referenced from CSS to  give access  to  the  most  important  widgets easily.
             wofi(7) contains the current widget  layout  used by  wofi  so if you want to get into CSS directly using GTK widget names look there for info.

             #window
                    The name of the window itself.

             #outer-box
                    The name of the box that  contains  everything.

             #input
                    The name of the search bar.

             #scroll
                    The name of the scrolled window containing all of the entries.

             #inner-box
                    The  name of the box containing all of the entries.

             #img
                    The name of all  images  in  entries  displayed in image mode.

             #text
                    The name of all the text in entries.

             #unselected
                    The  name  of  all entries currently unselected. A better way of doing this  is  to do #entry and combine that with #entry:selected

             #selected
                    The  name  of  all  entries  currently selected. A better way of doing this  is  to do #entry:selected

             .entry
                    The class attached to all entries. This is attached to the inside property box and is old, you probably want #entry instead

             #entry
                    The name of all entries.

             #expander-box
                    The name of all boxes shown when expanding entries with multiple actions

        # Wofi css file
        - We are using wal colors so we can use --wofi-color1 to --wofi-color15 for colors.
        - We can use --wofi-rgb-color1 to --wofi-rgb-color15 for rgb colors.
        - We can use #window, #outer-box, #input, #scroll, #inner-box, #img, #text, #unselected, #selected, .entry, #entry, #expander-box for css selectors.

        color0: background color
        color4: border color
        color15: text color


      */

  /*
  color0: background color
  color4: border color
  color15: text color
  */

    /* General Window Styling */
    #window {
        /* Background color */
        background-color: --wofi-color0; 

        /* Text color */
        color: --wofi-color15; 

        /* Border color */
        border: 2px solid --wofi-color4;

        /* Border radius */
        border-radius: 10px;
    }

    #outer-box {
        padding: 10px;
    }

    /* Search Bar Styling */
    #input {
        /* Background color */
        background-color: --wofi-color0;

        /* Border color */
        border: 2px solid --wofi-color4; 

        /* Border radius */
        border-radius: 10px;

        /* Text color */
        color: --wofi-color15;
    }

    /* Scrollable Entry List Styling */
    #scroll {
        /* Background color */
        background-color: --wofi-color0; 

        /* Border color */
        border: 2px solid --wofi-color4; 
      
        /* Border radius */
        border-radius: 10px;
      
        /* Padding */
        padding: 5px;
      
        /* Margin y */
        margin-top: 10px; 
    }

    /* Unselected Entry Styling */
    #entry {
      
    }

    /* Selected Entry Styling */
    #entry:selected {
        /* Background color */
        background-color: --wofi-color4; 

        /* Text color */
        color: --wofi-color15; 

        /* Border radius */
        border-radius: 10px;

        /* Border color */
        border: 2px solid --wofi-color4;
    }



    /* Entry Image Styling */
    #img {
        /* Border radius */
        border-radius: 10px;

        /* Margin */
        margin-right: 10px;
    }

    /* Entry Text Styling */
    #text {
        /* Text color */
        color: --wofi-color15; 
    }

    /* Entry Expander Box Styling */
    #expander-box {
        /* Background color */
        background-color: --wofi-color0; 

        /* Border color 
        border: 2px solid --wofi-color4; */

        /* Border radius */
        border-radius: 10px;
    }

    /* Entry Expander Button Styling */
  
''
