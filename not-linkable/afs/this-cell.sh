cat /etc/openafs/CellServDB | grep -A 3 cs.stanford.edu | tr -d '>' > /etc/openafs/ThisCell
