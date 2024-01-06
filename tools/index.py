import datetime
import os.path
import subprocess
import sys
from xml.dom import minidom
from zoneinfo import ZoneInfo

template = """
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>HCÉRES 2024</title>
</head>
<body>
    <pre></pre>
    <ul></ul>
</body>
</html>
"""

doc = minidom.parseString(template)

pre, = doc.getElementsByTagName("pre")
gitlog = subprocess.run(["git", "log", "-1"], capture_output=True)
pre.appendChild(doc.createTextNode(gitlog.stdout.decode()))

ul, = doc.getElementsByTagName("ul")
for pdf in sys.argv[1:]:
    log = pdf.removesuffix(".pdf") + ".log"
    mtime = datetime.datetime.fromtimestamp(os.path.getmtime(log),
                                            ZoneInfo("Europe/Paris"))
    time = mtime.isoformat(" ", timespec="seconds")
    item = minidom.parseString(
        f"<li>{time} <a href='{log}'>log</a> <a href='{pdf}'>{pdf}</a></li>")
    ul.appendChild(item.documentElement)
print(doc.toprettyxml())
