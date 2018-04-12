#!/bin/bash
if [ -f ./index2.html ]; then
        mv index.html index_tmp.html
        mv index2.html index.html
        mv index3.html index2.html
        mv index4.html index3.html
        mv index_tmp.html index4.html
fi
