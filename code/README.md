Downloaded mothur v.1.48.0 (for Windows) from https://github.com/mothur/mothur/releases/tag/v1.48.0 on 16 September 2022.

Automated downloading and installing mothur files with `curl` (would be `wget`
on Linux) and `unzip`:
```
curl -kL https://github.com/mothur/mothur/releases/download/v1.48.0/Mothur.win.zip
 -o code/mothur/Mothur.win.zip
unzip -n -d code/mothur code/mothur/Mothur.win.zip
rm code/mothur/Mothur.win.zip
```
