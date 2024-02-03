{pkgs, ...}: {
  home.sessionVariables = {
    PGHOST = "localhost";
    PGPORT = "5432";
  };

  # TODO: Add `pg_init` util, using script bin pkg.
  home.packages = with pkgs; [
    postgresql_15
  ];
}
