#!/bin/bash
if [ -f ./website/index2.html ]; then
        mv website/index.html website/index_tmp.html
        mv website/index2.html website/index.html
        mv website/index3.html website/index2.html
        mv website/index4.html website/index3.html
        mv website/index_tmp.html website/index4.html
        echo update executed
fi
