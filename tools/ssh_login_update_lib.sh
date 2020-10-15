#!/usr/bin/expect
set timeout 36000
set host [lindex $argv 0]
set username [lindex $argv 1]
set password [lindex $argv 2]
spawn ssh $username@$host
expect {
 "*assword:"
  {
    send "$password\n"
    expect "$username@" { send "wget http://file.eiot.mobi/libstdc++.so.6.0.24-gdb.py\n"}
    expect "$username@" { send "wget http://file.eiot.mobi/libstdc++.so.6.0.24\n"}
    expect "$username@" { send "mv libstdc++.so.6.0.24* /usr/lib/arm-linux-gnueabihf/\n"}
    expect "$username@" { send "rm /usr/lib/arm-linux-gnueabihf/libstdc++.so.6\n"}
    expect "$username@" { send "ln -s /usr/lib/arm-linux-gnueabihf/libstdc++.so.6.0.24 /usr/lib/arm-linux-gnueabihf/libstdc++.so.6\n"}
    expect "$username@" { send "exit 0\n"}
  }    
}
expect "100%"
expect eof