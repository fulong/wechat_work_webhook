#!/usr/bin/expect
set timeout 36000
set host [lindex $argv 0]
set username [lindex $argv 1]
set password [lindex $argv 2]
set dest_file [lindex $argv 3]
set port [lindex $argv 4]
spawn ssh $username@$host
expect {
 "*assword:"
  {
    send "$password\n"
    expect "$username@" { send "gdbserver :$port $dest_file > /opt/gdbserver.txt 2>&1 &\n"}
    expect "$username@" { send "exit 0\n"}
  }    
}
expect "100%"
expect eof
