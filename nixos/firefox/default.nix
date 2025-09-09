{
  enable = true;
  profiles = {
    lw-default = {
      isDefault = true;
      # search.default = "Google";
      settings = {
        # For TreeStyleTabs
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
        /* Hide top tab bar */
        #TabsToolbar {
          visibility: collapse !important;
        }

        /* Hide sidebar title */
        #sidebar-header { display: none; }
      '';
    };
  };
}
