{ config, pkgs, ... }:
let
  hibernateEnvironment = {
    HIBERNATE_SECONDS = "1800";
    HIBERNATE_LOCK = "/var/run/autohibernate.lock";
  };
in
{
  systemd.services."awake-after-suspend-for-a-time" = {
    description = "Sets up the suspend so that it'll wake for hibernation";
    wantedBy = [ "suspend.target" ];
    before = [ "systemd-suspend.service" ];
    environment = hibernateEnvironment;
    script = ''
      curtime=$(date +%s)
      echo "$curtime $1" >> /tmp/autohibernate.log
      echo "$curtime" > $HIBERNATE_LOCK
      ${pkgs.utillinux}/bin/rtcwake -m no -s $HIBERNATE_SECONDS

      echo "Sleeping for $HIBERNATE_SECONDS seconds before hibernating"
    '';
    serviceConfig.Type = "simple";
  };
  systemd.services."hibernate-after-recovery" = {
    description = "Hibernates after a suspend recovery due to timeout";
    wantedBy = [ "suspend.target" ];
    after = [ "systemd-suspend.service" ];
    environment = hibernateEnvironment;
    script = ''
      curtime=$(date +%s)
      sustime=$(cat $HIBERNATE_LOCK)
      rm $HIBERNATE_LOCK
      if [ $(($curtime - $sustime)) -ge $HIBERNATE_SECONDS ] ; then
        echo "Hibernated after $HIBERNATE_SECONDS seconds of suspend"
        systemctl hibernate
      else
        ${pkgs.utillinux}/bin/rtcwake -m no -s 1
        echo "Sleeping for 1 second before hibernating"
        echo "Other info for debugging:"
        echo "Current time: $curtime"
        echo "Suspend time: $sustime"
        echo "Difference: $(($curtime - $sustime))"
        echo "Hibernate time: $HIBERNATE_SECONDS"
      fi
    '';
    serviceConfig.Type = "simple";
  };
}
