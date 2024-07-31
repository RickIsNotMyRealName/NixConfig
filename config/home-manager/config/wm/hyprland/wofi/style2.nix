''
    /* Revised CSS for a Visually Appealing and Functional Menu */

  /* Base styles for overall consistency and legibility */
  * {
      font-family: 'Your preferred font', sans-serif; /* Choose a font like 'Roboto' or 'Arial' for legibility */
      font-size: 12px; /* A size that's readable yet space-efficient */
      text-align: left; /* Align text for a cleaner look */
  }

  /* Main window styling */
  #window {
      background-color: rgba(--wofi-rgb-color0, 1); /* Solid color for maximum readability */
      border: 1px solid --wofi-color4; /* Define the main window with a subtle border */
      border-radius: 12px; /* Smooth edges that match the design language */
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* A subtle shadow for depth */
  }

  /* Outer box styling */
  #outer-box {
      padding: 20px; /* Generous padding for a spacious layout */
  }

  /* Search bar styling */
  #input {
      background-color: --wofi-color1; /* A shade that stands out against the main window */
      border: none; /* Opting for a clean, borderless input field */
      border-radius: 8px; /* Consistent rounded edges */
      color: --wofi-color15; /* Text color that ensures legibility */
      padding: 10px 15px; /* Balanced padding for the input field */
  }

  /* Scrollable entry list styling */
  #scroll {
      background-color: --wofi-color0; /* Matching the main window for a uniform look */
      border-radius: 12px; /* Continuity in design with rounded corners */
      padding: 10px; /* Consistent internal spacing */
      margin-top: 10px; /* Separate the list from the search bar */
  }

  /* Scrollbar styling */
  scrollbar {
      border-radius: 10px; /* Rounded scrollbar for a consistent look */
  }

  scrollbar slider {
      background-color: --wofi-color8; /* A color that stands out, but not too prominently */
      border-radius: 10px; /* Maintain the rounded theme */
  }

  /* Unselected entry styling */
  #entry {
      background-color: --wofi-color2; /* A slightly lighter color for unselected entries */
      color: --wofi-color15; /* A contrasting color for clear readability */
      padding: 12px 16px; /* Padding that complements the outer box */
      margin-bottom: 4px; /* Space out entries for a cleaner look */
      border-radius: 6px; /* Mildly rounded corners for a softer aesthetic */
  }

  /* Hover effect for entries */
  #entry:hover {
      background-color: --wofi-color3; /* A noticeable change on hover */
      transition: background-color 0.3s; /* Smooth transition for a polished feel */
  }

  /* Selected entry styling */
  #entry:selected {
      background-color: --wofi-color4; /* A distinctly different color for the selected entry */
      color: --wofi-color15; /* Maintaining readability on selection */
      border: 2px solid --wofi-color8; /* A border to highlight the selected entry */
      border-radius: 6px; /* Keeping the design uniform */
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* A subtle shadow to elevate the selected entry */
  }

  /* Entry text styling */
  #text {
      /* Inherits color and alignment from base styles */
      font-weight: 500; /* Slightly bolder text for better readability */
  }

  /* Entry expander box styling */
  #expander-box {
      background-color: --wofi-color2; /* Harmonious with the unselected entries */
      border-radius: 6px; /* Consistent with the entry rounding */
  }

  /* Entry image styling */
  #img {
      border-radius: 6px; /* Rounded images for visual consistency */
      margin-right: 15px; /* Enough space to separate the image from the text */
  }

  /* Focus and accessibility enhancements */
  #entry:focus {
      outline: none; /* Custom focus style instead of the browser default */
      box-shadow: 0 0 0 2px --wofi-color9; /* Focus indicator that's noticeable */
  }



''
