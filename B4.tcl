# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(stop)   3.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator -multicast on] ;#enable multicast routing

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

set group [Node allocaddr] ;# Allocate a multicast address
#===================================
#        Nodes Definition        
#===================================
#Create 5 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

#===================================
#        Links Definition        
#===================================
#Createlinks between nodes
$ns duplex-link $n0 $n1 100.0Mb 10ms DropTail
$ns queue-limit $n0 $n1 50
$ns duplex-link $n0 $n2 100.0Mb 10ms DropTail
$ns queue-limit $n0 $n2 50
$ns duplex-link $n0 $n3 100.0Mb 10ms DropTail
$ns queue-limit $n0 $n3 50
$ns duplex-link $n0 $n4 100.0Mb 10ms DropTail
$ns queue-limit $n0 $n4 50

#Give node position (for NAM)
$ns duplex-link-op $n0 $n1 orient left-up
$ns duplex-link-op $n0 $n2 orient right
$ns duplex-link-op $n0 $n3 orient right-down
$ns duplex-link-op $n0 $n4 orient left


set mproto DM ;#Configure multicast protocol
set mrthandle [$ns mrtproto $mproto] ;#all nodes will contain multicast agents 
#===================================
#        Agents Definition        
#===================================
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

$udp0 set dst_addr_ $group
$udp0 set dst_port_ 0
set recv1 [new Agent/LossMonitor] ;#create a receiver agent at node1
$ns attach-agent $n1 $recv1
$ns at 1.9 "$n1 join-group $recv1 $group" ;#join the group at simulation time at 1.9

set recv2 [new Agent/LossMonitor] ;#create a receiver agent at node1
$ns attach-agent $n2 $recv2
$ns at 1.12 "$n2 join-group $recv2 $group" ;#join the group at simulation time at 1.12

set recv3 [new Agent/LossMonitor] ;#create a receiver agent at node1
$ns attach-agent $n3 $recv3
$ns at 1.15 "$n3 join-group $recv3 $group" ;#join the group at simulation time at 2

set recv4 [new Agent/LossMonitor] ;#create a receiver agent at node1
$ns attach-agent $n4 $recv4
$ns at 0.3 "$n4 join-group $recv4 $group" ;#join the group at simulation time at 1.9

$ns at 3.3 "$n4 leave-group $recv4 $group" ;#leave the group at time 0.3

#===================================
#        Applications Definition        
#===================================
#Setup a CBR Application over UDP connection
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1.0Mb
$cbr0 set random_ null
$ns at 1.0 "$cbr0 start"
$ns at 2.0 "$cbr0 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run

