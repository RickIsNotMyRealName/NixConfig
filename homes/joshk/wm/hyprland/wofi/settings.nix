{
  allow_images = true;
  image_size = 25;
  allow_bold = true;

  insensitive = true;
  prompt = "Run: ";
  show = "drun"; # Specifies the mode to run in, 'run' for launching applications.
  location = "center"; # Specifies the location on the screen (center, top, bottom, left, right).
  allow_markup = true; # Allows processing and displaying Pango markup.

  # Miscellaneous
  # gtk_dark = true; # Instructs Wofi to use the dark variant of the current GTK theme, if available.
  dynamic_lines = true; # Dynamically adjusts the Wofi window size based on the number of visible lines.

  # Key bindings
  key_up = "Up"; # Key to move selection up.
  key_down = "Down"; # Key to move selection down.
  key_submit = "Return"; # Key to submit the selected action.
  key_exit = "Escape"; # Key to exit Wofi.
  key_expand = "Tab"; # Key to expand the current selection.


  # Sorting and filtering
  matching = "fuzzy"; # contains, multi-contains, fuzzy.
  sort_order = "default"; # default, alphabetical.

  width = "30%";
}
