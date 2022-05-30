# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(stop)   10.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

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
$ns duplex-link $n4 $n0 1.0Mb 10ms DropTail
$ns queue-limit $n4 $n0 50
$ns duplex-link $n3 $n4 1.0Mb 10ms DropTail
$ns queue-limit $n3 $n4 50
$ns duplex-link $n1 $n4 1.0Mb 10ms DropTail
$ns queue-limit $n1 $n4 50
$ns duplex-link $n4 $n2 1.0Mb 10ms DropTail
$ns queue-limit $n4 $n2 50

#Give node position (for NAM)
$ns duplex-link-op $n4 $n0 orient left-up
$ns duplex-link-op $n3 $n4 orient left-up
$ns duplex-link-op $n1 $n4 orient left-down
$ns duplex-link-op $n4 $n2 orient left-down

#===================================
#        Agents Definition        
#===================================
set tcp4 [new Agent/TCP]
$ns attach-agent $n0 $tcp4

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp4 $sink

set udp6 [new Agent/UDP]
$ns attach-agent $n1 $udp6

set null [new Agent/Null]
$ns attach-agent $n2 $null
$ns connect $udp6 $null

#===================================
#	  COLOUR
#===================================

$udp6 set class_ 1
$ns color 1 Orange

$tcp4 set class_ 2
$ns color 2 Green

#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ns at 1.0 "$ftp4 start"
$ns at 2.0 "$ftp4 stop"

#Setup a CBR Application over UDP connection
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp6
$cbr1 set packetSize_ 1000
$cbr1 set rate_ 1.0Mb
$cbr1 set random_ null
$ns at 1.0 "$cbr1 start"
$ns at 2.0 "$cbr1 stop"


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



