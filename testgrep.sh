#!/bin/bash
x="นี่คือข้อมูลมั่ว ๆ หลายบรรทัด
เช่นชื่อ: John Doe
อีเมล: john.doe@example.com
เบอร์โทร: 0812345678
ข้อมูลเพิ่มเติม: lorem ipsum
อีกอีเมล: alice.smith@gmail.com
จบข้อมูล"
grep -E -o "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" <<< "$x"
