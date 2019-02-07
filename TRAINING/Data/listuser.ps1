$checktime = (get-date).adddays(-30)
get-aduser -searchbase "OU=MISA Users,DC=rm,DC=local" -Properties whencreated -filter {whencreated -ge $checktime} |ft name,whencreated > c:\new\listuser.csv