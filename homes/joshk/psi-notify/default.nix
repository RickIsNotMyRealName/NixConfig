{...}:
{
  services.psi-notify = {
    enable = true;
    settings = {
      update = "10";
      log_pressures = "false";
      threshold = {
        cpu = "some avg10 50.00";
        memory = "some avg10 10.00";
        io = "full avg10 15.00";
      };
    };
  };
}
