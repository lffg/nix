{...}: {
  home.file = {
    # Disable session restoration funcionality.
    # See <https://superuser.com/q/1106832>
    ".bash_sessions_disable".text = "";

    # Disable last login message on start.
    # See <https://stackoverflow.com/q/15769615>
    ".hushlogin".text = "";
  };
}
