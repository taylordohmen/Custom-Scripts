#!/bin/bash

btsname="bluez_sink.08_DF_1F_A7_E7_34"

#gets the number of the desired sink
sink="$(pactl list sinks short | grep "$btsname" | awk '{print $1}')"

#exits if the desired sink is not in the sink collection
if [ -z $sink ]
then
	exit 0
fi

#gets collection of sink-input numbers
sinkinputs="$(pactl list sink-inputs short | awk '{print $1}')"

#sets all sink-inputs to sink where name == btsname
for si in $sinkinputs
do
	pactl move-sink-input $si $sink
done

pactl set-default-sink $btsname
