#!/bin/sh

## Inspired from the script found at
##   https://sanjeevan.co.uk/blog/running-services-inside-a-container-using-runit-and-alpine-linux/

shutdown() {
  echo "shutting down container"

  # first shutdown any service started by runit
  for _srv in $(ls -1 /etc/service); do
    sv force-stop $_srv
  done

  # shutdown runsvdir command
  kill -HUP $RUNSVDIR
  wait $RUNSVDIR

  # give processes time to stop
  sleep 0.5

  # kill any other processes still running in the container
  for _pid  in $(ps -eo pid | grep -v PID  | tr -d ' ' | grep -v '^1$' | head -n -6); do
    timeout -t 5 /bin/sh -c "kill $_pid && wait $_pid || kill -9 $_pid"
  done
  exit
}

PATH="${PATH}:/usr/local/bin"

## check services to disable
for _srv in $(ls -1 /etc/service); do
    eval X=$`echo -n $_srv | tr [:lower:]- [:upper:]_`_DISABLED
    [ -n "$X" ] && touch /etc/service/$_srv/down
done

# chown logrotate fle (#111)
chown 0644 /etc/logrotate.d/*

exec runsvdir -P /etc/service &
RUNSVDIR=$!
echo "Started runsvdir, PID is $RUNSVDIR"
echo "wait for processes to start...."

sleep 5
for _srv in $(ls -1 /etc/service); do
    sv status $_srv
done

# catch shutdown signals
trap shutdown SIGTERM SIGHUP SIGQUIT SIGINT
wait $RUNSVDIR

shutdown
