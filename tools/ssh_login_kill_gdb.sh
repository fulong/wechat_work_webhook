#!/usr/bin/expect
set timeout 10
set host [lindex $argv 0]
set username [lindex $argv 1]
set password [lindex $argv 2]
set dest_file [lindex $argv 3]
spawn ssh $username@$host
expect {
 "(yes/no)?"
  {
    send "yes\n"
    expect "*assword:" { send "$password\n"}
    expect "$username@" { send "pid=`ps x | grep $dest_file | grep -v grep | awk '\{print \$1\}'`\n"}
    expect "$username@" { send "kill \$pid\n"}
    expect "$username@" { send "exit 0\n"}

  }
 "*assword:"
  {
    send "$password\n"
    expect "$username@" { send "pid=`ps x | grep $dest_file | grep -v grep | awk '\{print \$1\}'`\n"}
    expect "$username@" { send "kill \$pid\n"}
    expect "$username@" { send "exit 0\n"}
  }
}
expect "100%"
expect eof